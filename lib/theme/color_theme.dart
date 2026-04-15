import 'package:flutter/material.dart';
import 'package:shopping_list/theme/app_decorations.dart';

class AppColors {
  static const Color canvas = Color(0xFFF9F3EA);
  static const Color surface = Color(0xFFFFFCF7);
  static const Color ink = Color(0xFF163138);
  static const Color inkSoft = Color(0xFF4D676D);
  static const Color coral = Color(0xFFE76F51);
  static const Color coralPressed = Color(0xFFF2B8A8);
  static const Color teal = Color(0xFF2A9D8F);
  static const Color tealPressed = Color(0xFFA8DCD5);
  static const Color gold = Color(0xFFF4A261);
  static const Color warning = Color(0xFFE9A03B);
  static const Color error = Color(0xFFC44536);
  static const Color info = Color(0xFF3D7EA6);
}

ThemeData buildAppTheme() {
  const inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    borderSide: BorderSide(color: AppColors.inkSoft),
  );

  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.coral,
    onPrimary: Colors.white,
    secondary: AppColors.teal,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.ink,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.canvas,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.canvas,
      foregroundColor: AppColors.ink,
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.coral,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppDecorations.actionButtonStyle(
        backgroundColor: AppColors.ink,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(color: AppColors.coral, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.ink,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.inkSoft),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.inkSoft),
    ),
  );
}
