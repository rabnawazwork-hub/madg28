import 'package:flutter/material.dart';
import 'package:madg28/notifiers/programs_notifier.dart';
import 'package:madg28/screens/program_detail_screen.dart';
import 'package:madg28/screens/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch programs when the widget is first created
    Provider.of<ProgramsNotifier>(context, listen: false).fetchPrograms();
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
        ],
      ),
      body: Consumer<ProgramsNotifier>(
        builder: (context, notifier, child) {
          if (notifier.isLoading) {
            return SkeletonTheme(
              themeMode: ThemeMode.light,
              shimmerGradient: const LinearGradient(
                colors: [
                  Color(0xFFD8E3E7),
                  Color(0xFFC8D5DA),
                  Color(0xFFD8E3E7),
                ],
                stops: [
                  0.1,
                  0.5,
                  0.9,
                ],
              ),
              darkShimmerGradient: const LinearGradient(
                colors: [
                  Color(0xFF222222),
                  Color(0xFF242424),
                  Color(0xFF2B2B2B),
                  Color(0xFF242424),
                  Color(0xFF222222),
                ],
                stops: [
                  0.0,
                  0.2,
                  0.5,
                  0.8,
                  1,
                ],
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: 6, // Number of skeleton items
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: double.infinity,
                            height: 120,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 16,
                                  width: 100,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 12,
                                  width: 150,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                    (i) => const SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        width: 16,
                                        height: 16,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 12,
                                      width: 30,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.75,
            ),
            itemCount: notifier.programs.length,
            itemBuilder: (context, index) {
              final program = notifier.programs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProgramDetailScreen(programId: program.id),
                    ),
                  );
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
                        tag: 'program-${program.id}',
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          child: Image(
                            image: program.imageProvider,
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
                              program.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Instructor: ${program.instructor}",
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
                                    color: i < program.rating.floor()
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${program.rating}",
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
          );
        },
      ),
    );
  }
}
