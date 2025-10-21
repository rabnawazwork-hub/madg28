
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

  Lesson({
    required this.id,
    required this.title,
    required this.duration,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
    );
  }
}
