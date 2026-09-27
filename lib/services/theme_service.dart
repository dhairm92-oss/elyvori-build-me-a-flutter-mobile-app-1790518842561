import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme {
    if (_isDarkMode) {
      return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        primaryColor: const Color(0xFFD4AF37),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFFC5A059),
          surface: Color(0xFF141414),
          background: Color(0xFF0B0B0B),
        ),
        cardColor: const Color(0xFF181818),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0B0B),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFE0E0E0)),
          bodyMedium: TextStyle(color: Color(0xFFB0B0B0)),
          titleLarge: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        primaryColor: const Color(0xFF997A15),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF997A15),
          secondary: Color(0xFFB38F26),
          surface: Color(0xFFFFFFFF),
          background: Color(0xFFF7F7F7),
        ),
        cardColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F7F7),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF997A15),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: Color(0xFF997A15)),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF1A1A1A)),
          bodyMedium: TextStyle(color: Color(0xFF555555)),
          titleLarge: TextStyle(color: Color(0xFF997A15), fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}