import 'package:flutter/material.dart';

final Color primerColor = Color(0xFF3F51B5);  // Indigo
final Color sekunderColor = Color(0xFFE91E63); // Pink
final Color aksenColor = Color(0xFF009688);    // Teal
final Color backgroundColor = Color(0xFFF5F5F5); // Light Grey
final Color textColor = Color(0xFF212121);      // Dark Grey

final ThemeData temaAplikasi = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: primerColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: primerColor,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: sekunderColor,
      elevation: 3,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primerColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: sekunderColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: primerColor.withOpacity(0.5), width: 1),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: textColor, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: textColor),
    bodyMedium: TextStyle(color: textColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: sekunderColor,
    foregroundColor: Colors.white,
  ),
);