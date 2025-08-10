import 'package:equatable/equatable.dart';  // Para facilitar comparação dos eventos
import '../../models/goal.dart';             // Modelo Goal

// Classe base abstrata para os eventos relacionados a metas
abstract class GoalEvent extends Equatable {
  @override
  List<Object?> get props => [];  // Define propriedades para comparação (igualdade)
}

// Evento para carregar todas as metas
class LoadGoals extends GoalEvent {}

// Evento para adicionar uma nova meta
class AddGoal extends GoalEvent {
  final Goal goal;   // Meta a ser adicionada

  AddGoal(this.goal);

  @override
  List<Object?> get props => [goal];  // Para que a comparação considere a meta
}

// Evento para atualizar uma meta existente
class UpdateGoal extends GoalEvent {
  final Goal goal;   // Meta atualizada

  UpdateGoal(this.goal);

  @override
  List<Object?> get props => [goal];
}

// Evento para deletar uma meta pelo seu ID
class DeleteGoal extends GoalEvent {
  final int id;      // ID da meta a ser deletada

  DeleteGoal(this.id);

  @override
  List<Object?> get props => [id];
}
