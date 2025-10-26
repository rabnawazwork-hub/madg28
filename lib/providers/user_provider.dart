import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = 'Username';
  String _email = 'user@gmail.com';

  String get name => _name;
  String get email => _email;

  void setUser({required String name, required String email}) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  void clearUser() {
    _name = 'Username';
    _email = 'user@gmail.com';
    notifyListeners();
  }
}
