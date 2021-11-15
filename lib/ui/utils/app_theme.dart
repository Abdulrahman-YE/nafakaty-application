import 'package:flutter/material.dart';

// colors
const MaterialColor kcPrimaryColor = Colors.cyan;
const Color kcSecondaryColor = Colors.tealAccent;
const Color kcGrayColor = Color(0xff454b50);

TextTheme _textTheme() {
  return Typography.tall2018;
}

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    textTheme: _textTheme(),
    primarySwatch: kcPrimaryColor,
    buttonTheme: buttonDarkTheme(),
    cardTheme: cardLightTheme(),
    inputDecorationTheme: inputLightTheme(),
  );
}

ButtonThemeData buttonDarkTheme() {
  return ButtonThemeData(
    buttonColor: kcGrayColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

CardTheme cardLightTheme() {
  return CardTheme(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: kcPrimaryColor,
        )),
  );
}

InputDecorationTheme inputLightTheme() {
  return InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
