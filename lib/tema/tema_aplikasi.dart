import 'package:flutter/material.dart';

// Tema biru soft yang elegan
final Color primerColor = Color(0xFF5C6BC0);     // Soft Indigo
final Color sekunderColor = Color(0xFF64B5F6);   // Soft Blue
final Color aksenColor = Color(0xFF81C784);      // Soft Green
final Color backgroundColor = Color(0xFFEEF2F7);  // Soft Gray-Blue
final Color cardColor = Color(0xFFFFFFFF);       // White
final Color textColor = Color(0xFF37474F);       // Dark Blue-Gray
final Color subtextColor = Color(0xFF78909C);    // Lighter Blue-Gray

final ThemeData temaAplikasi = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: primerColor,
    secondary: sekunderColor,
    surface: cardColor,
    background: backgroundColor,
    error: Colors.redAccent.shade100,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: textColor,
    onBackground: textColor,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: backgroundColor,
  
  // AppBar Style
  appBarTheme: AppBarTheme(
    backgroundColor: primerColor,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
    ),
  ),
  
  // Card Style
  cardTheme: CardTheme(
    color: cardColor,
    elevation: 2,
    shadowColor: primerColor.withOpacity(0.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  ),
  
  // ListTile Style
  listTileTheme: ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    tileColor: cardColor,
  ),
  
  // Elevated Button Style
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: sekunderColor,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.transparent,
    ),
  ),
  
  // Text Button Style
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  
  // Input Decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primerColor.withOpacity(0.2), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primerColor, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primerColor.withOpacity(0.2), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.redAccent.shade100, width: 1),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: TextStyle(color: subtextColor),
    hintStyle: TextStyle(color: subtextColor.withOpacity(0.7)),
    prefixIconColor: sekunderColor,
  ),
  
  // Checkbox Style
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return sekunderColor;
      }
      return Colors.grey.shade300;
    }),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  
  // FloatingActionButton Style
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: sekunderColor,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  
  // Icon Style
  iconTheme: IconThemeData(
    color: primerColor,
    size: 24,
  ),
  
  // Dialog Style
  dialogTheme: DialogTheme(
    backgroundColor: cardColor,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  
  // Text Style
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
    bodySmall: TextStyle(color: subtextColor),
  ),
);