import 'package:flutter/material.dart';

// Tema biru soft yang elegan
final Color primerColor = const Color(0xFF5C6BC0);     // Soft Indigo
final Color sekunderColor = const Color(0xFF64B5F6);   // Soft Blue
final Color aksenColor = const Color(0xFF81C784);      // Soft Green
final Color backgroundColor = const Color(0xFFEEF2F7);  // Soft Gray-Blue
final Color cardColor = const Color(0xFFFFFFFF);       // White
final Color textColor = const Color(0xFF37474F);       // Dark Blue-Gray
final Color subtextColor = const Color(0xFF78909C);    // Lighter Blue-Gray

final ThemeData temaAplikasi = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    primary: primerColor,
    secondary: sekunderColor,
    surface: cardColor,
    onSurface: textColor,
    error: Colors.redAccent.shade100,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
    brightness: Brightness.light,
    // Surface color digunakan sebagai pengganti background color yang deprecated
    background: cardColor,
    onBackground: textColor,
  ),
  scaffoldBackgroundColor: backgroundColor,
  
  // AppBar Style
  appBarTheme: AppBarTheme(
    backgroundColor: primerColor,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    shadowColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16),
      ),
    ),
  ),
  
  // Card Style
  cardTheme: CardTheme(
    color: cardColor,
    elevation: 2,
    shadowColor: primerColor.withAlpha(51), // 0.2 opacity = 51/255
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  ),
  
  // ListTile Style
  listTileTheme: ListTileThemeData(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    tileColor: Colors.white, // Gunakan Colors.white langsung, bukan cardColor
  ),
  
  // Elevated Button Style
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: sekunderColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      shadowColor: Colors.transparent,
    ),
  ),
  
  // Text Button Style
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primerColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),
  
  // Input Decoration
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: primerColor, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: primerColor.withAlpha(51), width: 1), // 0.2 opacity = 51/255
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.redAccent.shade100, width: 1),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: TextStyle(color: subtextColor),
    hintStyle: TextStyle(color: subtextColor.withAlpha(178)), // 0.7 opacity = 178/255
    prefixIconColor: sekunderColor,
  ),
  
  // Checkbox Style
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return sekunderColor;
      }
      return Colors.grey.shade300;
    }),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  ),
  
  // FloatingActionButton Style
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: sekunderColor,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
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
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
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