class Todo {
  final int id;
  final String userId;
  final String title;
  final bool isDone;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      userId: json['user_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      isDone: json['is_done'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'user_id': userId, 'title': title, 'is_done': isDone};
  }

  Todo copyWith({int? id, String? userId, String? title, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
