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
  // 🔑 Global Flat-Rate System (တစ်ကြိမ်တည်း ဖြည့်ထားရုံဖြင့် နေ့စဉ် Auto သွားမည့်စနစ်)
  String _globalDefaultRate = "50000";

  String _selectedDriverOption = "option1";
  String _driverOptionValue = "10"; 

  // Input Controllers 
  final TextEditingController _dateCtrl = TextEditingController(text: "06/10/2026");
  final TextEditingController _mornCtrl = TextEditingController(text: "00");
  final TextEditingController _noonCtrl = TextEditingController(text: "00");
  final TextEditingController _nightCtrl = TextEditingController(text: "00");
  late TextEditingController _rateCtrl; 

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

  // 📊 Central Shared Database Repository (ကဏ္ဍပေါင်းစုံ ဒေတာ Auto-Sync ချိတ်ဆက်မှုဗဟိုချက်)
  final List<Map<String, String>> _centralDatabase = [
    {
      "date": "05/10/2026", "morn": "04", "noon": "04", "night": "04", "rate": "50000",
      "shareAdvance": "200000", "privateAdvance": "100000",
      "d1Name": "မောင်မောင်", "d1Trips": "6", "d1Advance": "20000",
      "d2Name": "အောင်အောင်", "d2Trips": "6", "d2Advance": "15000",
      "fuel": "150000", "food": "20000", "repair": "0"
    }
  ];

  @override
  void initState() {
    super.initState();
    _rateCtrl = TextEditingController(text: _globalDefaultRate);
  }

  @override
  void dispose() {
    _dateCtrl.dispose(); _mornCtrl.dispose(); _noonCtrl.dispose(); _nightCtrl.dispose(); _rateCtrl.dispose();
    _shareAdvanceCtrl.dispose(); _privateAdvanceCtrl.dispose();
    _d1NameCtrl.dispose(); _d1TripsCtrl.dispose(); _d1AdvanceCtrl.dispose();
    _d2NameCtrl.dispose(); _d2TripsCtrl.dispose(); _d2AdvanceCtrl.dispose();
    _fuelCtrl.dispose(); _foodCtrl.dispose(); _repairCtrl.dispose();
    super.dispose();
  }

  // 🧮 ဝင်ငွေ၊ စရိတ်များနှင့် P&L Auto တွက်ချက်ပေးသည့် Formula Engine
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

    int netProfit = totalRevenue - (fuel + food + repair + driverFeeTotal);

    return {
      "totalTrips": totalTrips,
      "totalRevenue": totalRevenue,
      "driverFeeTotal": driverFeeTotal,
      "netProfit": netProfit
    };
  }

  void _saveCurrentForm() {
    setState(() {
      _centralDatabase.add({
        "date": _dateCtrl.text,
        "morn": _mornCtrl.text.padLeft(2, '0'),
        "noon": _noonCtrl.text.padLeft(2, '0'),
        "night": _nightCtrl.text.padLeft(2, '0'),
        "rate": _rateCtrl.text,
        "shareAdvance": _shareAdvanceCtrl.text,
        "privateAdvance": _privateAdvanceCtrl.text,
        "d1Name": _d1NameCtrl.text, "d1Trips": _d1TripsCtrl.text, "d1Advance": _d1AdvanceCtrl.text,
        "d2Name": _d2NameCtrl.text, "d2Trips": _d2TripsCtrl.text, "d2Advance": _d2AdvanceCtrl.text,
        "fuel": _fuelCtrl.text, "food": _foodCtrl.text, "repair": _repairCtrl.text
      });
      _mornCtrl.text = "00"; _noonCtrl.text = "00"; _nightCtrl.text = "00";
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('လုပ်ငန်းခွင်ဒေတာအား သိမ်းဆည်းပြီးပါပြီ။')));
  }

  void _editCell(int index, String key, String title, bool isTripField) {
    TextEditingController cellEditCtrl = TextEditingController(text: _centralDatabase[index][key]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F293D),
        title: Text("$title ကို ပြင်ရန်", style: const TextStyle(color: Colors.amber, fontSize: 13)),
        content: TextField(
          controller: cellEditCtrl,
          keyboardType: TextInputType.number,
          maxLength: isTripField ? 2 : null,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber))),
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
            child: const Text("သိမ်းမည်", style: TextStyle(color: Colors.teal)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = widget.isLargeScreen ? 13.0 : 11.5;
    Color contentTextColor = widget.isLightMode ? const Color(0xFF121824) : Colors.white70;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: SingleChildScrollView(child: _buildActiveFormSection()),
        ),
        const Divider(color: Colors.white24, height: 10),
        Expanded(
          flex: 5,
          child: _buildActiveGridSection(fontSize, contentTextColor),
        ),
      ],
    );
  }

  Widget _buildActiveFormSection() {
    if (widget.activeSubMenu.contains("၅.၁")) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInputField(_dateCtrl, "ရက်စွဲ")),
              const SizedBox(width: 8),
              Expanded(child: _buildInputField(_rateCtrl, "ကားခနှုန်း (Auto ဖြည့်ပြီးသား)", isPrice: true)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildInputField(_mornCtrl, "မနက်ခေါက်", isTrip: true)),
              const SizedBox(width: 6),
              Expanded(child: _buildInputField(_noonCtrl, "နေ့လည်ခေါက်", isTrip: true)),
              const SizedBox(width: 6),
              Expanded(child: _buildInputField(_nightCtrl, "ညခေါက်", isTrip: true)),
            ],
          ),
          const SizedBox(height: 8),
          _buildActionSaveButton(),
        ],
      );
    } else if (widget.activeSubMenu.contains("၅.၂")) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInputField(_shareAdvanceCtrl, "ဆည်မြောင်း ကြိုတင်ငွေ (ခွဲဝေယူ)")),
              const SizedBox(width: 8),
              Expanded(child: _buildInputField(_privateAdvanceCtrl, "ကြိုတင်ငွေ (သီးသန့်ယူ)")),
            ],
          ),
          const SizedBox(height: 8),
          _buildActionSaveButton(),
        ],
      );
    } else if (widget.activeSubMenu.contains("၅.၃")) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInputField(_d1NameCtrl, "Driver (၁) အမည်")),
              const SizedBox(width: 6),
              Expanded(child: _buildInputField(_d1TripsCtrl, "ခေါက်ရေ")),
              const SizedBox(width: 6),
              Expanded(child: _buildInputField(_d1AdvanceCtrl, "ကြိုတင်ယူငွေ")),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildInputField(_d2NameCtrl, "Driver (၂) အမည်")),
              const SizedBox(width: 6),
              Expanded(child: _buildInputField(_d2TripsCtrl, "ခေါက်ရေ")),
              const SizedBox(width: 6),
              Expanded(child: _buildInputField(_d2AdvanceCtrl, "ကြိုတင်ယူငွေ")),
            ],
          ),
          const SizedBox(height: 8),
          _buildActionSaveButton(),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInputField(_fuelCtrl, "ဆီဖိုး (-)")),
              const SizedBox(width: 6),
