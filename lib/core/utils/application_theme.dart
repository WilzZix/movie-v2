import 'package:flutter/material.dart';
import 'package:movie/core/utils/colors.dart';
import 'package:movie/core/utils/typography.dart';

class ApplicationTheme {
  static final ThemeData light = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      fillColor: GreyScale.grayScale50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
  );
  static final ThemeData dark = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      fillColor: DarkColors.dark2,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
    ),
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      dragHandleColor: GreyScale.grayScale200,
      backgroundColor: const Color(0xFFFEFEFE),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xD9181A20),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        color: MainPrimaryColor.primary500,
      ),
      unselectedIconTheme: IconThemeData(
        color: GreyScale.grayScale500,
      ),
      unselectedItemColor: GreyScale.grayScale500,
      selectedItemColor: MainPrimaryColor.primary500,
      selectedLabelStyle: Typographies.bodyXSmallSemiBold
          .copyWith(color: MainPrimaryColor.primary500),
      unselectedLabelStyle: Typographies.bodyXSmallSemiBold,
    ),
  );
}
