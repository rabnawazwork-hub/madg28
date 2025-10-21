import 'package:flutter/material.dart';
import 'package:madg28/models/mockapi.dart';
import 'package:madg28/models/program.dart';
import 'package:madg28/screens/program_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _searchTerm = '';
  List<Program> _allPrograms = [];
  List<Program> _filteredPrograms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrograms();
  }

  Future<void> _fetchPrograms() async {
    setState(() {
      _isLoading = true;
    });
    final apiService = MockApiService();
    _allPrograms = await apiService.getPrograms();
    _filterPrograms(); // Initial filter when programs are loaded
    setState(() {
      _isLoading = false;
    });
  }

  void _filterPrograms() {
    setState(() {
      if (_searchTerm.isEmpty) {
        _filteredPrograms = [];
      } else {
        _filteredPrograms = _allPrograms
            .where((program) =>
                program.name.toLowerCase().contains(_searchTerm.toLowerCase()) ||
                program.description
                    .toLowerCase()
                    .contains(_searchTerm.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Courses'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                  _filterPrograms();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchTerm.isEmpty
                      ? const Center(
                          child: Text('Enter a search term to begin.'))
                      : _filteredPrograms.isEmpty
                          ? const Center(
                              child: Text('No programs found.'))
                          : ListView.builder(
                              itemCount: _filteredPrograms.length,
                              itemBuilder: (context, index) {
                                final program = _filteredPrograms[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProgramDetailScreen(
                                                  program: program),
                                        ),
                                      );
                                    },
                                    leading: Hero(
                                      tag: 'program-${program.id}',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image(
                                          image: program.imageProvider, // Use imageProvider
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(program.name),
                                    subtitle: Text(program.instructor),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 16),
                                        Text('${program.rating}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}