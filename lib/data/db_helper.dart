import 'dart:async';
import 'package:sqflite/sqflite.dart';               
import 'package:path/path.dart';                      
import '../models/goal.dart';                         
import 'package:path_provider/path_provider.dart';   
import 'dart:io';

class DBHelper {
  // Singleton para garantir uma única instância do DBHelper durante o app
  static final DBHelper instance = DBHelper._init();
  static Database? _database; // Variável para armazenar o banco aberto

  DBHelper._init(); // Construtor privado

  // Getter assíncrono para obter o banco de dados (abre ou retorna já aberto)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('goals.db'); // Inicializa o banco com o nome goals.db
    return _database!;
  }

  // Método para inicializar o banco, criando o caminho e abrindo o arquivo
  Future<Database> _initDB(String filePath) async {
    final dir = await getApplicationDocumentsDirectory(); // Diretório padrão para salvar dados
    final path = join(dir.path, filePath); // Caminho completo do arquivo do banco
    return await openDatabase(
      path,
      version: 1,               // Versão do banco (para migrações futuras)
      onCreate: _createDB,      // Função para criar as tabelas quando o banco é criado
    );
  }

  // Método que cria a tabela 'goals' no banco de dados
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE goals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,   -- ID auto incremental
        title TEXT NOT NULL,                     -- Título obrigatório
        description TEXT,                        -- Descrição opcional
        status TEXT NOT NULL,                    -- Status obrigatório
        createdAt TEXT NOT NULL,                 -- Data de criação (texto)
        targetDate TEXT                         -- Data de prazo (texto, opcional)
      )
    ''');
  }

  // Método para inserir uma nova meta no banco
  Future<Goal> createGoal(Goal goal) async {
    final db = await instance.database;
    final id = await db.insert('goals', goal.toMap()); // Insere os dados convertidos em mapa
    goal.id = id;                                      // Atualiza o ID do objeto com o gerado pelo banco
    return goal;                                       // Retorna a meta atualizada
  }

  // Método para ler todas as metas do banco, ordenadas por data de criação (mais recentes primeiro)
  Future<List<Goal>> readAllGoals() async {
    final db = await instance.database;
    final maps = await db.query('goals', orderBy: 'createdAt DESC'); // Consulta SQL equivalente
    return maps.map((m) => Goal.fromMap(m)).toList();                // Converte os mapas para objetos Goal
  }

  // Método para atualizar uma meta existente
  Future<int> updateGoal(Goal goal) async {
    final db = await instance.database;
    return db.update(
      'goals',
      goal.toMap(),
      where: 'id = ?',          // Atualiza somente o registro com o id correspondente
      whereArgs: [goal.id],
    );
  }

  // Método para deletar uma meta pelo seu ID
  Future<int> deleteGoal(int id) async {
    final db = await instance.database;
    return db.delete(
      'goals',
      where: 'id = ?',          // Deleta o registro com o id especificado
      whereArgs: [id],
    );
  }

  // Método para fechar a conexão com o banco de dados
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
