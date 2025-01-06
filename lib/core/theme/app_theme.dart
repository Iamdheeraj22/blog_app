import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
      surfaceTintColor: AppPallete.backgroundColor,
      iconTheme: IconThemeData(
        color: AppPallete.whiteColor,
        size: 24,
      ),
      titleTextStyle: TextStyle(
        color: AppPallete.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.redColor),
      focusedErrorBorder: _border(AppPallete.redColor),
    ),
    textTheme: textTheme(
      color: AppPallete.whiteColor,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppPallete.whiteColor,
          width: 2,
        ),
      ),
      titleTextStyle: TextStyle(
        color: AppPallete.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppPallete.whiteColor,
      size: 24,
    ),
  );
  static final lightThemMode = ThemeData.light().copyWith(
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.blackColor,
      ),
      side: BorderSide.none,
    ),
    scaffoldBackgroundColor: AppPallete.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.whiteColor,
      elevation: 0,
      surfaceTintColor: AppPallete.whiteColor,
      titleTextStyle: TextStyle(
        color: AppPallete.blackColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: AppPallete.blackColor,
        size: 24,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.redColor),
      focusedErrorBorder: _border(AppPallete.redColor),
    ),
    textTheme: textTheme(
      color: AppPallete.blackColor,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppPallete.blackColor,
          width: 2,
        ),
      ),
      titleTextStyle: TextStyle(
        color: AppPallete.blackColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(
      color: AppPallete.blackColor,
      size: 24,
    ),
  );
}

TextTheme textTheme({required Color color}) => TextTheme(
      displayLarge:
          TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: color),
      displayMedium:
          TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: color),
      displaySmall:
          TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color),
      headlineLarge:
          TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
      headlineMedium:
          TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
      headlineSmall:
          TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
      titleLarge:
          TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
      titleMedium:
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
      titleSmall:
          TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
      bodyLarge:
          TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: color),
      bodyMedium:
          TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: color),
      bodySmall:
          TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: color),
      labelLarge:
          TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
      labelMedium:
          TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      labelSmall:
          TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
    );
