import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> login(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> register(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
