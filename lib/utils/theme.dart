import 'package:flutter/material.dart';
import 'package:wedring/utils/constant.dart';

class WedringTheme {
  static lightTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: kBackgroundColor1,
      primaryColor: kPrimaryColor1,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: kPrimaryColor1,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(kPrimaryColor1),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(kPrimaryColor1),
      ),
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: kPrimaryColor1,
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kBackgroundColor2,
        iconTheme: IconThemeData(color: kPrimaryColor1),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kBackgroundColor2,
        selectedItemColor: kPrimaryColor1,
        unselectedItemColor: kTeritary1,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: kRegular12.copyWith(color: kTeritary1),
        unselectedLabelStyle: kRegular12.copyWith(color: kTeritary1),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor1,
        foregroundColor: kTeritary2,
      ),
    );
  }
}
