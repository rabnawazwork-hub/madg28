
class Program {
  final String id;
  final String name;
  final String description;
  final String imageUrl; 
  final List<Lesson> lessons;

  Program({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.lessons,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      lessons: (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
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
