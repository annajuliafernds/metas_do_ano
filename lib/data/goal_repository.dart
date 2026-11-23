import 'dart:developer';

import '../models/goal.dart';
import 'db_helper.dart';
import 'api_service.dart';

class GoalRepository {
  final DBHelper db;
  final ApiService? api;

  GoalRepository({required this.db, this.api});

  Future<List<Goal>> getAll() => db.readAllGoals();

  Future<Goal> add(Goal g) async {
    final created = await db.createGoal(g);
    final apiService = api;
    if (apiService != null) {
      try {
        final synced = await apiService.syncGoal(created);
        if (!synced) {
          log('API rejected the new goal during synchronization.');
        }
      } on Exception catch (error, stackTrace) {
        log(
          'Could not synchronize the new goal.',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
    return created;
  }

  Future<int> update(Goal g) async {
    final res = await db.updateGoal(g);
    final apiService = api;
    if (apiService != null) {
      try {
        final synced = await apiService.syncGoal(g);
        if (!synced) {
          log('API rejected the updated goal during synchronization.');
        }
      } on Exception catch (error, stackTrace) {
        log(
          'Could not synchronize the updated goal.',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
    return res;
  }

  Future<int> delete(int id) => db.deleteGoal(id);
}
