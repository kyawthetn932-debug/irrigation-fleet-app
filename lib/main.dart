import 'package:flutter/material.dart';
import 'kyawthetnaing_sheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irrigation Fleet App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const MainFleetNavigationScreen(),
    );
  }
}

class MainFleetNavigationScreen extends StatefulWidget {
  const MainFleetNavigationScreen({super.key});

  @override
  State<MainFleetNavigationScreen> createState() => _MainFleetNavigationScreenState();
}

class _MainFleetNavigationScreenState extends State<MainFleetNavigationScreen> {
  final String _activeMenuTitle = '၅.၅ နေ့စဉ်မှတ်တမ်းစာရင်းချုပ်';
  final bool _isLightMode = false;
  final Color appBgColor = const Color(0xFF121212);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: appBgColor,
      body: Row(
        children: [
          if (isLargeScreen)
            SizedBox(
              width: screenWidth * 0.20,
              child: Container(
                decoration: BoxDecoration(
                  color: appBgColor,
                  border: const Border(right: BorderSide(color: Colors.white12)),
                ),
                child: Center(
                  child: Text(
                    _activeMenuTitle,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          const Expanded(
            child: KyawThetNaingSheet(),
          ),
        ],
      ),
    );
  }
}
