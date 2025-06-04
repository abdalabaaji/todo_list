
class Todo {
  final String id;
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
      id: json['id'].toString(),
      userId: json['user_id'],
      title: json['title'],
      isDone: json['is_done'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'user_id': userId, 'title': title, 'is_done': isDone};
  }
}
