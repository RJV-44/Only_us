import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class MediaService {
  const MediaService(this._client);

  final SupabaseClient _client;

  Future<String> upload({
    required String bucket,
    required String path,
    required Uint8List bytes,
    required String contentType,
  }) async {
    await _client.storage.from(bucket).uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: contentType, upsert: false),
        );
    return _client.storage.from(bucket).getPublicUrl(path);
  }
}
