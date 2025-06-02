import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sojoy/themes/theme_provider.dart'; // Import ThemeProvider
import 'screens/home_screen.dart';
import 'screens/add_journal_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/bottom_navbar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Tambahkan ini untuk mengakses tema

    return MaterialApp(
      key: ValueKey(themeProvider.themeMode),
      title: 'SoJoy',
      theme: themeProvider.lightTheme, // Gunakan tema dari ThemeProvider
      darkTheme: themeProvider.darkTheme, // Gunakan tema gelap dari ThemeProvider
      themeMode: themeProvider.themeMode, // Gunakan themeMode dari ThemeProvider
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    AddJournalScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple.shade800, // Warna ungu tua di atas
            Colors.grey.shade900,       // Warna abu-abu tua di bawah
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Scaffold transparan
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}