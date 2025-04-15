import 'package:flutter/material.dart';

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
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4), // semi transparan
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(24),
        //   topRight: Radius.circular(24),
        // ),
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
              color: currentIndex == 0 ? Colors.black : const Color.fromARGB(255, 255, 255, 255),
              size: 28,
            ),
            onPressed: () => onTap(0),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: currentIndex == 2 ? Colors.black : const Color.fromARGB(255, 255, 255, 255),
              size: 28,
            ),
            onPressed: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
