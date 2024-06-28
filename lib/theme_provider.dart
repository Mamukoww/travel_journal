import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _sortByDate = true;

  ThemeMode get themeMode => _themeMode;
  bool get sortByDate => _sortByDate;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleSortOrder(bool isSortByDate) {
    _sortByDate = isSortByDate;
    notifyListeners();
  }
}
