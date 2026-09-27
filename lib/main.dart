import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/theme_service.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: const LuxuryApp(),
    ),
  );
}

class LuxuryApp extends StatelessWidget {
  const LuxuryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return MaterialApp(
      title: 'Luxury App',
      debugShowCheckedModeBanner: false,
      theme: themeService.currentTheme,
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({Key? key}) : super(key: key);

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 3; // Defaulting to Settings tab for demonstration

  final List<Widget> _screens = [
    const Center(child: Text('Dashboard Screen (Pre-existing)', style: TextStyle(fontSize: 18))),
    const Center(child: Text('Interactive List Screen (Pre-existing)', style: TextStyle(fontSize: 18))),
    const Center(child: Text('Authentication Screen (Pre-existing)', style: TextStyle(fontSize: 18))),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final primaryGold = Theme.of(context).primaryColor;
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).cardColor,
        selectedItemColor: primaryGold,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_outline),
            activeIcon: Icon(Icons.lock),
            label: 'Auth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}