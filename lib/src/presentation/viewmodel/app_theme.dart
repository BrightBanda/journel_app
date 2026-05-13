import 'package:flutter/material.dart';

class AppTheme {
  static const lightSubtext = Color(0xFF6B7280);
  static const lightBorder = Color(0xFFE5E7EB);
  static const lightSuccess = Color(0xFF22C55E);

  // Dark colors
  static const darkSubtext = Color(0xFF9CA3AF);
  static const darkBorder = Color(0xFF374151);
  static const darkSuccess = Color(0xFF4ADE80);

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.yellow,
    scaffoldBackgroundColor: Color.fromARGB(255, 227, 229, 232),
    dividerColor: Colors.amber,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),

    cardColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.yellow,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    dividerColor: const Color.fromARGB(255, 102, 102, 102),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFF2A2A2A),
  );
}
