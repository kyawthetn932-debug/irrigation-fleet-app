import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  final bool isLargeScreen;
  final String activeSubMenu;
  final bool isLightMode;

  const KyawThetNaingSheet({
    super.key, 
    required this.isLargeScreen, 
    required this.activeSubMenu, 
    required this.isLightMode
  });

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  String _globalDefaultRate = "50000";
  String _selectedDriverOption = "option1";
  String _driverOptionValue = "10"; 

  // Input Controllers
  final TextEditingController _dateCtrl = TextEditingController(text: "07/10/2026");
  final TextEditingController _rateCtrl = TextEditingController(text: "50000");
  final TextEditingController _mornCtrl = TextEditingController(text: "00");
  final TextEditingController _noonCtrl = TextEditingController(text: "00");
  final TextEditingController _nightCtrl = TextEditingController(text: "00");

  final TextEditingController _shareAdvanceCtrl = TextEditingController(text: "0");
  final TextEditingController _privateAdvanceCtrl = TextEditingController(text: "0");

  final TextEditingController _d1NameCtrl = TextEditingController(text: "မောင်မောင်");
  final TextEditingController _d1TripsCtrl = TextEditingController(text: "0");
  final TextEditingController _d1AdvanceCtrl = TextEditingController(text: "0");
  final TextEditingController _d2NameCtrl = TextEditingController(text: "အောင်အောင်");
  final TextEditingController _d2TripsCtrl = TextEditingController(text: "0");
  final TextEditingController _d2AdvanceCtrl = TextEditingController(text: "0");

  final TextEditingController _fuelCtrl = TextEditingController(text: "0");
  final TextEditingController _foodCtrl = TextEditingController(text: "0");
  final TextEditingController _repairCtrl = TextEditingController(text: "0");

  // 📊 ဗဟိုချက် ဒေတာသိုလှောင်မှု ဇယား (Central Shared Database)
  final List<Map<String, String>> _centralDatabase = [
    {
      "date": "06/10/2026", "morn": "04", "noon": "04", "night": "02", "rate": "50000",
      "shareAdvance": "200000", "privateAdvance": "100000",
      "d1Name": "မောင်မောင်", "d1Trips": "5", "d1Advance": "20000",
      "d2Name": "အောင်အောင်", "d2Trips": "5", "d2Advance": "15000",
      "fuel": "700000", "food": "10000", "repair": "5000"
    }
  ];

  Map<String, int> _calculateMetrics(Map<String, String> row) {
    int morn = int.tryParse(row["morn"] ?? "0") ?? 0;
    int noon = int.tryParse(row["noon"] ?? "0") ?? 0;
    int night = int.tryParse(row["night"] ?? "0") ?? 0;
    int rate = int.tryParse(row["rate"] ?? "0") ?? 0;
    int fuel = int.tryParse(row["fuel"] ?? "0") ?? 0;
    int food = int.tryParse(row["food"] ?? "0") ?? 0;
    int repair = int.tryParse(row["repair"] ?? "0") ?? 0;
    
    int totalTrips = morn + noon + night;
    int totalRevenue = totalTrips * rate;

    double driverFactor = double.tryParse(_driverOptionValue) ?? 0;
    int driverFeeTotal = 0;
    if (_selectedDriverOption == "option1") {
      driverFeeTotal = (totalRevenue * (driverFactor / 100)).round();
    } else if (_selectedDriverOption == "option2") {
      driverFeeTotal = ((totalRevenue - fuel) * (driverFactor / 100)).round();
      if (driverFeeTotal < 0) driverFeeTotal = 0;
    } else {
      driverFeeTotal = (totalTrips * driverFactor).round();
    }

    return {
      "totalTrips": totalTrips,
      "totalRevenue": totalRevenue,
      "driverFeeTotal": driverFeeTotal,
      "netProfit": totalRevenue - (fuel + food + repair + driverFeeTotal)
    };
  }

  void _saveCurrentForm() {
    setState(() {
      _centralDatabase.add({
        "date": _dateCtrl.text,
        "morn": _mornCtrl.text.padLeft(2, '0'), "noon": _noonCtrl.text.padLeft(2, '0'), "night": _nightCtrl.text.padLeft(2, '0'),
        "rate": _rateCtrl.text,
        "shareAdvance": _shareAdvanceCtrl.text, "privateAdvance": _privateAdvanceCtrl.text,
        "d1Name": _d1NameCtrl.text, "d1Trips": _d1TripsCtrl.text, "d1Advance": _d1AdvanceCtrl.text,
        "d2Name": _d2NameCtrl.text, "d2Trips": _d2TripsCtrl.text, "d2Advance": _d2AdvanceCtrl.text,
        "fuel": _fuelCtrl.text, "food": _foodCtrl.text, "repair": _repairCtrl.text
      });
      _mornCtrl.text = "00"; _noonCtrl.text = "00"; _nightCtrl.text = "00";
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('လုပ်ငန်းခွင်ဒေတာအား အောက်ခြေဇယားထဲသို့ သိမ်းဆည်းပြီးပါပြီ။')));
  }

  void _editCell(int index, String key, String title, bool isTripField) {
    TextEditingController cellEditCtrl = TextEditingController(text: _centralDatabase[index][key]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F293D),
        title: Text("$title ကို ပြင်ရန်", style: const TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.w900)),
        content: TextField(
          controller: cellEditCtrl, keyboardType: TextInputType.number, maxLength: isTripField ? 2 : null,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("ပယ်ဖျက်")),
          TextButton(
            onPressed: () {
              setState(() {
                String val = cellEditCtrl.text.trim();
                if (isTripField && val.length == 1) val = "0$val";
                _centralDatabase[index][key] = val.isEmpty ? "0" : val;
                if (key == "rate") _globalDefaultRate = val; 
              });
              Navigator.pop(context);
            },
            child: const Text("သိမ်းမည်", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController ctrl, String label, {bool isTrip = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: widget.isLightMode ? Colors.white : const Color(0xFF121824),
        border: Border.all(color: Colors.amber, width: 1.4),
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextField(
        controller: ctrl, keyboardType: TextInputType.number, maxLength: isTrip ? 2 : null,
        style: TextStyle(color: widget.isLightMode ? const Color(0xFF121824) : Colors.white, fontSize: 13.0, fontWeight: FontWeight.w900),
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold), border: InputBorder.none, counterText: ""),
      ),
    );
  }

  Widget _buildTableContainer({required Map<int, TableColumnWidth> columnWidths, required List<String> headers, required List<TableRow> rows}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.white12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          columnWidths: columnWidths,
          border: TableBorder.all(color: widget.isLightMode ? Colors.black26 : Colors.white24, width: 1.2),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: Color(0xFF243147)),
              children: headers.map((h) => Padding(padding: const EdgeInsets.all(6.0), child: Text(h, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 11.5), textAlign: TextAlign.center))).toList(),
            ),
            ...rows
          ],
        ),
      ),
    );
  }

  Widget _buildCellText(String text, VoidCallback onTap, Color textColor, {bool isCenter = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: 12.5), textAlign: isCenter ? TextAlign.center : TextAlign.right),
      ),
    );
  }

  Widget _buildActionSaveButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(38)),
      onPressed: _saveCurrentForm,
      icon: const Icon(Icons.save, size: 16),
      label: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.5)),
    );
  }

  Widget _buildActiveFormSection() {
    if (widget.activeSubMenu.contains("ခေါက်ရေနှင့် ဝင်ငွေဇယား")) {
      return Column(
        children: [
          _buildInputField(_dateCtrl, "ရက်စွဲ"),
          _buildInputField(_rateCtrl, "ကားခနှုန်း (Auto)"),
          Row(
            children: [
              Expanded(child: _buildInputField(_mornCtrl, "မနက်ခေါက်", isTrip: true)),
              const SizedBox(width: 4),
              Expanded(child: _buildInputField(_noonCtrl, "နေ့လည်ခေါက်", isTrip: true)),
              const SizedBox(width: 4),
              Expanded(child: _buildInputField(_nightCtrl, "ညခေါက်", isTrip: true)),
            ],
          ),
          _buildActionSaveButton(),
        ],
      );
    } else if (widget.activeSubMenu.contains("ကြိုတင်ယူငွေစာရင်း")) {
      return Column(
        children: [
          _buildInputField(_shareAdvanceCtrl, "ကြိုတင်ငွေ (ခွဲဝေ)"),
          _buildInputField(_privateAdvanceCtrl, "ကြိုတင်ငွေ (သီးသန့်)"),
          _buildActionSaveButton(),
        ],
      );
    } else if (widget.activeSubMenu.contains("Driver ၂ ဦး")) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: _buildInputField(_d1NameCtrl, "Driver၁ အမည်")),
              const SizedBox(width: 4),
