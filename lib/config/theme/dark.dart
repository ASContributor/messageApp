import 'package:flutter/material.dart';

final ThemeData dark = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF7164DF), // Soft purple tone
  scaffoldBackgroundColor: Color(0xFF121212), // Dark background
  cardColor: Color(0xFF1E1E1E), // Darker card color
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.white60,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.white60,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E), // Dark app bar
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white70),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white70,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E), // Dark mode bottom nav
    selectedItemColor: Color(0xFF7164DF), // Purple accent
    unselectedItemColor: Colors.white54,
    showUnselectedLabels: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF7164DF),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: Colors.white38),
  ),
);
