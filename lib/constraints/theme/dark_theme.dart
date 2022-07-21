import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holyday_calculator/constraints/theme/navigation_theme.dart';
import 'package:holyday_calculator/constraints/values.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    onPrimary: Colors.white,
    surface: primaryColor,
    secondary: primaryColor,
  ),
  pageTransitionsTheme: pageTransitionsTheme,
  textTheme: GoogleFonts.nunitoSansTextTheme(TextTheme(
    bodyText1: ThemeData.dark()
        .textTheme
        .bodyText1
        ?.copyWith(fontSize: kSmallFontSize),
    headline5: ThemeData.dark()
        .textTheme
        .headline5
        ?.copyWith(fontSize: kLargeFontSize, fontWeight: FontWeight.bold),
    headline6: ThemeData.dark()
        .textTheme
        .headline6
        ?.copyWith(fontSize: kMeadiumFontSize, fontWeight: FontWeight.w500),
  )),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white, size: 24.0),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(primaryColor),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kBorderRadius * .2),
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white60),
  switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(primaryColor),
      trackColor: MaterialStateProperty.all(primaryColor.withOpacity(0.4))),
);
