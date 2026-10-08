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
  // ခလုတ်နှစ်ခါနှိပ်မိခြင်းမှ ကာကွယ်ရန် စောင့်ကြည့်သည့် အချက်ပြစနစ်
  bool _isSavingProcess = false;

  final TextEditingController _dateCtrl = TextEditingController(text: "08/10/2026");
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

  final List<Map<String, String>> _centralDatabase = [
    {
      "date": "08/10/2026", "morn": "04", "noon": "04", "night": "02", "rate": "50000",
      "shareAdvance": "200000", "privateAdvance": "100000",
      "d1Name": "မောင်မောင်", "d1Trips": "5", "d1Advance": "20000",
      "d2Name": "အောင်အောင်", "d2Trips": "5", "d2Advance": "15000",
      "fuel": "150000", "food": "20000", "repair": "0"
    }
  ];

  @override
  void dispose() {
    _dateCtrl.dispose(); _rateCtrl.dispose(); _mornCtrl.dispose(); _noonCtrl.dispose(); _nightCtrl.dispose();
    _shareAdvanceCtrl.dispose(); _privateAdvanceCtrl.dispose();
    _d1NameCtrl.dispose(); _d1TripsCtrl.dispose(); _d1AdvanceCtrl.dispose();
    _d2NameCtrl.dispose(); _d2TripsCtrl.dispose(); _d2AdvanceCtrl.dispose();
    _fuelCtrl.dispose(); _foodCtrl.dispose(); _repairCtrl.dispose();
    super.dispose();
  }

  // 💾 ကာကွယ်ရေးစနစ်ပါဝင်သော စာရင်းသိမ်းဆည်းမှု ပရိုဂရမ် Logic
  void _safeSaveDataTrigger() async {
    if (_isSavingProcess) return; // နှစ်ခါထပ်နှိပ်ပါက ရှေ့ဆက်မသွားဘဲ ဒီတင်ရပ်ပစ်မည်

    setState(() {
      _isSavingProcess = true; // စာရင်းသိမ်းသည့်အလုပ် စတင်ပြီဟု သတ်မှတ်ခြင်း
    });

    // ဒေတာများကို ဗဟိုချက်ဇယားထဲသို့ စနစ်တကျ လှမ်းထည့်ခြင်း
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
      // ဖြည့်ပြီးပါက ခေါက်ရေကွက်များကို သုညပြန်လုပ်ခြင်း
      _mornCtrl.text = "00"; _noonCtrl.text = "00"; _nightCtrl.text = "00";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('လုပ်ငန်းခွင်ဒေတာအား မှတ်တမ်းထဲသို့ တစ်ကြိမ်တည်း ကွက်တိသိမ်းဆည်းပြီးပါပြီ။'))
    );

    // ခလုတ်ပြန်နှိပ်လို့ရအောင် အချိန်ခေတ္တဆိုင်းပြီးမှ ပြန်ဖွင့်ပေးခြင်း (Debounce Delay)
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isSavingProcess = false; // အလုပ်ပြီးဆုံးသွားသဖြင့် ခလုတ်ပြန်နှိပ်ခွင့်ပြုခြင်း
      });
    }
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

  // ☀️ နေ့ဘက်နေပူထဲတွင် ကော်လံအမည်များ ထင်းခနဲမြင်ရစေမည့် High-Contrast Sheet စတိုင် ဇယားကွက်စနစ်
  Widget _buildPlainSheetTable(List<String> headers, List<List<String>> dataRows) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.white24, width: 1.2)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // ကော်လံများဘေးတိုက် ဆွဲကြည့်နိုင်ရန်
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TableHeader: ဇယားကော်လံအမည်များ ဧရိယာ (စာလုံးဖြူထူကြီးများနှင့် တောက်ပသောနောက်ခံ)
            Container(
              color: const Color(0xFF1E3A8A), // တောက်ပသော ကောင်းကင်ပြာရင့်ရောင်နောက်ခံ
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Row(
                children: headers.map((header) => Container(
                  width: 75,
                  alignment: Alignment.center,
                  child: Text(
                    header, 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11.5),
                  ),
                )).toList(),
              ),
            ),
            // TableBody: နေ့စဉ်မှတ်တမ်း ဒေတာအကြောင်းရေများ ပြသပေးမည့်နေရာ
            ...dataRows.map((rowItems) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: const BoxDecoration(
                color: Colors.black12,
                border: Border(bottom: BorderSide(color: Colors.white12)),
              ),
              child: Row(
                children: rowItems.map((cellValue) => Container(
                  width: 75,
                  alignment: Alignment.center,
                  child: Text(
                    cellValue, 
                    style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white70, fontWeight: FontWeight.w900, fontSize: 11.5),
                  ),
                )).toList(),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = !widget.isLightMode ? const Color(0xFF1E293D) : Colors.white;

    // ဗဟိုချက်ဒေတာများမှ ကော်လံအလိုက် ဒေတာများကို ပတ်ပြီး ဇယားခွက်သုံးရန် ထုတ်ယူခြင်း
    List<List<String>> tripGridRows = [];
    List<List<String>> advanceGridRows = [];
    List<List<String>> driverGridRows = [];
    List<List<String>> pnlGridRows = [];

    for (var row in _centralDatabase) {
      int morn = int.tryParse(row["morn"] ?? "0") ?? 0;
      int noon = int.tryParse(row["noon"] ?? "0") ?? 0;
      int night = int.tryParse(row["night"] ?? "0") ?? 0;
      int rate = int.tryParse(row["rate"] ?? "0") ?? 0;
      int totalRev = (morn + noon + night) * rate;

      tripGridRows.add([row["date"]!, row["morn"]!, row["noon"]!, row["night"]!, "${rate ~/ 1000}k", "${totalRev ~/ 1000}k"]);
      advanceGridRows.add([row["date"]!, "${int.parse(row['shareAdvance']!) ~/ 1000}k", "${int.parse(row['privateAdvance']!) ~/ 1000}k"]);
      driverGridRows.add([row["date"]!, row["d1Name"]!, row["d1Trips"]!, row["d2Name"]!, row["d2Trips"]!]);
      pnlGridRows.add([row["date"]!, "${totalRev ~/ 1000}k", "${int.parse(row['fuel']!) ~/ 1000}k", "${int.parse(row['food']!) ~/ 1000}k", "${int.parse(row['repair']!) ~/ 1000}k", "+${(totalRev - int.parse(row['fuel']!)) ~/ 1000}k"]);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ရက်စွဲနှင့် ခေါက်ရေ ဝင်ငွေဇယား မော်ဂျူး
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
                      // နေ့စဉ်မှတ်တမ်းသိမ်းဆည်းမည့် ခလုတ် (နှစ်ခါနှိပ်ခြင်းမှ ကာကွယ်ထားသည်)
                      ElevatedButton.icon(
