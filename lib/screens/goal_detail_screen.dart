
import 'package:flutter/material.dart';
import 'add_edit_goal_screen.dart';
import '../models/goal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/goal/goal_bloc.dart';
import '../blocs/goal/goal_event.dart';

class GoalDetailScreen extends StatelessWidget {
  final Goal goal;

  const GoalDetailScreen({super.key, required this.goal});

  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Meta'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              goal.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            if (goal.description != null && goal.description!.isNotEmpty)
              Text(
                goal.description!,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.flag, size: 20, color: Colors.grey[700]),
                SizedBox(width: 6),
                Text(
                  'Status: ${goal.status.replaceAll('_', ' ')}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            if (goal.targetDate != null) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 20, color: Colors.grey[700]),
                  SizedBox(width: 6),
                  Text(
                    'Prazo: ${goal.targetDate!.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Editar'),
                    style: _buttonStyle(Colors.blueAccent),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditGoalScreen(goal: goal),
                        ),
                      );

                      if (!context.mounted) return;

                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check_circle),
                    label: Text('Concluir'),
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
