import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBackground = Color(0xFF212121);
  static const Color primaryColor = Color(0xFF5EC570);
  static const Color secondaryColor = Color(0xFF1C7EEB);
  static const Color textColor = Colors.white;

  static ThemeData get theme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: primaryBackground,
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        backgroundColor: secondaryColor,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
      ),
    );
  }
}
