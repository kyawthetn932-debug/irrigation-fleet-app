import 'package:flutter/material.dart';

void main() {
  runApp(const IrrigationFleetApp());
}

class IrrigationFleetApp extends StatelessWidget {
  const IrrigationFleetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ဆည်မြောင်း ကားစာရင်း',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme.dark(
          primary: Colors.amber,
          surface: Colors.black26,
        ),
      ),
      home: const MainDashboardScreen(),
    );
  }
}

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  String _currentView = "Dashboard";

  final TextEditingController _driverNameController = TextEditingController(text: "ဦးအောင်");
  final TextEditingController _morningTrips = TextEditingController(text: "0");
  final TextEditingController _afternoonTrips = TextEditingController(text: "0");
  final TextEditingController _eveningTrips = TextEditingController(text: "0");
  final TextEditingController _driverRate = TextEditingController(text: "5000");
  final TextEditingController _fuelBarrelPrice = TextEditingController(text: "450000");
  
  int _selectedBarrelGallons = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 280,
            color: const Color(0xFF1E1E1E),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Color(0xFF121212)],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.amber, size: 40),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'ဆည်မြောင်း ကားစာရင်း',
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    children: [
                      _buildSidebarMenuItem("၁။ ပင်မ ဒက်ရှ်ဘုတ်", Icons.dashboard, "Dashboard"),
                      _buildSidebarMenuItem("၂။ ကားပိုင်ရှင်များ & ပြိုင်ဆိုင်မှု", Icons.people, "Owners"),
                      _buildSidebarMenuItem("၃။ နေ့စဉ် ကားခနှင့် ဆီစာရင်းဇယား", Icons.table_chart, "DailyLogs"),
                      _buildSidebarMenuItem("၄။ ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း", Icons.star, "KoKyawThetNaing"),
                      _buildSidebarMenuItem("၅။ ကားပိုင်ရှင် သီးသန့် ရှင်းတမ်းများ", Icons.person_outline, "OtherOwners"),
                      _buildSidebarMenuItem("၆။ ဘဏ္ဍာရေး ခွဲဝေမှုနှင့် စာရင်းချုပ်", Icons.account_balance_wallet, "Finance"),
                      _buildSidebarMenuItem("၇။ စနစ် ဆက်တင်များ", Icons.settings, "Settings"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: _buildMainContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarMenuItem(String title, IconData icon, String viewName) {
    bool isSelected = _currentView == viewName;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.amber : Colors.white70),
      title: Text(title, style: TextStyle(color: isSelected ? Colors.amber : Colors.white)),
      selected: isSelected,
      selectedTileColor: Colors.black26,
      onTap: () {
        setState(() {
          _currentView = viewName;
        });
      },
    );
  }

  Widget _buildMainContent() {
    if (_currentView == "KoKyawThetNaing") {
      return _buildKoKyawThetNaingLedger();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "လုပ်ငန်းခွင် ရွေးချယ်မှု (Site Selector)",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: "တာ-၁",
          items: const [
            DropdownMenuItem(value: "တာ-၁", child: Text("တာ-၁ စီမံကိန်း")),
            DropdownMenuItem(value: "တာ-၂", child: Text("တာ-၂ စီမံကိန်း")),
            DropdownMenuItem(value: "မြေသယ်ဆိုဒ်", child: Text("မြေသယ်ဆိုဒ်")),
          ],
          onChanged: (value) {},
        ),
        const SizedBox(height: 40),
        const Text("ကျန်ရှိသော စာရင်းကဏ္ဍများကို ဘယ်ဘက်မီနူးမှ ရွေးချယ်ကြည့်ရှုနိုင်ပါသည်။"),
      ],
    );
  }

  Widget _buildKoKyawThetNaingLedger() {
    int morning = int.tryParse(_morningTrips.text) ?? 0;
    int afternoon = int.tryParse(_afternoonTrips.text) ?? 0;
    int evening = int.tryParse(_eveningTrips.text) ?? 0;
    int totalTrips = morning + afternoon + evening;
    int rate = int.tryParse(_driverRate.text) ?? 0;
    int totalDriverSalary = totalTrips * rate;
    
    int barrelPrice = int.tryParse(_fuelBarrelPrice.text) ?? 0;
    double pricePerGallon = barrelPrice / _selectedBarrelGallons;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း (ဒရိုင်ဘာ ၂ ဦး ခွဲမှတ်မှု)",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          const SizedBox(height: 25),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _driverNameController,
                  decoration: const InputDecoration(labelText: "ယာဉ်မောင်းအမည် (Driver Name)", border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _morningTrips,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "နံနက် ခေါက်ရေ", border: OutlineInputBorder()),
                  onChanged: (val) => setState(() {}),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: _afternoonTrips,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "နေ့လယ် ခေါက်ရေ", border: OutlineInputBorder()),
                  onChanged: (val) => setState(() {}),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: _eveningTrips,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "ည ခေါက်ရေ", border: OutlineInputBorder()),
                  onChanged: (val) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _driverRate,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "ဒရိုင်ဘာ သတ်မှတ်ခေါက်ကြေးနှုန်း (ကျပ်)", border: OutlineInputBorder()),
            onChanged: (val) => setState(() {}),
          ),
          const SizedBox(height: 25),

          const Text("၁ ပေပါလျှင် သတ်မှတ်ဂါလံ ပမာဏရွေးချယ်ရန်", style: TextStyle(fontSize: 16, color: Colors.blue)),
          const SizedBox(height: 10),
          Row(
            children: [50, 51, 52].map((gallons) {
              return Padding(
                padding: const EdgeInsets.right(15),
                child: ChoiceChip(
                  label: Text("$gallons ဂါလံ"),
                  selected: _selectedBarrelGallons == gallons,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedBarrelGallons = gallons;
                      });
                    }
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _fuelBarrelPrice,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "ဆီပေပါဈေးနှုန်း (ကျပ်)", border: OutlineInputBorder()),
            onChanged: (val) => setState(() {}),
          ),
          
          const SizedBox(height: 35),
          const Divider(),
          
          const Text("📊 တွက်ချက်မှု ရလဒ်များ (Auto Calculations)", style: TextStyle(fontSize: 18, color: Colors.green)),
          const SizedBox(height: 15),
          Text("စုစုပေါင်း ခေါက်ရေ: $totalTrips ခေါက်", style: const TextStyle(fontSize: 16)),
          Text("ဒရိုင်ဘာ မောင်းကြေး စုစုပေါင်း: $totalDriverSalary ကျပ်", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
