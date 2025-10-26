import 'package:flutter/material.dart';
import 'package:madg28/models/mockapi.dart';
import 'package:madg28/models/program.dart';

class ProgramDetailNotifier extends ChangeNotifier {
  final MockApiService _apiService = MockApiService();

  Program? _program;
  bool _isLoading = true;

  Program? get program => _program;
  bool get isLoading => _isLoading;

  Future<void> fetchProgramDetails(String programId) async {
    _isLoading = true;
    notifyListeners();
    _program = await _apiService.getProgramById(programId);
    _isLoading = false;
    notifyListeners();
  }
}
