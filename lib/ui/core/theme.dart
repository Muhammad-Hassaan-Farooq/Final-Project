import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF173037), // Dark teal for primary elements
  scaffoldBackgroundColor: Colors.white, // White background
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF173037), // Dark teal
    secondary: Color(0xFFFddbb7), // Light background
    surface: Color(0xFFFddbb7), // Peach for surfaces like cards
    onPrimary: Colors.white, // Text/icons on primary
    onSecondary: Color(0xFF173037), // Text/icons on background
    onSurface: Color(0xFF173037), // Text/icons on surfaces
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF173037), // Dark teal
    foregroundColor: Colors.white, // White text/icons
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFddbb7), // Peach FAB
    foregroundColor: Color(0xFF173037), // Dark teal icon
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xFF173037), // Text color
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF173037), fontSize: 16), // Main text
    bodyMedium:
        TextStyle(color: Color(0xFF173037), fontSize: 14), // Secondary text
    displayLarge: TextStyle(
        color: Color(0xFF173037), fontSize: 32, fontWeight: FontWeight.bold),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF173037), // Dark teal
  scaffoldBackgroundColor: const Color(0xFF173037), // Dark teal background
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF173037), // Dark teal
    secondary: Color(0xFFFddbb7), // Dark teal background
    surface: Color(0xFF1e4a58), // Lighter teal for surfaces
    onPrimary: Color(0xFFFddbb7), // Peach text/icons on primary
    onSecondary: Color(0xFF173037), // Peach text/icons on background
    onSurface: Color(0xFFFddbb7), // Peach text/icons on surfaces
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF173037), // Dark teal
    foregroundColor: Color(0xFFFddbb7), // Peach text/icons
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFFddbb7), // Peach FAB
    foregroundColor: Color(0xFF173037), // Dark teal icon
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFF173037),
      backgroundColor: const Color(0xFFFddbb7), // Dark teal text/icons
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFFddbb7), fontSize: 16), // Main text
    bodyMedium:
        TextStyle(color: Color(0xFFFddbb7), fontSize: 14), // Secondary text
    displayLarge: TextStyle(
        color: Color(0xFFFddbb7), fontSize: 32, fontWeight: FontWeight.bold),
  ),
);
