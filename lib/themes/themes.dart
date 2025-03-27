import 'package:flutter/material.dart';

class AppTypography {
    static const appFont = 'Fira Code';
    static const TextStyle textStyle = TextStyle(
    fontFamily: appFont,
    fontWeight: FontWeight.normal, 
    fontStyle: FontStyle.normal,   
  );
}

class AppColors {
  static const Color sunIconColor = Color(0xFFFFC107); 
  static const Color moonIconColor = Color(0xFF6A5ACD); 
}

final ThemeData lightTheme = ThemeData(
   colorScheme: ColorScheme.light(
    surface: const Color(0xFF8F9FAA),
    onPrimary: const Color(0xFF121212),

   )
);

final ThemeData darkTheme = ThemeData(
   colorScheme: ColorScheme.dark(
    surface: const Color(0xFF121212),
    onPrimary: const Color(0xFFE0E0E0),
   )
);

