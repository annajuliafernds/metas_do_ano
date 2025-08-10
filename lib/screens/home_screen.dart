import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/goal/goal_bloc.dart';
import '../blocs/goal/goal_event.dart';
import '../blocs/goal/goal_state.dart';
import '../widgets/goal_tile.dart';
import 'add_edit_goal_screen.dart';
import 'goal_detail_screen.dart';
import '../models/goal.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice para controlar qual filtro está selecionado (0 = em andamento, 1 = concluída, 2 = não realizada)
  int _selectedIndex = 0;

  // Lista com os nomes dos status usados para filtrar as metas
  final tabs = ['em_andamento', 'concluida', 'nao_realizada'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metas do Ano'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Linha com título e botão para adicionar uma nova meta
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Minhas metas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Adicionar Meta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    // Navega para a tela de criação/edição de metas
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddEditGoalScreen()),
                    );
                    // Após voltar, recarrega as metas para atualizar a lista
                    context.read<GoalBloc>().add(LoadGoals());
                  },
                )
              ],
            ),
            SizedBox(height: 12),
            // Botões toggle para filtrar metas pelo status
            ToggleButtons(
              isSelected: [
                _selectedIndex == 0,
                _selectedIndex == 1,
                _selectedIndex == 2
              ],
              onPressed: (idx) {
                // Atualiza o filtro selecionado e redesenha a tela
                setState(() => _selectedIndex = idx);
              },
              borderRadius: BorderRadius.circular(10),
              selectedColor: Colors.white,
              fillColor: Colors.lightBlueAccent,
              color: Colors.black87,
              selectedBorderColor: Colors.purple,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text('Em andamento', style: TextStyle(fontSize: 14)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text('Concluídas', style: TextStyle(fontSize: 14)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text('Não realizada', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Lista de metas que ocupa o restante da tela
            Expanded(
              child: BlocBuilder<GoalBloc, GoalState>(
                builder: (context, state) {
                  if (state is GoalLoading) {
                    // Mostra um indicador de carregamento enquanto as metas são buscadas
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is GoalError) {
                    // Mostra mensagem de erro se algo deu errado
                    return Center(child: Text('Erro: ${state.message}'));
                  }
                  if (state is GoalLoaded) {
                    // Filtra as metas pelo status selecionado no toggle
                    final filtered = state.goals
                        .where((g) => g.status == tabs[_selectedIndex])
                        .toList();

                    if (filtered.isEmpty) {
                      // Mensagem caso não tenha metas para o filtro escolhido
                      return Center(
                          child: Text('Nenhuma meta aqui. Crie uma!'));
                    }
                    // Lista com as metas filtradas
                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, idx) {
                        final g = filtered[idx];
                        return GoalTile(
                          goal: g,
                          onTap: () async {
                            // Navega para a tela de detalhes da meta selecionada
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GoalDetailScreen(goal: g)),
                            );
                            // Recarrega as metas após voltar da tela de detalhes
                            context.read<GoalBloc>().add(LoadGoals());
                          },
                          onLongPress: () {
                            // Abre um diálogo para confirmar exclusão da meta
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Deletar meta?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Envia evento para deletar a meta
                                      context
                                          .read<GoalBloc>()
                                          .add(DeleteGoal(g.id!));
                                      Navigator.pop(context);
                                    },
                                    child: Text('Deletar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  // Retorna vazio caso nenhum estado anterior seja identificado
                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
