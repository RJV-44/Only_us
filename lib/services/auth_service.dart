import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  const AuthService(this._client);

  final SupabaseClient _client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    final name = displayName?.trim();
    return _client.auth.signUp(
      email: email.trim(),
      password: password,
      data: name == null || name.isEmpty ? null : {'display_name': name},
    );
  }

  Future<void> signOut() => _client.auth.signOut();
}
