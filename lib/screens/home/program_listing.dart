import 'package:flutter/material.dart';
import 'package:madg28/models/mockapi.dart';
import 'package:madg28/models/program.dart';
import 'package:madg28/screens/course/program_details.dart';



class ProgramListingScreen extends StatefulWidget {
  const ProgramListingScreen({super.key});

  @override
  State<ProgramListingScreen> createState() => _ProgramListingScreenState();
}

class _ProgramListingScreenState extends State<ProgramListingScreen> {
  List<Program> _programs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrograms();
  }

  Future<void> _fetchPrograms() async {
    final apiService = MockApiService();
    final programs = await apiService.getPrograms();
    setState(() {
      _programs = programs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Courses"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _programs.length,
              itemBuilder: (context, index) {
                final program = _programs[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Program image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: program.imageUrl.isNotEmpty
                              ? Image.network(
                                  program.imageUrl,
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/logo.png',
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        const SizedBox(height: 10),

                        // Title
                        Text(
                          program.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Instructor (dummy text)
                        const Text(
                          "Instructor: John Doe",
                          style: TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 10),

                        // Rating stars
                        Row(
                          children: List.generate(
                            5,
                            (i) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Description
                        Text(
                          program.description,
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 10),

                        // Feedback Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProgramDetailsScreen(program: program),
                                ),
                              );
                            },
                            child: const Text("View Details"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
