import 'package:flutter/material.dart';

class AppTheme {
  static const Color PRIMARY = Color(0xFF6366F1);
  static const Color PRIMARY_DARK = Color(0xFF4F46E5);
  static const Color SECONDARY = Color(0xFF10B981);
  static const Color SECONDARY_DARK = Color(0xFF059669);
  static const Color ACCENT = Color(0xFFF59E0B);
  static const Color ERROR = Color(0xFFEF4444);
  static const Color SUCCESS = Color(0xFF10B981);
  static const Color WARNING = Color(0xFFF59E0B);
  static const Color INFO = Color(0xFF3B82F6);

  static const Color BACKGROUND = Color(0xFFFAFAFA);
  static const Color SURFACE = Color(0xFFFFFFFF);
  static const Color SURFACE_DARK = Color(0xFFF3F4F6);
  static const Color TEXT_PRIMARY = Color(0xFF1F2937);
  static const Color TEXT_SECONDARY = Color(0xFF6B7280);
  static const Color TEXT_TERTIARY = Color(0xFF9CA3AF);
  static const Color BORDER = Color(0xFFE5E7EB);
  static const Color BORDER_DARK = Color(0xFFD1D5DB);

  static const Color SUDOKU_CELL_LOCKED = Color(0xFFF3F4F6);
  static const Color SUDOKU_CELL_EDITABLE = Color(0xFFFFFFFF);
  static const Color SUDOKU_CELL_SELECTED = Color(0xFFDEBEFC);
  static const Color SUDOKU_CELL_RELATED = Color(0xFFFECDD3);
  static const Color SUDOKU_CELL_ERROR = Color(0xFFFECACA);
  static const Color SUDOKU_BOX_BORDER = Color(0xFF1F2937);
  static const Color SUDOKU_GRID_BORDER = Color(0xFF9CA3AF);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: PRIMARY,
      scaffoldBackgroundColor: BACKGROUND,
      appBarTheme: const AppBarTheme(
        backgroundColor: SURFACE,
        foregroundColor: TEXT_PRIMARY,
        elevation: 1,
        centerTitle: true,
      ),
      cardTheme: const CardTheme(
        color: SURFACE,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SURFACE_DARK,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: BORDER),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: BORDER),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: PRIMARY, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PRIMARY,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: TEXT_PRIMARY),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: TEXT_PRIMARY),
        displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: TEXT_PRIMARY),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: TEXT_PRIMARY),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: TEXT_PRIMARY),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: TEXT_PRIMARY),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: TEXT_PRIMARY),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: TEXT_PRIMARY),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: TEXT_PRIMARY),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: TEXT_SECONDARY),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: TEXT_PRIMARY),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: PRIMARY,
    );
  }
}
