
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:madg28/models/program.dart';

class MockApiService {
  Future<List<Program>> getPrograms() async {
    final String response = await rootBundle.loadString('assets/data/programs.json');
    final data = await json.decode(response);
    final List<dynamic> programList = data['programs'];
    return programList.map((json) => Program.fromJson(json)).toList();
  }
}
