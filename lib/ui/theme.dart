import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color cyan = Colors.cyan;
const Color black = Colors.black;
const Color grey = Colors.grey;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {

  static final light = ThemeData(
    primaryColor: orangeClr,
    backgroundColor: primaryClr,
    brightness: Brightness.light,

    appBarTheme: const AppBarTheme(
      backgroundColor: orangeClr,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: black,
        size: 24,
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: black,
          fontSize: 30,
          fontWeight: FontWeight.w800,
          fontFamily: 'lato'
      ),
    ),

    textTheme: const TextTheme(
      headline1: TextStyle(
        color: black,
        fontSize: 30,
        fontWeight: FontWeight.w600,
        fontFamily: 'lato'
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: darkHeaderClr,
      ),
      headline3: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        fontFamily: 'lato',
        color: white,
      ),
      headline4: TextStyle(
        color: white,
        fontSize: 16,
        fontFamily: 'lato'
      ),
      headline5: TextStyle(
          color: black,
          fontSize: 18,
          fontFamily: 'lato'
      ),
      headline6: TextStyle(
          color: black,
          fontSize: 22,
          fontFamily: 'lato',
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static final dark = ThemeData(
    primaryColor: bluishClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,

    appBarTheme: const AppBarTheme(
      backgroundColor: bluishClr,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: white,
        size: 24,
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
    ),

    textTheme: const TextTheme(
      headline1: TextStyle(
        color: white,
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: grey,
      ),
      headline3: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        fontFamily: 'lato',
        color: white,
      ),
      headline4: TextStyle(
          color: white,
          fontSize: 16,
          fontFamily: 'lato'
      ),
      headline5: TextStyle(
          color: white,
          fontSize: 18,
          fontFamily: 'lato'
      ),
      headline6: TextStyle(
          color: white,
          fontSize: 22,
          fontFamily: 'lato',
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: grey,
      ),
    ),
  );

}