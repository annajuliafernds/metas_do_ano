import 'package:metas_do_ano/data/api_service.dart';
import 'package:metas_do_ano/data/db_helper.dart';
import 'package:metas_do_ano/models/goal.dart';

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
      } on Exception {
        // A falha na sincronização não impede a operação local.
      }
    }

    return created;
  }

  Future<int> update(Goal g) async {
    final res = await db.updateGoal(g);

    if (api != null) {
      try {
        await api!.syncGoal(g);
      } on Exception {
        // A falha na sincronização não impede a operação local.
      }
    }

    return res;
  }

  Future<int> delete(int id) => db.deleteGoal(id);
}