import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialColorApp());
}

class MaterialColorApp extends StatelessWidget {
  const MaterialColorApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ရတနာနိုင် - ဆည်မြောင်းကားစာရင်း',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212), // Premium Dark Mode
        primaryColor: const Color(0xFFFFD700), // Amber Gold Accent
      ),
      debugShowCheckedModeBanner: false,
      home: const IrrigationFleetApp(),
    );
  }
}

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});

  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  // ပင်မ စာမျက်နှာ လက်ရှိ ပြသမည့် ခြေရာခံခေါင်းစဉ်
  String _currentView = "Dashboard"; 

  // ဖုန်း Screen မရှုပ်စေရန် ကျစ်ကျစ်လျစ်လျစ် (Compact) ဖြစ်စေမည့် Controller များ
  final _morningCtrl = TextEditingController(text: "0");
  final _afternoonCtrl = TextEditingController(text: "0");
  final _eveningCtrl = TextEditingController(text: "0");
  final _rateCtrl = TextEditingController(text: "50000");
  final _fuelCtrl = TextEditingController(text: "150000");
  final _customPercentCtrl = TextEditingController(text: "10");
  
  // 🧮 Driver မောင်းကြေးတွက်ချက်မှု စနစ် (၃) မျိုးအတွက် Variable
  int _driverOption = 1; // 1: (ကားခ-ဆီဖိုး)%, 2: စိတ်ကြိုက် %, 3: အပြတ်ပေး

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentView, 
          style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)
        ),
        backgroundColor: const Color(0xFF1E1E2C),
        elevation: 4,
      ),
      
      // 📱 ၁။ လက်လှုပ်ရှားမှုဖြင့် ဆွဲထုတ်နိုင်သော (Swipe-to-reveal) Sidebar Dynamic Drawer
      drawer: Drawer(
        width: 190, // ၂။ ဖုန်း Screen ပေါ်တွင် ကျဉ်းမြောင်းကျစ်ကျစ်လျစ်လျစ်ဖြစ်စေမည့် ဘားအကျဉ်းစနစ် (Narrow POS Width)
        child: Container(
          color: const Color(0xFF1E1E2C), // Premium Dark
          child: Column(
            children: [
              // Sidebar Header ပိုင်း
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF121212)),
                child: Center(
                  child: Text(
                    "ရတနာနိုင်\nFLEET SYSTEM", 
                    style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center
                  ),
                ),
              ),
              
              // မီနူးများစာရင်း (Tree & Collapse List Layout)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildSidebarItem(Icons.dashboard, "Dashboard"),
                    
                    // 🌳 ၃။ အဆင့်ဆင့် လိပ်သွင်း/ဖြန့်ချနိုင်သော Tree Navigation Menu (ExpansionTile)
                    ExpansionTile(
                      leading: const Icon(Icons.people, color: Color(0xFFFFD700)),
                      title: const Text("ကားပိုင်ရှင်များ", style: TextStyle(fontSize: 13, color: Colors.white)),
                      iconColor: const Color(0xFFFFD700),
                      collapsedIconColor: Colors.white70,
                      children: [
                        _buildSidebarSubItem("ဦးဖြူ စာရင်း"),
                        _buildSidebarSubItem("ဦးနီ စာရင်း"),
                      ],
                    ),
                    
                    _buildSidebarItem(Icons.local_shipping, "ကိုကျော်သက်နိုင် စာရင်း"),
                    _buildSidebarItem(Icons.settings, "စနစ်ဆက်တင်များ"),
                  ],
                ),
              ),
              
              // 💬 အောက်ခြေ Viber Customer Support Line ခလုတ်
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Viber Chat Link ချိတ်ဆက်ရန် နေရာ
                  },
                  icon: const Icon(Icons.phone_android, size: 14, color: Colors.white),
                  label: const Text("Viber Support", style: TextStyle(fontSize: 11, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Viber ခရမ်းရောင်
                    minimumSize: const Size(double.infinity, 38),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildMainContent(),
        ),
      ),
    );
  }

  // Sidebar ပင်မ မီနူးခလုတ်များနှင့် နှိပ်ပြီးလျှင် Auto-Collapse ပိတ်မည့်စနစ်
  Widget _buildSidebarItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFD700)),
      title: Text(title, style: const TextStyle(fontSize: 13, color: Colors.white)),
      onTap: () {
        setState(() { _currentView = title; });
        Navigator.pop(context); // 🔄 ၄။ ရွေးချယ်ပြီးလျှင် အလိုအလျောက် နောက်ပြန်စုတ်ပိတ်ခြင်း
      },
    );
  }

  // Tree ခွဲအောက်က Sub-menu ခလုတ်များနှင့် ပိတ်မည့်စနစ်
  Widget _buildSidebarSubItem(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 45),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      dense: true,
      onTap: () {
        setState(() { _currentView = title; });
        Navigator.pop(context); // 🔄 Sub-menu ကိုနှိပ်လျှင်လည်း ဘားပြန်ပိတ်ပေးမည်
      },
    );
  }

  // ညာဘက်မျက်နှာပြင်တွင် ဒေတာများ ပြောင်းလဲပြသမည့် စနစ်
  Widget _buildMainContent() {
    if (_currentView == "ကိုကျော်သက်နိုင် စာရင်း") {
      return _buildKyawThetNaingLedger();
    }
    return Center(
      child: Text(
        "Welcome to $_currentView\n(Google Sheets Auto-Sync Active)", 
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white70)
      )
    );
  }

  // 👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်းမျက်နှာပြင်
  Widget _buildKyawThetNaingLedger() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧊 3D Floating KPI Card ပုံစံ (Depth Effect & Shadow)
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black54, offset: Offset(4, 4), blurRadius: 6),
              ]
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("စုစုပေါင်း ကားခ", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    SizedBox(height: 4),
                    Text("၅၀၀,၀၀၀ ကျပ်", style: TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold))
                  ]
                ),
                Column(
                  children: [
                    Text("အသားတင် အမြတ်", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    SizedBox(height: 4),
                    Text("၃၂၀,၀၀၀ ကျပ်", style: TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold))
                  ]
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          
          const Text("🚜 ခေါက်ရေနှင့် ကားခထည့်သွင်းရန် (Numeric Inputs Only)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFD700))),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildNumInput("မနက်ခေါက်", _morningCtrl)),
              const SizedBox(width: 8),
              Expanded(child: _buildNumInput("နေ့လည်ခေါက်", _afternoonCtrl)),
              const SizedBox(width: 8),
              Expanded(child: _buildNumInput("ညခေါက်", _eveningCtrl)),
            ],
          ),
          _buildNumInput("တစ်စီးချင်းကားခ (Fare)", _rateCtrl),
          _buildNumInput("ဆီဖိုး နှုတ်ရန် (-)", _fuelCtrl),
          
          const SizedBox(height: 12),
          const Text("🧮 ဒရိုင်ဘာ မောင်းကြေး တွက်ချက်မှု စနစ် ရွေးချယ်ရန်", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFD700))),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(6)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _driverOption,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E1E2C),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ ရာခိုင်နှုန်း %", style: TextStyle(fontSize: 12))),
                  DropdownMenuItem(value: 2, child: Text("Option 2: စိတ်ကြိုက် ရာခိုင်နှုန်း သတ်မှတ်ရန်", style: TextStyle(fontSize: 12))),
                  DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေးစနစ်", style: TextStyle(fontSize: 12))),
                ],
                onChanged: (val) { setState(() { _driverOption = val!; }); },
              ),
            ),
          ),
          if (_driverOption == 2) const SizedBox(height: 8),
