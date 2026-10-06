import 'package:flutter/material.dart';
import 'menu_sidebar.dart';
import 'dashboard_sheet.dart';
import 'owner_sheet.dart';
import 'fleet_daily_sheet.dart';
import 'single_owner_sheet.dart';
import 'kyawthetnaing_sheet.dart';
import 'finance_share_sheet.dart';

void main() {
  runApp(const IrrigationFleetApp());
}

class IrrigationFleetApp extends StatelessWidget {
  const IrrigationFleetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irrigation Fleet & POS System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121824),
      ),
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
  String _activeMenuTitle = "👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း (၅)";

  void _onMenuSelected(String selectedTitle) {
    setState(() {
      _activeMenuTitle = selectedTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(_activeMenuTitle, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: isLargeScreen ? 20.0 : 15.0)),
        backgroundColor: const Color(0xFF1A2333),
        elevation: 0,
      ),
      drawer: !isLargeScreen
          ? Drawer(child: MenuSidebar(activeMenu: _activeMenuTitle, onMenuTap: _onMenuSelected, isDrawer: true))
          : null,
      body: Row(
        children: [
          if (isLargeScreen)
            SizedBox(
              width: screenWidth * 0.20,
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFF1A2333), border: Border(right: BorderSide(color: Colors.white12))),
                child: MenuSidebar(activeMenu: _activeMenuTitle, onMenuTap: _onMenuSelected, isDrawer: false),
              ),
            ),
          Expanded(
            child: Container(
              width: isLargeScreen ? screenWidth * 0.80 : screenWidth,
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: const Color(0xFF1A2333),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildActiveSheetContent(isLargeScreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSheetContent(bool isLargeScreen) {
    if (_activeMenuTitle.contains("ဒက်ရှ်ဘုတ်")) {
      return DashboardSheet(isLargeScreen: isLargeScreen);
    }
    if (_activeMenuTitle.contains("ကားပိုင်ရှင်များ အမည်စာရင်း") || _activeMenuTitle.contains("ပြိုင်ဆိုင်မှု")) {
      return OwnerSheet(isLargeScreen: isLargeScreen, currentSubMenu: _activeMenuTitle);
    }
    if (_activeMenuTitle.contains("နေ့စဉ် ကားအားလုံး") || _activeMenuTitle.contains("ဆီစာရင်း")) {
      return FleetDailySheet(isLargeScreen: isLargeScreen, currentSubMenu: _activeMenuTitle);
    }
    if (_activeMenuTitle.contains("တစ်ဦးချင်း သီးသန့်စာရင်း")) {
      return SingleOwnerSheet(isLargeScreen: isLargeScreen);
    }
    if (_activeMenuTitle.contains("ကိုကျော်သက်နိုင် သီးသန့်")) {
      return KyawThetNaingSheet(isLargeScreen: isLargeScreen);
    }
    if (_activeMenuTitle.contains("ကြိုတင်ငွေ") || _activeMenuTitle.contains("Viber") || _activeMenuTitle.contains("Master Log")) {
      return FinanceShareSheet(isLargeScreen: isLargeScreen, currentSubMenu: _activeMenuTitle);
    }
    
    return const Center(child: Text("စာရင်းဇယား မရှိသေးပါ။"));
  }
}
