import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo_list/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_list/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/features/todo/presentation/cubit/todo_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(TodoRepositoryImpl())..fetchTodos(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Todos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                AuthRepositoryImpl().logout();
                context.go('/');
              },
            ),
          ],
        ),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TodoFailure) {
              return Center(child: Text(state.error));
            }
            if (state is TodoLoaded) {
              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: Supabase.instance.client
                    .from('todos')
                    .stream(primaryKey: ['id'])
                    .map(
                      (event) =>
                          event
                              .map(
                                (todo) => {
                                  'id': todo['id'],
                                  'user_id': todo['user_id'],
                                  'title': todo['title'],
                                  'is_done': todo['is_done'] ?? false,
                                },
                              )
                              .toList(),
                    ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final streamTodos = snapshot.data!;
                  return ListView.builder(
                    itemCount: streamTodos.length,
                    itemBuilder: (context, index) {
                      final todoMap = streamTodos[index];
                      final todo = Todo.fromJson(todoMap);
                      return ListTile(
                        title: Text(todo.title),
                        trailing: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) {
                            context.read<TodoCubit>().toggleTodo(todo);
                          },
                        ),
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final titleController = TextEditingController();
            final title = await showDialog<String>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text('Add Todo'),
                    content: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, titleController.text);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
            );
            if (title != null && title.isNotEmpty) {
              context.read<TodoCubit>().addTodo(title);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
