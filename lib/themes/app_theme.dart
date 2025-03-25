import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.transparent, // Warna background diubah menjadi transparan
  primaryColor: Colors.purple,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.purple,
    accentColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent, // AppBar transparan
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.purple,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
);