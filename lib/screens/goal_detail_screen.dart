import 'package:flutter/material.dart';
import 'package:metas_do_ano/screens/add_edit_goal_screen.dart';
import 'package:metas_do_ano/models/goal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metas_do_ano/blocs/goal/goal_bloc.dart';
import 'package:metas_do_ano/blocs/goal/goal_event.dart';

class GoalDetailScreen extends StatelessWidget {
  final Goal goal;

  const GoalDetailScreen({super.key, required this.goal});

  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Meta'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (goal.description != null && goal.description!.isNotEmpty)
              Text(
                goal.description!,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.flag, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 6),
                Text(
                  'Status: ${goal.status.replaceAll('_', ' ')}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (goal.targetDate != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 20, color: Colors.grey[700]),
                  const SizedBox(width: 6),
                  Text(
                    'Prazo: ${goal.targetDate!.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                    style: _buttonStyle(Colors.blueAccent),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => AddEditGoalScreen(goal: goal),
                        ),
                      );

                      if (!context.mounted) return;

                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Concluir'),
                    style: _buttonStyle(Colors.green),
                    onPressed: () {
                      final updated = Goal(
                        id: goal.id,
                        title: goal.title,
                        description: goal.description,
                        status: 'concluida',
                        targetDate: goal.targetDate,
                        createdAt: goal.createdAt,
                      );

                      context.read<GoalBloc>().add(UpdateGoal(updated));
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
