import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.go('/home');
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AuthFailure) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: passCtrl,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().login(
                        emailCtrl.text,
                        passCtrl.text,
                      );
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () => context.push('/register'),
                    child: const Text('No account? Register'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
