import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF173037),
  scaffoldBackgroundColor: Color(0xfffcf5ee),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF173037),
    secondary: Color(0xFFFddbb7),
    surface: Color(0xFFFddbb7),
    onPrimary: Colors.white,
    onSecondary: Color(0xFF173037),
    onSurface: Color(0xFF173037),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF173037),
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFddbb7),
    foregroundColor: Color(0xFF173037),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF173037),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF173037), fontSize: 16),
    bodyMedium:
        TextStyle(color: Color(0xFF173037), fontSize: 14),
    displayLarge: TextStyle(
        color: Color(0xFF173037), fontSize: 32, fontWeight: FontWeight.bold),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF173037),
  scaffoldBackgroundColor: const Color(0xFF173037),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF173037),
    secondary: Color(0xFFFddbb7),
    surface: Color(0xFF1e4a58),
    onPrimary: Color(0xFFFddbb7),
    onSecondary: Color(0xFF173037),
    onSurface: Color(0xFFFddbb7),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF173037),
    foregroundColor: Color(0xFFFddbb7),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFddbb7),
    foregroundColor: Color(0xFF173037),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF173037),
      backgroundColor: const Color(0xFFFddbb7),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFFddbb7), fontSize: 16),
    bodyMedium:
        TextStyle(color: Color(0xFFFddbb7), fontSize: 14),
    displayLarge: TextStyle(
        color: Color(0xFFFddbb7), fontSize: 32, fontWeight: FontWeight.bold),
  ),
);
