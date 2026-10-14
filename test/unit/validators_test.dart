import 'package:flutter_test/flutter_test.dart';
import 'package:only_us/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('accepts a valid email and trims whitespace', () {
      expect(Validators.email('  person@example.com  '), isNull);
    });

    test('rejects empty and invalid email values', () {
      expect(Validators.email(' '), isNotNull);
      expect(Validators.email('not-an-email'), isNotNull);
    });
  });

  group('Validators.password', () {
    test('accepts passwords with at least eight characters', () {
      expect(Validators.password('secure123'), isNull);
    });

    test('rejects empty and short passwords', () {
      expect(Validators.password(''), isNotNull);
      expect(Validators.password('short'), isNotNull);
    });
  });
}
