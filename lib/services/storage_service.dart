import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  const StorageService(this._client);

  final SupabaseClient _client;

  Future<String> upload({
    required String bucket,
    required String path,
    required Uint8List bytes,
    required String contentType,
    bool upsert = false,
  }) async {
    _validateLocation(bucket, path);
    if (bytes.isEmpty) {
      throw ArgumentError.value(bytes, 'bytes', 'File must not be empty.');
    }
    await _client.storage.from(bucket).uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: contentType, upsert: upsert),
        );
    return path;
  }

  Future<String> createSignedUrl({
    required String bucket,
    required String path,
    required int expiresInSeconds,
  }) {
    _validateLocation(bucket, path);
    if (expiresInSeconds <= 0) {
      throw ArgumentError.value(
        expiresInSeconds,
        'expiresInSeconds',
        'Expiry must be greater than zero.',
      );
    }
    return _client.storage
        .from(bucket)
        .createSignedUrl(path, expiresInSeconds);
  }

  Future<void> delete({
    required String bucket,
    required String path,
  }) async {
    _validateLocation(bucket, path);
    await _client.storage.from(bucket).remove([path]);
  }

  void _validateLocation(String bucket, String path) {
    if (bucket.trim().isEmpty) {
      throw ArgumentError.value(bucket, 'bucket', 'Bucket is required.');
    }
    if (path.trim().isEmpty) {
      throw ArgumentError.value(path, 'path', 'Storage path is required.');
    }
  }
}
