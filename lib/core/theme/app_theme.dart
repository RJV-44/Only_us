import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const _berry = Color(0xFFB34F68);
  static const _background = Color(0xFFFFF8F6);

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _berry,
      surface: _background,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: _background,
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
