import 'package:flutter/material.dart';
import 'menu_sidebar.dart';
import 'kyawthetnaing_sheet.dart';

void main() {
  runApp(const IrrigationFleetApp());
}

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});

  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  // 🌗 နေ့စွဲ/ညစွဲ Theme ပြောင်းလဲရန် ဗဟိုချက် State စနစ်
  bool _isLightMode = false;

  void _toggleTheme() {
    setState(() {
      _isLightMode = !_isLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irrigation Fleet & POS System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _isLightMode ? Brightness.light : Brightness.dark,
        scaffoldBackgroundColor: _isLightMode ? const Color(0xFFF4F6F9) : const Color(0xFF121824), // ☀️ နေ့ဘက်သုံး အဖြူမှိုင်း / 🌙 ညဘက်သုံး Slate Dark
      ),
      home: MainFleetNavigationScreen(isLightMode: _isLightMode, onThemeToggle: _toggleTheme),
    );
  }
}

class MainFleetNavigationScreen extends StatefulWidget {
  final bool isLightMode;
  final VoidCallback onThemeToggle;
  const MainFleetNavigationScreen({super.key, required this.isLightMode, required this.onThemeToggle});

  @override
  State<MainFleetNavigationScreen> createState() => _MainFleetNavigationScreenState();
}

class _MainFleetNavigationScreenState extends State<MainFleetNavigationScreen> {
  String _activeMenuTitle = "📄 (၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား";

  void _onMenuSelected(String selectedTitle) {
    setState(() {
      _activeMenuTitle = selectedTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 800;
    double titleFontSize = isLargeScreen ? 18.0 : 14.0;

    // နေ့/ည အလိုက် AppBar အရောင် ပြောင်းလဲခြင်း
    Color appBarBg = widget.isLightMode ? Colors.white : const Color(0xFF1A2333);
    Color textColor = widget.isLightMode ? const Color(0xFF121824) : Colors.amber;

    return Scaffold(
      appBar: AppBar(
        title: Text(_activeMenuTitle, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: titleFontSize)),
        backgroundColor: appBarBg,
        elevation: 1,
        actions: [
          // 🌗 နေ့ဘက်/ညဘက် လျှပ်တပြက် အမြန်ပြောင်း Toggle ခလုတ်
          IconButton(
            icon: Icon(widget.isLightMode ? Icons.dark_mode : Icons.light_mode, color: Colors.amber),
            onPressed: widget.onThemeToggle,
          ),
        ],
        leading: !isLargeScreen
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: widget.isLightMode ? Colors.black87 : Colors.amber),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : const Icon(Icons.local_shipping, color: Colors.amber),
      ),
      drawer: !isLargeScreen
          ? Drawer(child: MenuSidebar(activeMenu: _activeMenuTitle, onMenuTap: _onMenuSelected, isDrawer: true, isLightMode: widget.isLightMode))
          : null,
      body: Row(
        children: [
          if (isLargeScreen)
            SizedBox(
              width: screenWidth * 0.20,
              child: Container(
                decoration: BoxDecoration(
                  color: appBarBg,
                  border: const Border(right: BorderSide(color: Colors.white12)),
                ),
                child: MenuSidebar(activeMenu: _activeMenuTitle, onMenuTap: _onMenuSelected, isDrawer: false, isLightMode: widget.isLightMode),
              ),
            ),
          Expanded(
            child: Container(
              width: isLargeScreen ? screenWidth * 0.80 : screenWidth,
              padding: const EdgeInsets.all(6.0),
              child: Card(
                color: widget.isLightMode ? Colors.white : const Color(0xFF1A2333),
                elevation: widget.isLightMode ? 2 : 4,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: KyawThetNaingSheet(
                    isLargeScreen: isLargeScreen,
                    activeSubMenu: _activeMenuTitle,
                    isLightMode: widget.isLightMode,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

