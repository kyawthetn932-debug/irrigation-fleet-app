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
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFFFD700),
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
  String _currentView = "Dashboard"; 

  final _morningCtrl = TextEditingController(text: "0");
  final _afternoonCtrl = TextEditingController(text: "0");
  final _eveningCtrl = TextEditingController(text: "0");
  final _rateCtrl = TextEditingController(text: "50000");
  final _fuelCtrl = TextEditingController(text: "150000");
  final _customPercentCtrl = TextEditingController(text: "10");
  
  int _driverOption = 1;

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
      drawer: Drawer(
        width: 190, 
        child: Container(
          color: const Color(0xFF1E1E2C), 
          child: Column(
            children: [
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
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildSidebarItem(Icons.dashboard, "Dashboard"),
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
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_android, size: 14, color: Colors.white),
                  label: const Text("Viber Support", style: TextStyle(fontSize: 11, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, 
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

  Widget _buildSidebarItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFD700)),
      title: Text(title, style: const TextStyle(fontSize: 13, color: Colors.white)),
      onTap: () {
        setState(() { _currentView = title; });
        Navigator.pop(context); 
      },
    );
  }

  Widget _buildSidebarSubItem(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 45),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      dense: true,
      onTap: () {
        setState(() { _currentView = title; });
        Navigator.pop(context); 
      },
    );
  }

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

  Widget _buildKyawThetNaingLedger() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const Text("🚜 ခေါက်ရေနှင့် ကားခထည့်သွင်းရန် (Numeric Inputs)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFD700))),
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
                onChanged: (val) { 
                  setState(() { _driverOption = val!; }); 
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_driverOption == 2) _buildNumInput("စိတ်ကြိုက် ရာခိုင်နှုန်း ထည့်ရန် (%)", _customPercentCtrl),
          if (_driverOption == 2) const SizedBox(height: 8),
          const Text("📊 ကားပိုင်ရှင်အလိုက် တစ်စီးချင်း ကားခစာရင်း (Tree Table)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 5),
          Card(
            color: const Color(0xFF1E1E2C),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ExpansionTile(
              title: const Text("ဦးဖြူ စာရင်းချုပ် ([▼] နှိပ်၍ ဖြန့်ချရန်)", style: TextStyle(color: Colors.greenAccent, fontSize: 13)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.white12),
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(color: Color(0xFF121212)),
                        children: [
                          Padding(padding: EdgeInsets.all(6), child: Text("ကားနံပါတ်", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("ကားခ (Fare)", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("ရရန်ကျန်ငွေ", style: TextStyle(fontSize: 11)))
                        ]
                      ),
