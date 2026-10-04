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

  // Text Controllers for Exact Numeric Inputs (No sliders)
  final _morning = TextEditingController(text: "0");
  final _afternoon = TextEditingController(text: "0");
  final _evening = TextEditingController(text: "0");
  final _rate = TextEditingController(text: "5000");
  final _fuelPrice = TextEditingController(text: "10000");

  int _selectedBarrelGallons = 50; // Dynamic 50, 51, 52 selection

  @override
  Widget build(BuildContext context) {
    // Math Formulas
    int totalTrips = (int.tryParse(_morning.text) ?? 0) +
        (int.tryParse(_afternoon.text) ?? 0) +
        (int.tryParse(_evening.text) ?? 0);
    int totalSalary = totalTrips * (int.tryParse(_rate.text) ?? 0);
    int totalFuelPrice = int.tryParse(_fuelPrice.text) ?? 0;
    double pricePerGallon = totalFuelPrice / _selectedBarrelGallons;

    return Scaffold(
      // သန့်ရှင်းသပ်ရပ်ပြီး မျက်စိအေးစေမည့် မီးခိုးနုရောင် (Soft Light Gray) နောက်ခံ
      backgroundColor: const Color(0xFFF5F5F5),
      
      // ဘယ်ဘက်အစွန်းမှ လက်မဖြင့် ပွတ်ဆွဲရုံဖြင့် ပေါ်လာမည့် Swipe Left Sidebar Menu
      drawer: Drawer(
        width: 220, // ဖုန်းမျက်နှာပြင်တွင် မရှုပ်စေရန် မီနူးဘားကို ကျဉ်းပေးထားပါသည်
        child: Container(
          color: const Color(0xFF1E1E2C), // Black/Dark Slate background for POS look
          child: Column(
            children: [
              // Sidebar Header (ရွှေရောင် Dump Truck Icon နှင့် ခေါင်းစဉ်)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C2C3E), Color(0xFF1E1E2C)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    ),
                  ),
                child: const Row(
                  children: [
                    Icon(Icons.local_shipping, color: Colors.amber, size: 28),
                    SizedBox(width: 10),
                    Text(
                      "ဆည်မြောင်း ကားစာရင်း",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // POS Style Tree Menu (ExpansionTile - အဆင့်ဆင့်ခွဲထွက်မည့် မီနူးဘား)
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ExpansionTile(
                      leading: const Icon(Icons.apps, color: Colors.amber),
                      title: const Text("လုပ်ငန်းခွင် မီနူးများ", style: TextStyle(color: Colors.white, fontSize: 14)),
                      iconColor: Colors.amber,
                      collapsedIconColor: Colors.white,
                      childrenPadding: const EdgeInsets.only(left: 15),
                      children: [
                        ListTile(
                          leading: const Icon(Icons.dashboard, color: Colors.white70, size: 20),
                          title: const Text("ဒိုင်ယာရီ စာရင်းသွင်း", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          onTap: () {
                            setState(() => _view = "Dashboard");
                            Navigator.pop(context); // ခေါင်းစဉ်နှိပ်လျှင် Sidebar ပြန်ဝင်သွားမည်
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings, color: Colors.white70, size: 20),
                          title: const Text("ဆော့ဖ်ဝဲ စနစ်များ", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          onTap: () {
                            setState(() => _view = "Settings");
                            Navigator.pop(context); // ခေါင်းစဉ်နှိပ်လျှင် Sidebar ပြန်ဝင်သွားမည်
                          },
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
        title: const Text("ဆည်မြောင်း ကားစာရင်း", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E2C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _view == "Dashboard"
              ? _buildDashboard(totalTrips, totalSalary, pricePerGallon)
              : _buildSettings(totalSalary),
        ),
      ),
    );
  }

  // ၁။ ဒိုင်ယာရီ စာရင်းသွင်း မျက်နှာပြင်
  Widget _buildDashboard(int totalTrips, int totalSalary, double pricePerGallon) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("နေ့စဉ် ခေါင်းအလှည့် စာရင်းသွင်းရန်", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          
          // Exact Numeric Inputs for Shifts
          _buildNumberInput("နံနက်ပိုင်း ခေါင်းအလှည့်အရေအတွက်", _morning),
          _buildNumberInput("မွန်းလွဲပိုင်း ခေါင်းအလှည့်အရေအတွက်", _afternoon),
          _buildNumberInput("ညနေပိုင်း ခေါင်းအလှည့်အရေအတွက်", _evening),
          _buildNumberInput("ယာဉ်မောင်းခနှုန်းထား (Rate)", _rate),
          _buildNumberInput("ဆီစျေးနှုန်း (Fuel Price)", _fuelPrice),
          
          const SizedBox(height: 10),
          const Text("ဆီပီပါ ဂါလံရွေးချယ်မှု (Barrel Gallons Control)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [50, 51, 52].map((gallons) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text("$gallons ဂါလံ"),
                  selected: _selectedBarrelGallons == gallons,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedBarrelGallons = gallons);
                    }
                  },
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          const Divider(height: 1, color: Colors.grey),
          const SizedBox(height: 15),
          
          // ၂။ Compact Table - ဖုန်းမျက်နှာပြင်တွင် မရှုပ်စေရန် အကျဉ်းချုံ့ထားသော စာရင်းဇယားကွက်
          const Text("တွက်ချက်မှု ရလဒ်ဇယား (Compact Results)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue)),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Colors.black12, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1),
            },
            children: [
              _buildTableRow("စုစုပေါင်းခေါင်းခေါက်", "$totalTrips ကြိမ်"),
              _buildTableRow("စုစုပေါင်း ယာဉ်မောင်းခ", "$totalSalary ကျပ်"),
              _buildTableRow("ရွေးချယ်ထားသည့် ဂါလံ", "$_selectedBarrelGallons ဂါလံ"),
              _buildTableRow("၁ ဂါလံနှုန်း (Price/Gal)", "${pricePerGallon.toStringAsFixed(2)} ကျပ်"),
            ],
          ),
        ],
      ),
    );
  }

  // ၃။ ဆော့ဖ်ဝဲ စနစ်များ မျက်နှာပြင်
  Widget _buildSettings(int totalSalary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("ဆော့ဖ်ဝဲ စနစ်များနှင့် အချက်အလက်များ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ListTile(
          leading: const Icon(Icons.system_update, color: Colors.blue),
          title: const Text("ဆော့ဖ်ဝဲ ဗားရှင်း (App Version)"),
          subtitle: const Text("v1.0.0 (Latest)"),
          trailing: ElevatedButton(
            onPressed: () {},
            child: const Text("Check Update"),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(height: 1, color: Colors.grey),
        const SizedBox(height: 20),
        
        // ၄။ Customer Line - လိုအပ်လျှင် ပြင်ဆင်ရန် ကာစတန်မာလိုင်း (Viber Support Place)
        const Text("ဆော့ဖ်ဝဲ ပြင်ဆင်မွမ်းမံရန် ဆက်သွယ်ရန်", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          color: Colors.white,
          child: ListTile(
            leading: const Icon(Icons.phone_android, color: Colors.purple),
            title: const Text("Viber Customer Support", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("ကုဒ်များနှင့် လုပ်ငန်းခွင်အချက်အလက်များ ထပ်မံပြင်ဆင်လိုပါက ဆက်သွယ်ရန်"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Future Integration: လိုအပ်ပါက သင့် viber Link သို့မဟုတ် Phone နံပါတ်သို့ ချိတ်ဆက်နိုင်ပါသည်
            },
          ),
        ),
      ],
    );
  }

  // Helper Widget: Exact Numeric Input Textfields
  Widget _buildNumberInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
