import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:holyday_calculator/constraints/values.dart';

ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      onPrimary: Colors.white,
    ),
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
      // backgroundColor: Colors.transparent,
      // foregroundColor: Colors.black,
    ));
