import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> addTodo(String title);
  Future<void> toggleTodo(Todo todo);
}
