
import 'dart:convert';
import 'package:flutter/material.dart';

class Program {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String instructor;
  final String level;
  final String duration;
  final double rating;
  final List<String> whatYouWillLearn;
  final List<Lesson> lessons;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.instructor,
    required this.level,
    required this.duration,
    required this.rating,
    required this.whatYouWillLearn,
    required this.lessons,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      instructor: json['instructor'],
      level: json['level'],
      duration: json['duration'],
      rating: json['rating'].toDouble(),
      whatYouWillLearn: List<String>.from(json['whatYouWillLearn']),
      lessons: (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
  }

  ImageProvider get imageProvider {
    if (imageUrl.startsWith('data:image')) {
      // Base64 image
      final String base64String = imageUrl.split(',').last;
      return MemoryImage(base64Decode(base64String));
    } else if (imageUrl.startsWith('http')) {
      // Network image
      return NetworkImage(imageUrl);
    } else if (imageUrl.isNotEmpty) {
      // Asset image (assuming it's a valid asset path)
      return AssetImage(imageUrl);
    } else {
      // Placeholder image
      return const AssetImage('assets/images/logo.png');
    }
  }
}

class Lesson {
  final String id;
  final String title;
  final String duration;
  final List<CourseFeedback> feedback;

  Lesson({
    required this.id,
    required this.title,
    required this.duration,
    this.feedback = const [],
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      feedback: (json['feedback'] as List?)
              ?.map((f) => CourseFeedback.fromJson(f))
              .toList() ??
          const [],
    );
  }
}

class CourseFeedback {
  final String userId;
  final double rating;
  final String comment;
  final DateTime date;

  CourseFeedback({
    required this.userId,
    required this.rating,
    required this.comment,
    required this.date,
  });

  factory CourseFeedback.fromJson(Map<String, dynamic> json) {
    return CourseFeedback(
      userId: json['userId'],
      rating: json['rating'].toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}

class EnrolledCourse {
  final String id;
  final String name;
  final String imageUrl;
  final String instructor;
  final double progress;
  final DateTime enrollmentDate;

  EnrolledCourse({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.instructor,
    this.progress = 0.0,
    required this.enrollmentDate,
  });

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) {
    return EnrolledCourse(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      instructor: json['instructor'],
      progress: json['progress']?.toDouble() ?? 0.0,
      enrollmentDate: DateTime.parse(json['enrollmentDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'instructor': instructor,
      'progress': progress,
      'enrollmentDate': enrollmentDate.toIso8601String(),
    };
  }
}
