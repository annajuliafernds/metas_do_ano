import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../utils/constants.dart';

class GoalTile extends StatelessWidget {
  final Goal goal;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const GoalTile({required this.goal, required this.onTap, this.onLongPress});

  Color _statusColor(String status) {
    switch (status) {
      case 'concluida': return Colors.green;
      case 'nao_realizada': return Colors.red;
      default: return COLOR_LIGHT_BLUE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        title: Text(goal.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: goal.targetDate != null ? Text('Prazo: ${goal.targetDate!.toLocal().toString().split(' ')[0]}') : null,
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _statusColor(goal.status).withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            goal.status.replaceAll('_', ' ').toUpperCase(),
            style: TextStyle(color: _statusColor(goal.status), fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
