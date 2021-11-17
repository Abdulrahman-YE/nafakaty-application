import 'package:flutter/material.dart';

// colors
const MaterialColor kcPrimaryColor = Colors.cyan;
const Color kcSecondaryColor = Colors.tealAccent;

const Color kcAlphaSecondaryColor = Color(0xffb2dfdb);
const Color kcGrayColor = Color(0xff454b50);

const TextStyle blackText = TextStyle(
  color: Colors.black,
);

const TextStyle buttonText = TextStyle(fontSize: 16.0);

final TextStyle titleText = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade50);

final TextStyle messageStyle =
    titleText.copyWith(fontSize: 16, fontWeight: FontWeight.normal);

final TextStyle correctMessageStyle = messageStyle.copyWith(
  color: kcSecondaryColor,
);

final TextStyle incorrectMessageStyle = messageStyle.copyWith(
  color: Colors.redAccent,
);

final ThemeData defaultTheme = buildDefaultTheme();

ThemeData buildDefaultTheme() {
  return ThemeData(
      primarySwatch: kcPrimaryColor,
      brightness: Brightness.dark,
      textTheme: TextTheme(button: buttonText, subtitle1: messageStyle),
      buttonTheme: ButtonThemeData(
        minWidth: 150,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 32.0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: incorrectMessageStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.all(16.0),
      ),
      iconTheme: const IconThemeData(color: kcSecondaryColor),
      dividerTheme: const DividerThemeData(
          color: kcSecondaryColor, indent: 2, endIndent: 2),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: kcGrayColor,
        contentTextStyle: correctMessageStyle,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      ),
      dialogTheme: DialogTheme(
          backgroundColor: kcGrayColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
          ),
          titleTextStyle: titleText,
          contentTextStyle: messageStyle));
}
