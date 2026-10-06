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

  // Controller များ ပြင်ဆင်ခြင်း
  final _morningCtrl = TextEditingController(text: "0");
  final _afternoonCtrl = TextEditingController(text: "0");
  final _eveningCtrl = TextEditingController(text: "0");
  final _rateCtrl = TextEditingController(text: "50000");
  final _fuelBarrelPriceCtrl = TextEditingController(text: "150000"); // ဆီပေပါဈေးနှုန်း
  final _repairCtrl = TextEditingController(text: "0"); // ပြုပြင်စရိတ်
  final _driverWageCtrl = TextEditingController(text: "30000"); // မောင်းကြေး
  final _customPercentCtrl = TextEditingController(text: "10");
  
  DateTime _selectedDate = DateTime.now(); // နေ့စွဲမှတ်ရန်
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
                    "ဆည်မြောင်း\nဆောက်လုပ်ရေးကား\nစာရင်း", 
                    style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 14),
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
    // 🧮 ပင်မအမြတ်အရှုံး စနစ်တကျ တွက်ချက်မှု အပိုင်း
    int morning = int.tryParse(_morningCtrl.text) ?? 0;
    int afternoon = int.tryParse(_afternoonCtrl.text) ?? 0;
    int evening = int.tryParse(_eveningCtrl.text) ?? 0;
    int totalTrips = morning + afternoon + evening;
    int rate = int.tryParse(_rateCtrl.text) ?? 0;
    
    int totalFare = totalTrips * rate; // ရရှိသော ကားခပေါင်း
    int fuelCost = int.tryParse(_fuelBarrelPriceCtrl.text) ?? 0; // ဆီပေပါဈေးနှုန်း
    int repairCost = int.tryParse(_repairCtrl.text) ?? 0; // ပြုပြင်စရိတ်
    int driverWage = int.tryParse(_driverWageCtrl.text) ?? 0; // မောင်းကြေး
    
    // 💸 အသားတင် အမြတ်/အရှုံး ဖော်မြူလာ = ရရကားခ - ဆီဖိုး - ပြုပြင်စရိတ် - မောင်းကြေး
    int netProfitLoss = totalFare - fuelCost - repairCost - driverWage;
    bool isProfit = netProfitLoss >= 0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ရက်စွဲရွေးချယ်ရန် ကွက် (Date Selector)
          Card(
            color: const Color(0xFF1E1E2C),
            child: ListTile(
              leading: const Icon(Icons.calendar_today, color: Color(0xFFFFD700)),
              title: Text("စာရင်းရက်စွဲ: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"),
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
          const SizedBox(height: 10),

          // 🧊 3D KPI Card ပုံစံဖြင့် အမြတ်/အရှုံး တိုက်ရိုက်ပြသမည့်စနစ်
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black54, offset: Offset(4, 4), blurRadius: 6),
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("ရရှိသော ကားခပေါင်း", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text("$totalFare ကျပ်", style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold))
                  ]
                ),
                Column(
                  children: [
                    Text(isProfit ? "အသားတင် အမြတ်" : "အသားတင် အရှုံး", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text(
                      "${netProfitLoss.abs()} ကျပ်", 
                      style: TextStyle(
                        color: isProfit ? Colors.greenAccent : Colors.redAccent, // အမြတ်စိမ်း / အရှုံးနီ
                        fontSize: 16, 
                        fontWeight: FontWeight.bold
                      )
                    )
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
          _buildNumInput("ဆီပေပါ ဈေးနှုန်း (-)", _fuelBarrelPriceCtrl),
          _buildNumInput("ပြုပြင်စရိတ် (-)", _repairCtrl),
          _buildNumInput("ဒရိုင်ဘာ မောင်းကြေး (-)", _driverWageCtrl),
          
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
                      TableRow(
                        children: [
                          Padding(padding: EdgeInsets.all(6), child: Text("YTN-1111", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၅၀၀,၀၀၀", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၃၂၀,၀၀၀", style: TextStyle(fontSize: 11, color: Colors.greenAccent)))
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(padding: EdgeInsets.all(6), child: Text("YTN-2222", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၄၅၀,၀၀၀", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၂၈၀,၀၀၀", style: TextStyle(fontSize: 11, color: Colors.greenAccent)))
                        ]
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 11, color: Colors.white60),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
        ),
        onChanged: (val) => setState(() {}),
      ),
    );
  }
}
