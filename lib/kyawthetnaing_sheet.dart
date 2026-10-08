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
  bool _isSavingProcess = false;
  String _selectedDriverOption = "option1";
  String _driverOptionValue = "10"; 

  // Input Controllers
  final TextEditingController _dateCtrl = TextEditingController(text: "08/10/2026");
  final TextEditingController _rateCtrl = TextEditingController(text: "50000");
  final TextEditingController _mornCtrl = TextEditingController(text: "04");
  final TextEditingController _noonCtrl = TextEditingController(text: "04");
  final TextEditingController _nightCtrl = TextEditingController(text: "02");

  final TextEditingController _shareAdvanceCtrl = TextEditingController(text: "200000");
  final TextEditingController _privateAdvanceCtrl = TextEditingController(text: "100000");

  final TextEditingController _d1NameCtrl = TextEditingController(text: "မောင်မောင်");
  final TextEditingController _d1TripsCtrl = TextEditingController(text: "6");
  final TextEditingController _d1AdvanceCtrl = TextEditingController(text: "20000"); // ဒရိုင်ဘာ ကြိုတင်ငွေ
  final TextEditingController _d2NameCtrl = TextEditingController(text: "အောင်အောင်");
  final TextEditingController _d2TripsCtrl = TextEditingController(text: "4");
  final TextEditingController _d2AdvanceCtrl = TextEditingController(text: "15000"); // ဒရိုင်ဘာ ကြိုတင်ငွေ

  final TextEditingController _fuelCtrl = TextEditingController(text: "150000");
  final TextEditingController _foodCtrl = TextEditingController(text: "20000");
  final TextEditingController _repairCtrl = TextEditingController(text: "0");

  @override
  void dispose() {
    _dateCtrl.dispose(); _rateCtrl.dispose(); _mornCtrl.dispose(); _noonCtrl.dispose(); _nightCtrl.dispose();
    _shareAdvanceCtrl.dispose(); _privateAdvanceCtrl.dispose(); _fuelCtrl.dispose(); _foodCtrl.dispose(); _repairCtrl.dispose();
    _d1NameCtrl.dispose(); _d1TripsCtrl.dispose(); _d1AdvanceCtrl.dispose();
    _d2NameCtrl.dispose(); _d2TripsCtrl.dispose(); _d2AdvanceCtrl.dispose();
    super.dispose();
  }

  // 🧮 စာရင်းတစ်ခုနှင့်တစ်ခု ချိတ်ဆက်တွက်ချက်ပေးမည့် Dynamic Formula Engine
  Map<String, int> _calculateMetrics() {
    int morn = int.tryParse(_mornCtrl.text) ?? 0;
    int noon = int.tryParse(_noonCtrl.text) ?? 0;
    int night = int.tryParse(_nightCtrl.text) ?? 0;
    int rate = int.tryParse(_rateCtrl.text) ?? 0;
    int fuel = int.tryParse(_fuelCtrl.text) ?? 0;
    int food = int.tryParse(_foodCtrl.text) ?? 0;
    int repair = int.tryParse(_repairCtrl.text) ?? 0;
    
    int totalTrips = morn + noon + night;
    int totalRevenue = totalTrips * rate;

    // Driver တွက်ချက်မှု Option ၃ မျိုး Logic အစစ်
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

  void _safeSaveDataTrigger() async {
    if (_isSavingProcess) return;
    setState(() => _isSavingProcess = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('လုပ်ငန်းခွင်ဒေတာအား တစ်ကြိမ်တည်း ကွက်တိသိမ်းဆည်းပြီးပါပြီ။'))
    );
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _isSavingProcess = false);
  }

  Widget _buildInputField(TextEditingController ctrl, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: widget.isLightMode ? Colors.white : const Color(0xFF121824),
        border: Border.all(color: Colors.amber, width: 1.5),
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextField(
        controller: ctrl,
        style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white, fontSize: 13.5, fontWeight: FontWeight.w900),
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold), border: InputBorder.none),
      ),
    );
  }

  Widget _buildPlainSheetTable(List<String> headers, List<String> data) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.white24, width: 1.2)),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF1E3A8A), // တောက်ပသော အပြာရောင် ခေါင်းစဉ်နောက်ခံ
            padding: const EdgeInsets.all(8),
            child: Row(children: headers.map((h) => Expanded(child: Text(h, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11), textAlign: TextAlign.center))).toList()),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black12,
            child: Row(children: data.map((d) => Expanded(child: Text(d, style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white70, fontWeight: FontWeight.w900, fontSize: 11), textAlign: TextAlign.center))).toList()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = !widget.isLightMode ? const Color(0xFF1E293D) : Colors.white;
    var metrics = _calculateMetrics(); // Auto တွက်ချက်မှုရလဒ်များကို ဗဟိုမှယူခြင်း

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            // 📄 နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား ကဏ္ဍ
            if (widget.activeSubMenu.contains("ခေါက်ရေနှင့် ဝင်ငွေဇယား"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInputField(_dateCtrl, "ရက်စွဲ"),
                      _buildInputField(_rateCtrl, "ကားခနှုန်း (Auto)"),
                      Row(
                        children: [
                          Expanded(child: _buildInputField(_mornCtrl, "မနက်")),
                          const SizedBox(width: 4),
                          Expanded(child: _buildInputField(_noonCtrl, "နေ့လည်")),
                          const SizedBox(width: 4),
                          Expanded(child: _buildInputField(_nightCtrl, "ည")),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: _isSavingProcess ? Colors.grey : Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(36)),
                        onPressed: _isSavingProcess ? null : _safeSaveDataTrigger,
                        child: Text(_isSavingProcess ? "သိမ်းနေပါသည်..." : "နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      ),
                      _buildPlainSheetTable(["ရက်စွဲ", "မနက်", "နေ့လည်", "ည", "ကားခ", "ရငွေ"], [_dateCtrl.text, _mornCtrl.text, _noonCtrl.text, _nightCtrl.text, "${_rateCtrl.text}", "${metrics['totalRevenue']}"]),
                    ],
                  ),
                ),
              ),

            // 💰 ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း ကဏ္ဍ
            if (widget.activeSubMenu.contains("ကြိုတင်ယူငွေစာရင်း"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInputField(_shareAdvanceCtrl, "ကြိုတင်ငွေ (ခွဲဝေယူ)"),
                      _buildInputField(_privateAdvanceCtrl, "ကြိုတင်ငွေ (သီးသန့်ယူ)"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(36)),
                        onPressed: _safeSaveDataTrigger,
                        child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      ),
                      _buildPlainSheetTable(["ရက်စွဲ", "ခွဲဝေယူ", "သီးသန့်ယူ"], [_dateCtrl.text, _shareAdvanceCtrl.text, _privateAdvanceCtrl.text]),
                    ],
                  ),
                ),
              ),

            // 👥 Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း ကဏ္ဍ
            if (widget.activeSubMenu.contains("Driver ၂ ဦး"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _buildInputField(_d1NameCtrl, "Driver၁ အမည်")),
                          const SizedBox(width: 4),
                          Expanded(child: _buildInputField(_d1TripsCtrl, "ခေါက်ရေ")),
                          const SizedBox(width: 4),
