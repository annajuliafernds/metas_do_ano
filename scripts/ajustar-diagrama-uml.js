const fs = require('node:fs');

const file = 'docs/uml/mermaid/metas_do_ano_parse_diagram.mmd';

let diagram = fs.readFileSync(file, 'utf8');

// Substitui completamente o bloco da classe Goal.
diagram = diagram.replace(
  /  class Goal \{[\s\S]*?\n  \}/,
  `  class Goal {
    <<class>>
    📁 goal.dart
    int? id
    String title
    String? description
    String status
    DateTime createdAt
    DateTime? targetDate
    Map<String, dynamic> toMap()
  }`
);

// Remove a relação indevida da classe com ela mesma.
diagram = diagram.replace(
  /^\s*DBHelper --> DBHelper : uses\s*$/m,
  ''
);

fs.writeFileSync(file, diagram, 'utf8');

console.log('Diagrama UML ajustado com sucesso.');
