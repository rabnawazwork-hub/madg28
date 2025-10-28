
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:madg28/notifiers/program_detail_notifier.dart'; // Reusing for now, will create a dedicated one if needed
import 'package:madg28/models/program.dart';
import 'package:madg28/screens/program_detail_screen.dart';

class EnrolledCoursesScreen extends StatefulWidget {
  const EnrolledCoursesScreen({super.key});

  @override
  State<EnrolledCoursesScreen> createState() => _EnrolledCoursesScreenState();
}

class _EnrolledCoursesScreenState extends State<EnrolledCoursesScreen> {
  @override
  void initState() {
    super.initState();
    // In a real app, you would fetch enrolled courses for the current user
    // For now, we'll just use the mock API's enrolled courses
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrolled Courses'),
        centerTitle: true,
      ),
      body: Consumer<ProgramDetailNotifier>( // Using ProgramDetailNotifier for now
        builder: (context, notifier, child) {
          // In a real app, you would have a dedicated notifier for enrolled courses
          // For now, we'll fetch from the mock API directly
          return FutureBuilder<List<EnrolledCourse>>(
            future: notifier.apiService.getEnrolledCourses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'You have not enrolled in any courses yet.',
                    style: textTheme.titleMedium,
                  ),
                );
              } else {
                final enrolledCourses = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: enrolledCourses.length,
                  itemBuilder: (context, index) {
                    final course = enrolledCourses[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProgramDetailScreen(programId: course.id),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  image: course.imageUrl.startsWith('http')
                                      ? NetworkImage(course.imageUrl)
                                      : AssetImage(course.imageUrl) as ImageProvider,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.name,
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Instructor: ${course.instructor}',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: course.progress,
                                      backgroundColor: colorScheme.primaryContainer,
                                      color: colorScheme.primary,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Progress: ${(course.progress * 100).toInt()}%',
                                      style: textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
