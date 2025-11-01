
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:madg28/models/program.dart';

class MockApiService {
  List<Program> _programsData = [];
  final List<EnrolledCourse> _enrolledCourses = [];

  Future<void> _loadPrograms() async {
    if (_programsData.isEmpty) {
      final String response = await rootBundle.loadString('assets/data/programs.json');
      final data = await json.decode(response);
      final List<dynamic> programList = data['programs'];
      _programsData = programList.map((json) => Program.fromJson(json)).toList();
    }
  }

  Future<List<Program>> getPrograms() async {
    await _loadPrograms();
    return _programsData;
  }

  Future<Program> getProgramById(String id) async {
    await _loadPrograms();
    return _programsData.firstWhere((program) => program.id == id);
  }

  Future<void> submitFeedback(String programId, String lessonId, CourseFeedback feedback) async {
    await _loadPrograms();
    final programIndex = _programsData.indexWhere((p) => p.id == programId);
    if (programIndex != -1) {
      final lessonIndex = _programsData[programIndex].lessons.indexWhere((l) => l.id == lessonId);
      if (lessonIndex != -1) {
        // Create a new Lesson object with updated feedback list
        final updatedLessons = List<Lesson>.from(_programsData[programIndex].lessons);
        final currentLesson = updatedLessons[lessonIndex];
        final updatedFeedback = List<CourseFeedback>.from(currentLesson.feedback)..add(feedback);
        updatedLessons[lessonIndex] = Lesson(
          id: currentLesson.id,
          title: currentLesson.title,
          duration: currentLesson.duration,
          feedback: updatedFeedback,
        );

        // Create a new Program object with updated lessons list
        _programsData[programIndex] = Program(
          id: _programsData[programIndex].id,
          name: _programsData[programIndex].name,
          description: _programsData[programIndex].description,
          imageUrl: _programsData[programIndex].imageUrl,
          instructor: _programsData[programIndex].instructor,
          level: _programsData[programIndex].level,
          duration: _programsData[programIndex].duration,
          rating: _programsData[programIndex].rating, // Rating is not updated here, will be handled separately if needed
          whatYouWillLearn: _programsData[programIndex].whatYouWillLearn,
          lessons: updatedLessons,
        );
      }
    }
  }

  Future<void> submitCourseFeedback(String programId, CourseFeedback feedback) async {
    await _loadPrograms();
    final programIndex = _programsData.indexWhere((p) => p.id == programId);
    if (programIndex != -1) {
      final updatedFeedback = List<CourseFeedback>.from(_programsData[programIndex].feedback)..add(feedback);
      _programsData[programIndex] = Program(
        id: _programsData[programIndex].id,
        name: _programsData[programIndex].name,
        description: _programsData[programIndex].description,
        imageUrl: _programsData[programIndex].imageUrl,
        instructor: _programsData[programIndex].instructor,
        level: _programsData[programIndex].level,
        duration: _programsData[programIndex].duration,
        rating: _programsData[programIndex].rating, // Rating is not updated here, will be handled separately if needed
        whatYouWillLearn: _programsData[programIndex].whatYouWillLearn,
        lessons: _programsData[programIndex].lessons,
        feedback: updatedFeedback,
      );
    }
  }

  Future<void> enrollCourse(Program program) async {
    await _loadPrograms();
    if (!_enrolledCourses.any((course) => course.id == program.id)) {
      _enrolledCourses.add(EnrolledCourse(
        id: program.id,
        name: program.name,
        imageUrl: program.imageUrl,
        instructor: program.instructor,
        enrollmentDate: DateTime.now(),
      ));
    }
  }

  Future<List<EnrolledCourse>> getEnrolledCourses() async {
    await _loadPrograms();
    return _enrolledCourses;
  }

  Future<bool> isCourseEnrolled(String programId) async {
    await _loadPrograms();
    return _enrolledCourses.any((course) => course.id == programId);
  }
}
