import 'package:flutter/material.dart';
import 'package:template/global/style/app_colors.dart';

abstract class AppThemes {
  const AppThemes();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Montserrat',
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primary,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: AppColors.black,
      surface: AppColors.level4.withOpacity(0.15),
      onSurface: AppColors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: AppColors.textSelected,
      cursorColor: AppColors.black,
    ),
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 30,
        color: AppColors.black,
      ),
      //heading1

      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 25,
        color: AppColors.black,
      ),
      //heading2

      displaySmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppColors.black,
      ),
      //heading 3

      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: AppColors.black,
      ),
      //button1

      bodyLarge: TextStyle(
        fontSize: 18,
        color: AppColors.black,
      ),
      //body1

      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.black,
      ),
      //body2

      titleMedium: TextStyle(
        fontSize: 24,
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      //title1

      titleLarge: TextStyle(
        fontSize: 12,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
      //heading6
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: AppColors.black,
      ),
      //button2
    ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     overlayColor: MaterialStateProperty.all(Colors.redAccent),
    //     foregroundColor: MaterialStateProperty.resolveWith<Color?>(
    //       (Set<MaterialState> states) {
    //         if (states.contains(MaterialState.hovered)) {
    //           return Colors.black;
    //         }
    //         return null; // defer to the defaults
    //       },
    //     ),
    //   ),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
  );
}
