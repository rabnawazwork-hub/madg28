import 'package:flutter/material.dart';
import 'package:madg28/models/mockapi.dart';
import 'package:madg28/models/program.dart';

class ProgramsNotifier extends ChangeNotifier {
  final MockApiService _apiService = MockApiService();

  List<Program> _programs = [];
  bool _isLoading = true;

  List<Program> get programs => _programs;
  bool get isLoading => _isLoading;

  Future<void> fetchPrograms() async {
    _isLoading = true;
    _programs = await _apiService.getPrograms();
    _isLoading = false;
    notifyListeners();
  }
}
