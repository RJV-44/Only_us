import 'package:supabase_flutter/supabase_flutter.dart';

class SessionService {
  const SessionService(this._client);

  final SupabaseClient _client;

  Session? get currentSession => _client.auth.currentSession;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get changes => _client.auth.onAuthStateChange;

  Future<void> refresh() async {
    await _client.auth.refreshSession();
  }

  Future<void> signOut() => _client.auth.signOut();
}
