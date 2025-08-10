import 'package:equatable/equatable.dart';  // Para facilitar comparação dos estados
import '../../models/goal.dart';             // Modelo Goal

// Classe base abstrata para os estados relacionados a metas
abstract class GoalState extends Equatable {
  @override
  List<Object?> get props => [];  // Define propriedades para comparação (igualdade)
}

// Estado que representa que os dados estão sendo carregados
class GoalLoading extends GoalState {}

// Estado que representa que as metas foram carregadas com sucesso
class GoalLoaded extends GoalState {
  final List<Goal> goals;  // Lista de metas carregadas

  GoalLoaded(this.goals);

  @override
  List<Object?> get props => [goals];  // Para que a comparação considere a lista de metas
}

// Estado que representa que ocorreu algum erro durante o carregamento ou operação
class GoalError extends GoalState {
  final String message;  // Mensagem de erro

  GoalError(this.message);

  @override
  List<Object?> get props => [message];  // Para que a comparação considere a mensagem de erro
}
