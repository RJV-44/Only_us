import '../constants/app_constants.dart';

abstract final class Validators {
  static String? email(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Email is required.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(input)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';
    if (value.length < AppConstants.minimumPasswordLength) {
      return 'Use at least ${AppConstants.minimumPasswordLength} characters.';
    }
    return null;
  }
}
