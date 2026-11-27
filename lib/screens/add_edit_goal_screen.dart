import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metas_do_ano/models/goal.dart';
import 'package:metas_do_ano/blocs/goal/goal_bloc.dart';
import 'package:metas_do_ano/blocs/goal/goal_event.dart';

class AddEditGoalScreen extends StatefulWidget {
  final Goal? goal; // Recebe uma meta para edição, ou null para criação

  const AddEditGoalScreen({super.key, this.goal});

  @override
  State<AddEditGoalScreen> createState() => _AddEditGoalScreenState();
}

class _AddEditGoalScreenState extends State<AddEditGoalScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave para validar o formulário

  late TextEditingController _titleCtrl; // Controlador para o campo título
  late TextEditingController _descCtrl; // Controlador para o campo descrição
  String _status = 'em_andamento'; // Status padrão da meta
  DateTime? _target; // Prazo (data) da meta

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os dados da meta caso esteja editando
    _titleCtrl = TextEditingController(text: widget.goal?.title ?? '');
    _descCtrl = TextEditingController(text: widget.goal?.description ?? '');
    _status = widget.goal?.status ?? 'em_andamento';
    _target = widget.goal?.targetDate;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.goal != null; // Verifica se está editando ou criando

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Editar Meta' : 'Nova Meta'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey, // Vincula o formulário para validação
          child: Column(
            children: [
              // Campo de texto para o título da meta
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: const OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Digite um título' : null,
              ),
              const SizedBox(height: 8),
              // Campo de texto para a descrição, permite várias linhas e é opcional
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Dropdown para escolher o status da meta
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _status,
                      items: [
                        const DropdownMenuItem(
                            value: 'em_andamento',
                            child: const Text('Em andamento')),
                        const DropdownMenuItem(
                            value: 'concluida', child: const Text('Concluída')),
                        const DropdownMenuItem(
                            value: 'nao_realizada',
                            child: const Text('Não realizada')),
                      ],
                      onChanged: (v) => setState(() => _status = v!),
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Botão para selecionar a data do prazo
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _target == null
                          ? 'Selecionar prazo'
                          : _target!.toLocal().toString().split(' ')[0],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    onPressed: () async {
                      // Abre o seletor de datas
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _target ?? DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365 * 5)),
                      );
                      if (d != null) setState(() => _target = d);
                    },
                  )
                ],
              ),
              const Spacer(),
              // Botão para salvar ou criar a meta, ocupa toda a largura
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(isEdit ? Icons.save : Icons.add_task),
                  label: Text(
                    isEdit ? 'Salvar Alterações' : 'Criar Nova Meta',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                  ),
                  onPressed: () {
                    // Valida o formulário antes de prosseguir
                    if (_formKey.currentState!.validate()) {
                      // Cria o objeto meta com os dados do formulário
                      final goal = Goal(
                        id: widget.goal?.id, // Mantém o id se for edição
                        title: _titleCtrl.text.trim(),
                        description: _descCtrl.text.trim(),
                        status: _status,
                        targetDate: _target,
                      );
                      // Dispara o evento correto no BLoC: atualizar ou adicionar
                      if (isEdit) {
                        context.read<GoalBloc>().add(UpdateGoal(goal));
                      } else {
                        context.read<GoalBloc>().add(AddGoal(goal));
                      }
                      Navigator.pop(context); // Volta para a tela anterior
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
