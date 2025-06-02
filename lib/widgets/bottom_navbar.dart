import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart'; // Import ThemeProvider

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final primaryColor = themeProvider.primaryColor;
    final useDefaultNavbar = themeProvider.useDefaultNavbar;

    Color iconColor;
    Color unselectedIconColor;
    Color navBarBackgroundColor;
    Color addButtonColor;
    Color addButtonIconColor;

    if (useDefaultNavbar) {
      navBarBackgroundColor = Colors.white.withOpacity(0.4);
      iconColor = Colors.black;
      unselectedIconColor = const Color.fromARGB(255, 255, 255, 255);
      addButtonColor = const Color.fromARGB(255, 255, 255, 255);
      addButtonIconColor = const Color.fromARGB(255, 0, 0, 0);
    } else {
      iconColor = isDarkMode ? Colors.white : Colors.black;
      unselectedIconColor = isDarkMode ? Colors.white70 : Colors.black54;
      navBarBackgroundColor = Theme.of(context).colorScheme.surface.withOpacity(0.4);
      addButtonColor = primaryColor;
      addButtonIconColor = Theme.of(context).colorScheme.onPrimary;
    }

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: navBarBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? iconColor : unselectedIconColor,
              size: 28,
            ),
            onPressed: () => onTap(0),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: addButtonColor,
              ),
              child: Icon(Icons.add, color: addButtonIconColor, size: 30),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: currentIndex == 2 ? iconColor : unselectedIconColor,
              size: 28,
            ),
            onPressed: () => onTap(2),
          ),
        ],
      ),
    );
  }
}