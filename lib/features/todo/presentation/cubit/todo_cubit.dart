import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/entities/todo.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;

  TodoCubit(this.todoRepository) : super(TodoInitial());

  Future<void> fetchTodos() async {
    emit(TodoLoading());
    try {
      final todos = await todoRepository.fetchTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> addTodo(String title) async {
    try {
      await todoRepository.addTodo(title);
      await fetchTodos();
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    try {
      await todoRepository.toggleTodo(todo);
      await fetchTodos();
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
