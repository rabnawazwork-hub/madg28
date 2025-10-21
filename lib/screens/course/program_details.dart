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
      body: Center(
        child: Text('Details for ${program.name}'),
      ),
    );
  }
}