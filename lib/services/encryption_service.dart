import 'dart:convert';

import 'package:cryptography/cryptography.dart';

class EncryptionService {
  EncryptionService() : _algorithm = AesGcm.with256bits();

  static const keyLengthBytes = 32;
  static const _nonceLengthBytes = 12;
  static const _macLengthBytes = 16;

  final AesGcm _algorithm;

  Future<String> encrypt(
    String plaintext, {
    required List<int> keyBytes,
  }) async {
    _validateKey(keyBytes);
    final secretBox = await _algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: SecretKey(keyBytes),
    );
    return base64Encode(secretBox.concatenation());
  }

  Future<String> decrypt(
    String ciphertext, {
    required List<int> keyBytes,
  }) async {
    _validateKey(keyBytes);
    final secretBox = SecretBox.fromConcatenation(
      base64Decode(ciphertext),
      nonceLength: _nonceLengthBytes,
      macLength: _macLengthBytes,
    );
    final clearBytes = await _algorithm.decrypt(
      secretBox,
      secretKey: SecretKey(keyBytes),
    );
    return utf8.decode(clearBytes);
  }

  void _validateKey(List<int> keyBytes) {
    if (keyBytes.length != keyLengthBytes ||
        keyBytes.any((byte) => byte < 0 || byte > 255)) {
      throw ArgumentError.value(
        keyBytes.length,
        'keyBytes',
        'AES-256-GCM requires exactly 32 bytes.',
      );
    }
  }
}
