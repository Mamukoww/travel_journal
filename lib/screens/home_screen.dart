import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'add_edit_trip_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Trip> _trips = [];

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tripsJson = prefs.getString('trips');
    if (tripsJson != null) {
      List<dynamic> tripsList = jsonDecode(tripsJson);
      _trips = tripsList.map((json) => Trip.fromJson(json)).toList();
    }
    setState(() {});
  }

  Future<void> _saveTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tripsJson = _trips.map((trip) => jsonEncode(trip.toJson())).toList();
    await prefs.setString('trips', jsonEncode(tripsJson));
  }

  Future<void> _fetchWeather(Trip trip) async {
    // Здесь должна быть логика получения погоды по сети
    // Например, вызов API погоды
    await Future.delayed(Duration(seconds: 2)); // Эмуляция задержки сети
    trip.weather = 'Солнечно 25°C'; // Пример данных о погоде
    await _saveTrips(); // Сохранение обновленного списка поездок
  }

  void _addNewTrip(Trip trip) async {
    setState(() {
      _trips.add(trip);
    });
    await _fetchWeather(trip); // Загрузка погоды для новой поездки
    await _saveTrips(); // Сохранение обновленного списка поездок
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    List<Trip> sortedTrips = List.from(_trips);
    sortedTrips.sort((a, b) {
      if (themeProvider.sortByDate) {
        return DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
      } else {
        return a.title.compareTo(b.title);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Путевой журнал'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: sortedTrips.isEmpty
          ? Center(child: Text('Нет поездок'))
          : ListView.builder(
        itemCount: sortedTrips.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sortedTrips[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formatDate(sortedTrips[index].date)),
                Text(sortedTrips[index].weather),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/tripDetails',
                arguments: sortedTrips[index],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newTrip = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditTripScreen()),
          );
          if (newTrip != null && newTrip is Trip) {
            _addNewTrip(newTrip);
          }
        },
      ),
    );
  }
}
