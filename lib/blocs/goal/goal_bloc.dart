import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metas_do_ano/blocs/goal/goal_event.dart';       // Eventos que o BLoC pode receber
import 'package:metas_do_ano/blocs/goal/goal_state.dart';       // Estados que o BLoC pode emitir
import 'package:metas_do_ano/data/goal_repository.dart';  // Repositório para acessar dados (DB, API, etc.)

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalRepository repo;  // Repositório para manipular metas

  // Construtor: recebe o repositório e define estado inicial como GoalLoading
  GoalBloc(this.repo) : super(GoalLoading()) {
    
    // Evento LoadGoals: carrega todas as metas do repositório
    on<LoadGoals>((e, emit) async {
      emit(GoalLoading());    // Emite estado de carregamento
      try {
        final goals = await repo.getAll();  // Busca todas as metas
        emit(GoalLoaded(goals));            // Emite estado com metas carregadas
      } on Exception catch (err) {
  emit(GoalError(err.toString()));
}
    });

    // Evento AddGoal: adiciona uma nova meta e recarrega a lista
    on<AddGoal>((e, emit) async {
      if (state is GoalLoaded) {      // Só permite adicionar se a lista já estiver carregada
        await repo.add(e.goal);        // Adiciona meta no repositório
        add(LoadGoals());              // Dispara evento para recarregar metas
      }
    });

    // Evento UpdateGoal: atualiza uma meta existente e recarrega a lista
    on<UpdateGoal>((e, emit) async {
      if (state is GoalLoaded) {
        await repo.update(e.goal);    // Atualiza a meta no repositório
        add(LoadGoals());             // Recarrega a lista de metas
      }
    });

    // Evento DeleteGoal: deleta uma meta pelo id e recarrega a lista
    on<DeleteGoal>((e, emit) async {
      if (state is GoalLoaded) {
        await repo.delete(e.id);      // Deleta a meta no repositório
        add(LoadGoals());             // Atualiza a lista de metas
      }
    });
  }
}
