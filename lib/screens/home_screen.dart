import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'add_edit_trip_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Trip> _trips = [
    Trip(
      title: 'Поездка в Париж',
      date: '2024-01-01',
      description: 'Прекрасная поездка в Париж.',
      photoUrl: 'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Trip(
      title: 'Поездка в Лондон',
      date: '2024-02-02',
      description: 'Замечательная поездка в Лондон.',
      photoUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Trip(
      title: 'Поездка в Нью-Йорк',
      date: '2020-02-20',
      description: 'Фантастическая поездка в Нью-Йорк.',
      photoUrl: 'https://images.unsplash.com/photo-1516893842880-5d8aada7ac05?q=80&w=2864&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
  ];

  void _addNewTrip(Trip trip) {
    setState(() {
      _trips.add(trip);
    });
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
            subtitle: Text(_formatDate(sortedTrips[index].date)),
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
