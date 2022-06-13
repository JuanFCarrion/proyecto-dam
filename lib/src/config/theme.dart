import 'package:flutter/material.dart';

import 'package:proyecto_dam/src/constants/constant.dart';
import 'package:proyecto_dam/src/utils/color.dart';

class AppThemeData {
  static final lightTheme = _baseTheme.copyWith(
    backgroundColor: white,
    primaryColor: white,
    scaffoldBackgroundColor: greyMainBackground,
    appBarTheme: const AppBarTheme(
      foregroundColor: greyLetter,
      backgroundColor: white,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: greyMainBackground,
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: greyLetter),
      bodyText2: TextStyle(color: greyLetter),
      button: TextStyle(color: greyLetter),
      caption: TextStyle(color: greyLetter),
      headline1: TextStyle(color: greyLetter),
      headline2: TextStyle(color: greyLetter),
      headline3: TextStyle(color: greyLetter),
      headline4: TextStyle(color: greyLetter),
      headline5: TextStyle(color: greyLetter),
      headline6: TextStyle(color: black),
      overline: TextStyle(color: greyLetter),
      subtitle1: TextStyle(color: greyLetter),
      subtitle2: TextStyle(color: greyLetter),
      // bodyLarge: const TextStyle(color: greyLetter),
    ),
    // textSelectionTheme: const TextSelectionThemeData(cursorColor: greyLetter),
  );

  static final darkTheme = _baseTheme.copyWith(
    backgroundColor: black,
    primaryColor: black,
    scaffoldBackgroundColor: const Color(0xFF212121),
    appBarTheme: const AppBarTheme(
      backgroundColor: black,
      foregroundColor: white,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF212121),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: white),
      bodyText2: TextStyle(color: white),
      button: TextStyle(color: white),
      caption: TextStyle(color: white),
      headline1: TextStyle(color: white),
      headline6: TextStyle(color: white),
      overline: TextStyle(color: white),
      subtitle1: TextStyle(color: white),
      subtitle2: TextStyle(color: white),
    ),
    // // primarySwatch: Colors.grey,
    // primaryColor: Colors.black,
    // brightness: Brightness.dark,
    // backgroundColor: const Color(0xFF212121),
    // dividerColor: Colors.black12,
  );
}

final ThemeData _baseTheme = ThemeData(
  primaryColorDark: red,
  primaryIconTheme: const IconThemeData(color: red),
  hoverColor: red,

  // Lnea divisora de ListView
  dividerColor: greyMainBackground,
  // Fondo icono segundo plano

  // TextField bordes
  inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: redButtons1, width: 2.0))),
  // TextField color de iconos, etiquetas y cursor
  primarySwatch: redButtons1.toMaterialColor(),
  fontFamily: 'poppins',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: redButtons2,
    foregroundColor: lightOrangeBackground,
  ),
  // AppBar fondo e iconos
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    iconTheme: IconThemeData(color: redButtons2),
  ),

  // errorColor: Colors.red,
  // hintColor:, // Color texto 'oculto' o de fondo
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      // ZoomPageTransitionsBuilder : Acerca la nueva página, similar a una en Android 10
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      // CupertinoPageTransitionsBuilder : Transición de página horizontal, igual que las transiciones de página nativas de iOS
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      // FadeUpwardsPageTransitionsBuilder : desvanece la página a medida que se desliza hacia arriba
      // OpenUpwardsPageTransitionsBuilder : desliza la página hacia arriba, similar a la de Android P
    },
  ),
);
