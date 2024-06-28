import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Темная тема'),
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
            SwitchListTile(
              title: Text('Сортировать по дате'),
              value: themeProvider.sortByDate,
              onChanged: (value) {
                themeProvider.toggleSortOrder(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
