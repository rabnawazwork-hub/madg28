import 'package:flutter/material.dart';
import 'package:madg28/models/mockapi.dart';
import 'package:madg28/models/program.dart';

class ProgramDetailNotifier extends ChangeNotifier {
  final MockApiService _apiService = MockApiService();

  MockApiService get apiService => _apiService;

  Program? _program;
  bool _isLoading = true;

  bool _isEnrolled = false;

  Program? get program => _program;
  bool get isLoading => _isLoading;
  bool get isEnrolled => _isEnrolled;

  Future<void> fetchProgramDetails(String programId) async {
    _isLoading = true;
    _program = await _apiService.getProgramById(programId);
    _isEnrolled = await _apiService.isCourseEnrolled(programId);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> enrollInCourse() async {
    if (_program == null) return;
    await _apiService.enrollCourse(_program!);
    _isEnrolled = true;
    notifyListeners();
  }

  Future<void> submitFeedback(String lessonId, CourseFeedback feedback) async {
    if (_program == null) return;
    await _apiService.submitFeedback(_program!.id, lessonId, feedback);
    await fetchProgramDetails(_program!.id); // Re-fetch to update UI
  }
}
