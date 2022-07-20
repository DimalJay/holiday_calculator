import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holyday_calculator/constraints/values.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    surface: primaryColor,
    secondary: primaryColor,
  ),
  textTheme: GoogleFonts.latoTextTheme(TextTheme(
    bodyText1: ThemeData.light()
        .textTheme
        .bodyText1
        ?.copyWith(fontSize: kSmallFontSize),
    headline5: ThemeData.light()
        .textTheme
        .headline5
        ?.copyWith(fontSize: kLargeFontSize, fontWeight: FontWeight.bold),
    headline6: ThemeData.light()
        .textTheme
        .headline6
        ?.copyWith(fontSize: kMeadiumFontSize),
  )),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
  ),
);
