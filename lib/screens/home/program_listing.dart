import 'package:flutter/material.dart';
import 'package:madg28/notifiers/programs_notifier.dart';
import 'package:madg28/screens/program_detail_screen.dart';
import 'package:madg28/screens/search/search_screen.dart';
import 'package:madg28/screens/course/enrolled_courses_screen.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgramsNotifier>(context, listen: false).fetchPrograms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Courses"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.school),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EnrolledCoursesScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProgramsNotifier>(
        builder: (context, notifier, child) {
          return Skeletonizer(
            enabled: notifier.isLoading,
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: notifier.isLoading ? 6 : notifier.programs.length,
              itemBuilder: (context, index) {
                final program = notifier.isLoading
                    ? null
                    : notifier.programs[index];
                return GestureDetector(
                  onTap: () {
                    if (program != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProgramDetailScreen(programId: program.id),
                        ),
                      );
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'program-${program?.id ?? index}',
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Image(
                              image: program?.imageProvider ?? AssetImage('assets/images/placeholder.png'),
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                program?.name ?? "Program Name",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Instructor: ${program?.instructor ?? "Instructor"}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                    (i) => Icon(
                                      Icons.star,
                                      color: i < (program?.rating.floor() ?? 0)
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${program?.rating ?? 0.0}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
