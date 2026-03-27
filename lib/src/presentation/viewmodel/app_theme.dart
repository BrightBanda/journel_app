import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.yellow,
    scaffoldBackgroundColor: Color.fromARGB(255, 227, 229, 232),

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

    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFF2A2A2A),
  );
}
