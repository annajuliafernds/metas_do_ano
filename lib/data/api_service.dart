import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/goal.dart';

class ApiService {
  final String baseUrl;
  ApiService({required this.baseUrl});

  Future<List<Goal>> fetchGoals() async {
    final res = await http.get(Uri.parse('$baseUrl/goals'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Goal.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load goals');
    }
  }

  Future<bool> syncGoal(Goal g) async {
    final res = await http.post(
      Uri.parse('$baseUrl/goals'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(g.toMap()),
    );
    return res.statusCode == 201 || res.statusCode == 200;
  }
}
