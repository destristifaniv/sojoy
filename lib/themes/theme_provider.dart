import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _primaryColor = Colors.blue;
  bool _useDefaultGradient = true;
  bool _useDefaultNavbar = true; // Tambahkan ini

  ThemeMode get themeMode => _themeMode;
  Color get primaryColor => _primaryColor;
  bool get useDefaultGradient => _useDefaultGradient;
  bool get useDefaultNavbar => _useDefaultNavbar; // Tambahkan getter

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _useDefaultGradient = false;
    _useDefaultNavbar = false; // Nonaktifkan navbar default saat tema diubah
    notifyListeners();
  }

  void setPrimaryColor(Color color) {
    _primaryColor = color;
    _useDefaultGradient = false;
    _useDefaultNavbar = false; // Nonaktifkan navbar default saat warna diubah
    notifyListeners();
  }

  void resetTheme() {
    _themeMode = ThemeMode.light; // Atau ThemeMode.system
    _primaryColor = Colors.blue;
    _useDefaultGradient = true;
    _useDefaultNavbar = true; // Aktifkan kembali navbar default
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        primarySwatch: MaterialColor(_primaryColor.value, getSwatch(_primaryColor)),
        brightness: Brightness.light,
        // ...
      );

  ThemeData get darkTheme => ThemeData(
        primarySwatch: MaterialColor(_primaryColor.value, getSwatch(_primaryColor)),
        brightness: Brightness.dark,
        // ...
      );

  // Generates a swatch map for a given color to use as a MaterialColor
  Map<int, Color> getSwatch(Color color) {
    return {
      50:  _tintColor(color, 0.9),
      100: _tintColor(color, 0.8),
      200: _tintColor(color, 0.6),
      300: _tintColor(color, 0.4),
      400: _tintColor(color, 0.2),
      500: color,
      600: _shadeColor(color, 0.1),
      700: _shadeColor(color, 0.2),
      800: _shadeColor(color, 0.3),
      900: _shadeColor(color, 0.4),
    };
  }

  Color _tintColor(Color color, double factor) =>
      Color.fromRGBO(
        color.red + ((255 - color.red) * factor).round(),
        color.green + ((255 - color.green) * factor).round(),
        color.blue + ((255 - color.blue) * factor).round(),
        1,
      );

  Color _shadeColor(Color color, double factor) =>
      Color.fromRGBO(
        (color.red * (1 - factor)).round(),
        (color.green * (1 - factor)).round(),
        (color.blue * (1 - factor)).round(),
        1,
      );
}