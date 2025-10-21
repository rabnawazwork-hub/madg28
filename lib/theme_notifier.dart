import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier(this._themeMode);

  void toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  static Future<ThemeMode> getThemeModeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('themeMode');
    if (theme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }
}
