import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Todo>> fetchTodos() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      return [];
    }
    final data = await supabase.from('todos').select().eq('user_id', userId);
    return data.map((json) => Todo.fromJson(json)).toList();
  }

  @override
  Future<void> addTodo(String title) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await supabase.from('todos').insert({
      'user_id': userId,
      'title': title,
      'is_done': false,
    }).select();
  }

  @override
  Future<void> toggleTodo(Todo todo) async {
    await supabase
        .from('todos')
        .update({'is_done': !todo.isDone})
        .eq('id', todo.id);
  }
}
