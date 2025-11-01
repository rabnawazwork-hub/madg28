import 'dart:io';

import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'Username';
  String _email = 'user@gmail.com';
  String? _imagePath; // path or URL of profile image

  String get name => _name;
  String get email => _email;
  String? get imagePath => _imagePath;

  void setUser({
    required String name,
    required String email,
    String? imagePath,
  }) {
    _name = name;
    _email = email;
    _imagePath = imagePath;
    notifyListeners();
  }

  void clearUser() {
    _name = 'Username';
    _email = 'user@gmail.com';
    _imagePath = '';
    notifyListeners();
  }
}
