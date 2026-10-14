import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  const NotificationService(this._client);

  final SupabaseClient _client;

  Future<void> saveDeviceToken({
    required String userId,
    required String token,
    required String platform,
  }) async {
    await _client.from('device_tokens').upsert({
      'user_id': userId,
      'token': token,
      'platform': platform,
    }, onConflict: 'user_id,token');
  }
}
