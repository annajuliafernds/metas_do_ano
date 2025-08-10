import 'package:flutter/material.dart';
import 'add_edit_goal_screen.dart';
import '../models/goal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/goal/goal_bloc.dart';
import '../blocs/goal/goal_event.dart';

class GoalDetailScreen extends StatelessWidget {
  final Goal goal; // Meta que será exibida nos detalhes

  GoalDetailScreen({required this.goal});

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
            // Exibe o título da meta em destaque
            Text(
              goal.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Exibe a descrição da meta se existir e não estiver vazia
            if (goal.description != null && goal.description!.isNotEmpty)
              Text(
                goal.description!,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            SizedBox(height: 16),
            // Linha com ícone e texto do status da meta
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
            // Se a meta tem uma data definida, exibe a data do prazo
            if (goal.targetDate != null) ...[
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 20, color: Colors.grey[700]),
                  SizedBox(width: 6),
                  Text(
                    // Formata a data para exibir só ano-mês-dia
                    'Prazo: ${goal.targetDate!.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
            Spacer(), // Empurra os botões para o final da tela
            Row(
              children: [
                Expanded(
                  // Botão para editar a meta
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text('Editar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      // Navega para a tela de criação/edição passando a meta atual
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditGoalScreen(goal: goal),
                        ),
                      );
                      Navigator.pop(context); // Volta para a lista após editar
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  // Botão para marcar a meta como concluída
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check_circle),
                    label: Text('Concluir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Cria uma nova meta atualizada com status 'concluida'
                      final updated = Goal(
                        id: goal.id,
                        title: goal.title,
                        description: goal.description,
                        status: 'concluida',
                        targetDate: goal.targetDate,
                        createdAt: goal.createdAt,
                      );
                      // Dispara evento para atualizar a meta no BLoC
                      context.read<GoalBloc>().add(UpdateGoal(updated));
                      Navigator.pop(context); // Volta para a lista após concluir
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
