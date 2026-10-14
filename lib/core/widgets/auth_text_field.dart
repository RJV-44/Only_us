import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: switch (label) {
        'Email' => const [AutofillHints.email],
        'Password' => const [AutofillHints.password],
        'Confirm password' => const [AutofillHints.newPassword],
        _ => null,
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: switch (keyboardType) {
          TextInputType.emailAddress => const Icon(Icons.email_outlined),
          TextInputType.name => const Icon(Icons.person_outline),
          _ when obscureText => const Icon(Icons.lock_outline),
          _ => null,
        },
      ),
    );
  }
}
