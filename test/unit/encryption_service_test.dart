import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:only_us/services/encryption_service.dart';

void main() {
  final service = EncryptionService();
  final key = List<int>.generate(EncryptionService.keyLengthBytes, (i) => i);

  test('encrypts and decrypts text', () async {
    const plaintext = 'A private message 💌';

    final encrypted = await service.encrypt(plaintext, keyBytes: key);

    expect(encrypted, isNot(plaintext));
    expect(await service.decrypt(encrypted, keyBytes: key), plaintext);
  });

  test('rejects an invalid key length', () async {
    await expectLater(
      service.encrypt('message', keyBytes: [1, 2, 3]),
      throwsArgumentError,
    );
  });

  test('rejects ciphertext modified after encryption', () async {
    final encrypted = await service.encrypt('message', keyBytes: key);
    final bytes = base64Decode(encrypted);
    bytes[12] ^= 1;

    await expectLater(
      service.decrypt(base64Encode(bytes), keyBytes: key),
      throwsA(anything),
    );
  });
}
