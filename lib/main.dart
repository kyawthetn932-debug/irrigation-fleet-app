import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: IrrigationFleetApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});
  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  String _view = "Dashboard";
  final _morning = TextEditingController(text: "0");
  final _afternoon = TextEditingController(text: "0");
  final _evening = TextEditingController(text: "0");
  final _rate = TextEditingController(text: "5000");
  final _fuelPrice = TextEditingController(text: "10000");
  int _selectedBarrelGallons = 50;

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildNumberInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalTrips = (int.tryParse(_morning.text) ?? 0) + (int.tryParse(_afternoon.text) ?? 0) + (int.tryParse(_evening.text) ?? 0);
    int totalSalary = totalTrips * (int.tryParse(_rate.text) ?? 0);
    double pricePerGallon = (int.tryParse(_fuelPrice.text) ?? 0) / _selectedBarrelGallons;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // မီးခိုးနုရောင် နောက်ခံ
      drawer: Drawer(
        width: 220, // Sidebar အကျဉ်း
        child: Container(
          color: const Color(0xFF1E1E2C),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                color: const Color(0xFF2C2C3E),
                child: const Row(
                  children: [
                    Icon(Icons.local_shipping, color: Colors.amber, size: 28), // ရွှေရောင်ကားအိုင်ကွန်
                    SizedBox(width: 10),
                    Text("ဆည်မြောင်း ကားစာရင်း", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ExpansionTile(
                      leading: const Icon(Icons.apps, color: Colors.amber),
                      title: const Text("လုပ်ငန်းခွင် မီနူးများ", style: TextStyle(color: Colors.white, fontSize: 14)),
                      iconColor: Colors.amber,
                      collapsedIconColor: Colors.white,
                      initiallyExpanded: true,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.dashboard, color: Colors.white70, size: 20),
                          title: const Text("ဒိုင်ယာရီ စာရင်းသွင်း", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          onTap: () { setState(() => _view = "Dashboard"); Navigator.pop(context); },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings, color: Colors.white70, size: 20),
                          title: const Text("ဆော့ဖ်ဝဲ စနစ်များ", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          onTap: () { setState(() => _view = "Settings"); Navigator.pop(context); },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("ဆည်မြောင်း ကားစာရင်း", style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF1E1E2C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _view == "Dashboard" ? _buildDashboard(totalTrips, totalSalary, pricePerGallon) : _buildSettings(),
        ),
      ),
    );
  }

  Widget _buildDashboard(int totalTrips, int totalSalary, double pricePerGallon) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("နေ့စဉ် ခေါင်းအလှည့် စာရင်းသွင်းရန်", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildNumberInput("နံနက်ပိုင်း ခေါင်းအလှည့်အရေအတွက်", _morning),
          _buildNumberInput("မွန်းလွဲပိုင်း ခေါင်းအလှည့်အရေအတွက်", _afternoon),
          _buildNumberInput("ညနေပိုင်း ခေါင်းအလှည့်အရေအတွက်", _evening),
          _buildNumberInput("ယာဉ်မောင်းခနှုန်းထား (Rate)", _rate),
          _buildNumberInput("ဆီစျေးနှုန်း (Fuel Price)", _fuelPrice),
          const SizedBox(height: 10),
          const Text("ဆီပီပါ ဂါလံရွေးချယ်မှု", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          Row(
            children: [50, 51, 52].map((g) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text("$g ဂါလံ"),
                selected: _selectedBarrelGallons == g,
                onSelected: (val) { if (val) setState(() => _selectedBarrelGallons = g); },
              ),
            )).toList(),
          ),
          const SizedBox(height: 15),
          const Divider(),
          const Text("တွက်ချက်မှု ရလဒ်ဇယား (Compact Table)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
          const SizedBox(height: 5),
          Table(
            border: TableBorder.all(color: Colors.black12),
            children: [
              _buildTableRow("စုစုပေါင်းခေါင်းခေါက်", "$totalTrips ကြိမ်"),
              _buildTableRow("စုစုပေါင်း ယာဉ်မောင်းခ", "$totalSalary ကျပ်"),
              _buildTableRow("ရွေးချယ်ထားသည့် ဂါလံ", "$_selectedBarrelGallons ဂါလံ"),
              _buildTableRow("၁ ဂါလံနှုန်း", "${pricePerGallon.toStringAsFixed(2)} ကျပ်"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.system_update, color: Colors.blue),
          title: const Text("ဆော့ဖ်ဝဲ ဗားရှင်း"),
          subtitle: const Text("v1.0.0 (Latest)"),
        ),
        const Divider(),
        const Text("ဆော့ဖ်ဝဲ ပြင်ဆင်မွမ်းမံရန် ဆက်သွယ်ရန်", style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: const Icon(Icons.phone_android, color: Colors.purple),
            title: const Text("Viber Customer Support"),
            subtitle: const Text("လုပ်ငန်းခွင်အချက်အလက်များ ပြင်ဆင်လိုပါက ဆက်သွယ်ရန်"),
          ),
        ),
      ],
    );
  }
}
