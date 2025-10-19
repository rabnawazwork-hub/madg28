
import 'dart:convert';
import 'package:madg28/models/program.dart';

class MockApiService {
  static const String _mockData = '''
  {
    "programs": [
      {
        "id": "1",
        "name": "Flutter for Beginners",
        "description": "A comprehensive course for beginners to learn Flutter.",
         "imageUrl": "assets/images/flutter.png",
        "lessons": [
          {
            "id": "101",
            "title": "Introduction to Flutter",
            "duration": "10:00"
          },
          {
            "id": "102",
            "title": "Widgets and Layouts",
            "duration": "25:00"
          }
        ]
      },
      {
        "id": "2",
        "name": "Advanced Flutter",
        "description": "Take your Flutter skills to the next level.",
        "imageUrl": "assets/images/advance_flutter.png",
        "lessons": [
          {
            "id": "201",
            "title": "State Management",
            "duration": "30:00"
          },
          {
            "id": "202",
            "title": "Animations",
            "duration": "20:00"
          }
        ]
      }
    ]
  }
  ''';

  Future<List<Program>> getPrograms() async {
    final data = json.decode(_mockData);
    final List<dynamic> programList = data['programs'];
    return programList.map((json) => Program.fromJson(json)).toList();
  }
}
