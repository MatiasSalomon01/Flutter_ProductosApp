import 'package:flutter/material.dart';

class ThemeApp {
  static final theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.indigo,
      elevation: 0
    ),
  );
}