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
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _driverOption,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E1E2C),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ % တွက်ခြင်း", style: TextStyle(fontSize: 12))),
                  DropdownMenuItem(value: 2, child: Text("Option 2: စိတ်ကြိုက် ဝင်ငွေ၏ % တွက်ခြင်း", style: TextStyle(fontSize: 12))),
                  DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေးစနစ်", style: TextStyle(fontSize: 12))),
                ],
                onChanged: (val) { setState(() { _driverOption = val!; }); },
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_driverOption == 1 || _driverOption == 2) 
            _buildNumInput("မောင်းကြေး ရာခိုင်နှုန်း (%)", _customPercentCtrl),
          if (_driverOption == 3) 
            _buildNumInput("တစ်ခေါက်ချင်း အပြတ်ကြေး (ကျပ်)", _fixedDriverWageCtrl),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _kyawThetNaingLogs.insert(0, {
                  "date": "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  "trips": totalTrips,
                  "fare": totalFare,
                  "profit": netProfitLoss,
                });
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), minimumSize: const Size(double.infinity, 38)),
            child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(height: 16),
          const Text("📊 နေ့စဉ် ကိုယ်ပိုင်မှတ်တမ်းဇယား (Daily Log Grid)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFFFD700))),
          const SizedBox(height: 6),
          Table(
            border: TableBorder.all(color: Colors.white12),
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFF1E1E2C)),
                children: [
                  Padding(padding: EdgeInsets.all(5), child: Text("နေ့စွဲ", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(5), child: Text("ခေါက်ရေ", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(5), child: Text("ကားခစုစုပေါင်း", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(5), child: Text("အမြတ်/အရှုံး", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                ]
              ),
              ..._kyawThetNaingLogs.map((log) {
                bool logProfit = log["profit"] >= 0;
                return TableRow(
                  children: [
                    Padding(padding: const EdgeInsets.all(5), child: Text(log["date"], style: const TextStyle(fontSize: 10))),
                    Padding(padding: const EdgeInsets.all(5), child: Text("${log["trips"]}", style: const TextStyle(fontSize: 10))),
                    Padding(padding: const EdgeInsets.all(5), child: Text("${log["fare"]}", style: const TextStyle(fontSize: 10))),
                    Padding(
                      padding: const EdgeInsets.all(5), 
                      child: Text("${log["profit"]}", style: TextStyle(fontSize: 10, color: logProfit ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold))
                    ),
                  ]
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOwnersCarFareScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("📊 ကားပိုင်ရှင်အလိုက် တစ်စီးချင်း ကားခစာရင်း (Tree Table)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
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
