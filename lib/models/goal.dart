class Goal {
  int? id;
  String title;
  String? description;
  String status; // 'em_andamento', 'concluida', 'nao_realizada'
  DateTime createdAt;
  DateTime? targetDate;

  Goal({
    this.id,
    required this.title,
    this.description,
    this.status = 'em_andamento',
    DateTime? createdAt,
    this.targetDate,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'targetDate': targetDate?.toIso8601String(),
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
      status: map['status'] as String? ?? 'em_andamento',
      createdAt: DateTime.parse(map['createdAt'] as String),
      targetDate:
          map['targetDate'] != null ? DateTime.parse(map['targetDate']) : null,
    );
  }
}
