import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    BoxDecoration decoration;
    if (themeProvider.useDefaultGradient) {
      decoration = const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 202, 206, 254), Color.fromARGB(255, 121, 123, 152)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    } else {
      final isDarkMode = themeProvider.isDarkMode;
      final primaryColor = themeProvider.primaryColor;

      Color colorTop;
      Color colorBottom;

      if (isDarkMode) {
        colorTop = Colors.grey.shade900;
        colorBottom = Colors.black;
      } else {
        colorTop = primaryColor.withOpacity(0.3);
        colorBottom = primaryColor.withOpacity(0.7);
      }
      decoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [colorTop, colorBottom],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    }

    return SizedBox.expand(
      child: Container(
        decoration: decoration,
        child: child,
      ),
    );
  }
}