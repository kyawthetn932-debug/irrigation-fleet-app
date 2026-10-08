import 'package:flutter/material.dart';
import 'kyawthetnaing_sheet.dart'; // 💾 ဖိုင်အသစ်အား စာလုံးအသေးဖြင့် စနစ်တကျ Import ခေါ်ထားပါသည်

void main() => runApp(const MaterialApp(home: MainFleetNavigationScreen(), debugShowCheckedModeBanner: false));

class MainFleetNavigationScreen extends StatefulWidget {
  const MainFleetNavigationScreen({super.key});
  @override
  State<MainFleetNavigationScreen> createState() => _MainFleetNavigationScreenState();
}

class _MainFleetNavigationScreenState extends State<MainFleetNavigationScreen> {
  String _currentView = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(_currentView, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
        backgroundColor: const Color(0xFF1E1E2C),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF1E1E2C),
          child: ListView(
            children: [
              const DrawerHeader(child: Center(child: Text("ဆည်မြောင်းဆောက်လုပ်ရေး\nကားစာရင်းချုပ်", style: TextStyle(color: Colors.amber, fontSize: 14), textAlign: TextAlign.center))),
              ListTile(
                leading: const Icon(Icons.dashboard, color: Colors.amber),
                title: const Text("📁 ၁။ ပင်မ ဒက်ရှ်ဘုတ်"),
                onTap: () { setState(() { _currentView = "Dashboard"; }); Navigator.pop(context); },
              ),
              ListTile(
                leading: const Icon(Icons.stars, color: Colors.amber),
                title: const Text("👑 ၂။ ကိုကျော်သက်နိုင် စာရင်း"),
                onTap: () { setState(() { _currentView = "ကိုကျော်သက်နိုင် စာရင်း"; }); Navigator.pop(context); },
              ),
            ],
          ),
        ),
      ),
      body: _currentView == "ကိုကျော်သက်နိုင် စာရင်း"
          ? const kyawthetnaingsheet(islargescreen: false) // 💾 Class နာမည်အသစ်အား စာလုံးအသေးဖြင့် တိကျစွာ ချိတ်ဆက်ထားပါသည်
          : const Center(child: Text("Welcome to Dashboard\n[Google Sheets Active]", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70))),
    );
  }
}
