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
    if (api != null) {
      try {
        await api!.syncGoal(created);
      } catch (_) {}
    }
    return created;
  }

  Future<int> update(Goal g) async {
    final res = await db.updateGoal(g);
    if (api != null) {
      try {
        await api!.syncGoal(g);
      } catch (_) {}
    }
    return res;
  }

  Future<int> delete(int id) => db.deleteGoal(id);
}
