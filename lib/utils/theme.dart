import 'package:flutter/material.dart';

ThemeData lightModeTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFFF6F8F8),
      secondary: Color(0xFFF0F3F4)
    )
);

ThemeData darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      primary: Color(0xFF121212),
      secondary: Color(0xFF1F1F1F)
  )
);