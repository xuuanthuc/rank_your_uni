import 'package:flutter/material.dart';

abstract class AppThemes {
  const AppThemes();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
  );
}
