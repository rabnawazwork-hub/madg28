
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'Username';
  String _email = 'user@gmail.com';
  String? _imagePath; // path or URL of profile image

  String get name => _name;
  String get email => _email;
  String? get imagePath => _imagePath;

  UserProvider() {
    loadFromPrefs();
  }

  void setUser({
    required String name,
    required String email,
    String? imagePath,
  }) {
    _name = name;
    _email = email;
    _imagePath = imagePath;
    _saveToPrefs();
    notifyListeners();
  }

  void clearUser() {
    _name = 'Username';
    _email = 'user@gmail.com';
    _imagePath = '';
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
    await prefs.setString('email', _email);
    await prefs.setString('imagePath', _imagePath ?? '');
  }

  Future<void> loadFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? 'Username';
    _email = prefs.getString('email') ?? 'user@gmail.com';
    _imagePath = prefs.getString('imagePath');
    notifyListeners();
  }
}
