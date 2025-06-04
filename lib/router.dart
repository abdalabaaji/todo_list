import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/todo/presentation/screens/home_screen.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/presentation/cubit/todo_cubit.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => RegisterScreen()),
    GoRoute(
      path: '/home',
      builder:
          (_, __) => BlocProvider(
            create: (_) => TodoCubit(TodoRepositoryImpl())..fetchTodos(),
            child: const HomeScreen(),
          ),
    ),
  ],
);
