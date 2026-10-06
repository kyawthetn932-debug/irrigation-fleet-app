import 'package:flutter/material.dart';

void main() {
  runApp(const IrrigationFleetApp());
}

class IrrigationFleetApp extends StatelessWidget {
  const IrrigationFleetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irrigation Fleet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121824), // Slate Dark Background သို့ ပြောင်းလဲထားသည်
      ),
      home: const KoKyawThetNaingLogScreen(),
    );
  }
}

class KoKyawThetNaingLogScreen extends StatefulWidget {
  const KoKyawThetNaingLogScreen({super.key});

  @override
  State<KoKyawThetNaingLogScreen> createState() => _KoKyawThetNaingLogScreenState();
}

class _KoKyawThetNaingLogScreenState extends State<KoKyawThetNaingLogScreen> {
  // Input Controllers 
  final TextEditingController _mornController = TextEditingController(text: "0");
  final TextEditingController _noonController = TextEditingController(text: "0");
  final TextEditingController _nightController = TextEditingController(text: "0");
  final TextEditingController _priceController = TextEditingController(text: "150000");
  final TextEditingController _carFeeController = TextEditingController(text: "50000");
  final TextEditingController _repairController = TextEditingController(text: "0");
  final TextEditingController _driverPercentController = TextEditingController(text: "10");

  // Spreadsheet Style Data List
  final List<Map<String, String>> _sheetRecords = [
    {
      "date": "05/10/2026",
      "count": "12",
      "carFee": "600000",
      "netProfit": "320000",
    }
  ];

  @override
  void dispose() {
    _mornController.dispose();
    _noonController.dispose();
    _nightController.dispose();
    _priceController.dispose();
    _carFeeController.dispose();
    _repairController.dispose();
    _driverPercentController.dispose();
    super.dispose();
  }

  // Cell Editing Dialog Box
  void _editSheetCell(int rowIndex, String key, String title) {
    TextEditingController editCellCtrl = TextEditingController(text: _sheetRecords[rowIndex][key]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F293D),
        title: Text("$title ကို ပြင်ဆင်ရန်", style: const TextStyle(color: Colors.amber)),
        content: TextField(
          controller: editCellCtrl,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ပယ်ဖျက်", style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _sheetRecords[rowIndex][key] = editCellCtrl.text;
              });
              Navigator.pop(context);
            },
            child: const Text("သိမ်းဆည်းမည်", style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  void _saveRecord() {
    int totalQty = (int.tryParse(_mornController.text) ?? 0) +
                   (int.tryParse(_noonController.text) ?? 0) +
                   (int.tryParse(_nightController.text) ?? 0);
    int carFeeAmt = int.tryParse(_carFeeController.text) ?? 0;
    int calculatedTotal = totalQty * carFeeAmt;

    setState(() {
      _sheetRecords.add({
        "date": "06/10/2026",
        "count": totalQty.toString(),
        "carFee": calculatedTotal.toString(),
        "netProfit": "350000", 
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းပြီးပါပြီ။')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ကိုကျော်သက်နိုင် စာရင်း",
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, shadows: [
            Shadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 4),
          ]),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A2333), // AppBar အရောင် ပြောင်းလဲထားသည်
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 📅 ရက်စွဲ
              _build3DContainer(
                child: Row(
                  children: const [
                    Icon(Icons.calendar_month, color: Colors.amber, size: 28),
                    SizedBox(width: 15),
                    Text(
                      "ရက်စွဲ: 6/10/2026",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 💰 တန်ဖိုး/စျေးနှုန်းများ
              Row(
                children: [
                  Expanded(
                    child: _build3DContainer(
                      child: Column(
                        children: const [
                          Text("ကားခခေါင်းစဉ်", style: TextStyle(color: Colors.white54, fontSize: 12)),
                          SizedBox(height: 5),
                          Text("0 ကျပ်", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _build3DContainer(
                      child: Column(
                        children: const [
                          Text("စုစုပေါင်း တန်ဖိုး", style: TextStyle(color: Colors.white54, fontSize: 12)),
                          SizedBox(height: 5),
                          Text("150000 ကျပ်", style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔢 နံနက် / နေ့လည် / ည Input Fields
              Row(
                children: [
                  Expanded(child: _build3DTextField(controller: _mornController, label: "မနက်")),
                  const SizedBox(width: 10),
                  Expanded(child: _build3DTextField(controller: _noonController, label: "နေ့လည်")),
                  const SizedBox(width: 10),
                  Expanded(child: _build3DTextField(controller: _nightController, label: "ည")),
                ],
              ),
              const SizedBox(height: 15),

              // 🔧 Inputs
              _build3DTextField(controller: _carFeeController, label: "တစ်စီးချင်းကားခ"),
              const SizedBox(height: 15),
              _build3DTextField(controller: _priceController, label: "ဆီပေးပါ ဈေးနှုန်း"),
              const SizedBox(height: 15),
              _build3DTextField(controller: _repairController, label: "ပြုပြင်စရိတ်"),
              const SizedBox(height: 20),

              // Dropdown
              _build3DContainer(
                child: DropdownButtonFormField<String>(
                  value: 'option1',
                  dropdownColor: const Color(0xFF1F293D),
                  decoration: const InputDecoration(
                    labelText: "မောင်းကြေးစနစ် ရွေးချယ်ရန်",
                    labelStyle: TextStyle(color: Colors.amber),
                    border: InputBorder.none,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'option1', child: Text("Option 1: မောင်းကြေး ရာခိုင်နှုန်း (%)")),
                    DropdownMenuItem(value: 'option2', child: Text("Option 2: [ကားခ - ဆီဖိုး] %")),
                    DropdownMenuItem(value: 'option3', child: Text("Option 3: ခေါက်ကြေးစနစ်")),
                  ],
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 15),
              _build3DTextField(controller: _driverPercentController, label: "မောင်းကြေး ရာခိုင်နှုန်း (%)"),
              const SizedBox(height: 25),

              // Save Button
              GestureDetector(
                onTap: _saveRecord,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black38, offset: Offset(3, 3), blurRadius: 5),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 📊 Spreadsheet Table
              Row(
                children: const [
                  Icon(Icons.table_chart, color: Colors.teal),
                  SizedBox(width: 10),
                  Text(
                    "နေ့စဉ် ကိုယ်ပိုင်မှတ်တမ်းဇယား",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2333), // Table Background ကို ပိုမှောင်ပြီး လင်းအောင်ညှိသည်
