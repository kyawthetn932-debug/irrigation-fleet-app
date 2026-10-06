import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialColorApp());
}

class MaterialColorApp extends StatelessWidget {
  const MaterialColorApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ဆည်မြောင်းဆောက်လုပ်ရေးကား စာရင်း',
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

  // Input Controller များ
  final _morningCtrl = TextEditingController(text: "0");
  final _afternoonCtrl = TextEditingController(text: "0");
  final _eveningCtrl = TextEditingController(text: "0");
  final _rateCtrl = TextEditingController(text: "50000");
  final _fuelBarrelPriceCtrl = TextEditingController(text: "150000"); 
  final _repairCtrl = TextEditingController(text: "0"); 
  final _fixedDriverWageCtrl = TextEditingController(text: "5000"); 
  final _customPercentCtrl = TextEditingController(text: "10"); 
  
  DateTime _selectedDate = DateTime.now(); 
  int _driverOption = 1; 

  // ကိုကျော်သက်နိုင် နေ့စဉ်မှတ်တမ်း စာရင်းသိမ်းဆည်းမည့် Local List
  final List<Map<String, dynamic>> _kyawThetNaingLogs = [
    {"date": "05/10/2026", "trips": 12, "fare": 600000, "profit": 320000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentView, 
          style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 16)
        ),
        backgroundColor: const Color(0xFF1E1E2C),
        elevation: 4,
      ),
      drawer: Drawer(
        width: 200, 
        child: Container(
          color: const Color(0xFF1E1E2C), 
          child: Column(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF121212)),
                child: Center(
                  child: Text(
                    "ဆည်မြောင်း\nဆောက်လုပ်ရေးကား\nစာရင်းချုပ်", 
                    style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildSidebarItem(Icons.dashboard, "📁 ၁။ ပင်မ ဒက်ရှ်ဘုတ်"),
                    _buildSidebarItem(Icons.format_list_bulleted, "📄 ၂။ နေ့စဉ် ကားအားလုံးစာရင်း"),
                    _buildSidebarItem(Icons.local_gas_station, "⛽ ၃။ ကားအားလုံး ဆီစာရင်း"),
                    _buildSidebarItem(Icons.assignment, "👤 ၄။ ပိုင်ရှင်များ ကားခရှင်းတမ်း"),
                    _buildSidebarItem(Icons.stars, "👑 ၅။ ကိုကျော်သက်နိုင် စာရင်း"),
                    _buildSidebarItem(Icons.share, "💬 ၆။ Viber Share မော်ဂျူး"),
                    _buildSidebarItem(Icons.settings, "⚙️ ၇။ စနစ်ဆက်တင်များ"),
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
    String viewName = title.substring(4); 
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFFFD700), size: 18),
      title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.white)),
      onTap: () {
        setState(() { _currentView = viewName; });
        Navigator.pop(context); 
      },
    );
  }

  Widget _buildMainContent() {
    if (_currentView == "ကိုကျော်သက်နိုင် စာရင်း") {
      return _buildKyawThetNaingLedger();
    }
    if (_currentView == "ပိုင်ရှင်များ ကားခရှင်းတမ်း") {
      return _buildOwnersCarFareScreen();
    }
    return Center(
      child: Text(
        "Welcome to $_currentView\n[နေရာချထားမှုစနစ် - Google Sheets အသင့်ဖြစ်ပါသည်]", 
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white70, fontSize: 13)
      )
    );
  }

  Widget _buildKyawThetNaingLedger() {
    int morning = int.tryParse(_morningCtrl.text) ?? 0;
    int afternoon = int.tryParse(_afternoonCtrl.text) ?? 0;
    int evening = int.tryParse(_eveningCtrl.text) ?? 0;
    int totalTrips = morning + afternoon + evening;
    int rate = int.tryParse(_rateCtrl.text) ?? 0;
    
    int totalFare = totalTrips * rate; 
    int fuelCost = int.tryParse(_fuelBarrelPriceCtrl.text) ?? 0; 
    int repairCost = int.tryParse(_repairCtrl.text) ?? 0; 
    
    int calculatedDriverWage = 0;
    if (_driverOption == 1) {
      double percent = (int.tryParse(_customPercentCtrl.text) ?? 10) / 100;
      calculatedDriverWage = ((totalFare - fuelCost) * percent).toInt();
    } else if (_driverOption == 2) {
      double percent = (int.tryParse(_customPercentCtrl.text) ?? 10) / 100;
      calculatedDriverWage = (totalFare * percent).toInt();
    } else if (_driverOption == 3) {
      int fixedRate = int.tryParse(_fixedDriverWageCtrl.text) ?? 5000;
      calculatedDriverWage = totalTrips * fixedRate;
    }

    if (calculatedDriverWage < 0) calculatedDriverWage = 0;
    int netProfitLoss = totalFare - fuelCost - repairCost - calculatedDriverWage;
    bool isProfit = netProfitLoss >= 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: const Color(0xFF1E1E2C),
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Color(0xFFFFD700), size: 16),
              title: Text("စာရင်းရက်စွဲ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}", style: const TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() { _selectedDate = picked; });
                }
              },
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(color: Colors.black54, offset: Offset(3, 3), blurRadius: 5)]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("ရရှိသော ကားခပေါင်း", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text("$totalFare ကျပ်", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold))
                  ]
                ),
                Column(
                  children: [
                    Text(isProfit ? "အသားတင် အမြတ်" : "အသားတင် အရှုံး", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(
                      "${netProfitLoss.abs()} ကျပ်", 
                      style: TextStyle(color: isProfit ? Colors.greenAccent : Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold)
                    )
                  ]
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text("🚜 ခေါက်ရေနှင့် ကားခထည့်သွင်းရန် (Numeric)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFFFD700))),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _buildNumInput("မနက်ခေါက်", _morningCtrl)),
              const SizedBox(width: 6),
              Expanded(child: _buildNumInput("နေ့လည်ခေါက်", _afternoonCtrl)),
              const SizedBox(width: 6),
              Expanded(child: _buildNumInput("ညခေါက်", _eveningCtrl)),
            ],
          ),
          _buildNumInput("တစ်စီးချင်းကားခ (Fare)", _rateCtrl),
          _buildNumInput("ဆီပေပါ ဈေးနှုန်း (-)", _fuelBarrelPriceCtrl),
          _buildNumInput("ပြုပြင်စရိတ် (-)", _repairCtrl),
          const SizedBox(height: 10),
          const Text("🧮 ဒရိုင်ဘာ မောင်းကြေး တွက်ချက်မှုစနစ် ရွေးချယ်ရန်", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFFFD700))),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(6)),
