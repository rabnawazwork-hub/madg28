
import 'package:flutter/material.dart';
import 'package:madg28/models/program.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final Program program;

  const ProgramDetailsScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(program.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Lessons',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: program.lessons.length,
                itemBuilder: (context, index) {
                  final lesson = program.lessons[index];
                  return ListTile(
                    title: Text(lesson.title),
                    trailing: Text(lesson.duration),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
