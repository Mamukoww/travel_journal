import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/trip_details_screen.dart';
import 'screens/add_edit_trip_screen.dart';
import 'screens/photo_view_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/tripDetails': (context) => TripDetailsScreen(),
        '/addEditTrip': (context) => AddEditTripScreen(),
        '/photoView': (context) => PhotoViewScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
