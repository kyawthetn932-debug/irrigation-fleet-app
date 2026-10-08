import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class KyawThetNaingSheet extends StatefulWidget {
  final bool? isLargeScreen;
  const KyawThetNaingSheet({super.key, this.isLargeScreen});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  String _subView = "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား";
  int _option = 1;
  DateTime _date = DateTime.now();

  final _m = TextEditingController(text: "0");
  final _a = TextEditingController(text: "0");
  final _e = TextEditingController(text: "0");
  final _r = TextEditingController(text: "50000");
  final _f = TextEditingController(text: "150000");
  final _rp = TextEditingController(text: "0");
  final _w = TextEditingController(text: "5000");
  final _p = TextEditingController(text: "10");

  // နေ့စဉ်မှတ်တမ်း စာရင်း List
  List<Map<String, dynamic>> _logs = [
    {"date": "08/10/2026", "trips": "12", "fare": "600000", "profit": "320000"},
  ];

  final List<Map<String, dynamic>> _advanceLogs = [
    {"date": "08/10/2026", "amount": "200000", "note": "ဆည်မြောင်းစိုက်ငွေ"},
  ];

  final List<Map<String, dynamic>> _driverLogs = [
    {"date": "08/10/2026", "d1": "ဦးအောင် (၆ ခေါက်)", "d2": "ဦးဘ (၆ ခေါက်)", "wage": "၆၀၀၀၀"},
  ];

  @override
  void initState() {
    super.initState();
    _loadData(); // 💾 အက်ပ်ဖွင့်လျှင် ဖုန်းထဲက ဒေတာဟောင်းများကို အလိုအလျောက် ပြန်ဖတ်မည့်စနစ်
  }

  // ဖုန်းထဲမှ ဒေတာများ ပြန်လည်ဆွဲယူဖတ်ရှုခြင်း
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedLogs = prefs.getString('kyawthetnaing_logs');
    if (cachedLogs != null) {
      setState(() {
        _logs = List<Map<String, dynamic>>.from(json.decode(cachedLogs));
      });
    }
  }

  // ဖုန်းပိတ်လည်း မပျက်အောင် သိမ်းဆည်းခြင်း
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('kyawthetnaing_logs', json.encode(_logs));
  }

  Widget _in(String l, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: l,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 11),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        onChanged: (v) => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int morning = int.tryParse(_m.text) ?? 0;
    int afternoon = int.tryParse(_a.text) ?? 0;
    int evening = int.tryParse(_e.text) ?? 0;
    int trips = morning + afternoon + evening;
    int rate = int.tryParse(_r.text) ?? 0;
    int fare = trips * rate;
    int fuel = int.tryParse(_f.text) ?? 0;
    int repair = int.tryParse(_rp.text) ?? 0;

    int wage = 0;
    if (_option == 1) wage = ((fare - fuel) * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_option == 2) wage = (fare * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_option == 3) wage = trips * (int.tryParse(_w.text) ?? 5000);
    int profit = fare - fuel - repair - (wage < 0 ? 0 : wage);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(_subView, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)),
        backgroundColor: const Color(0xFF1E1E2C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_subView == "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား") ...[
                Card(
                  color: const Color(0xFF1E1E2C),
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.amber),
                    title: Text("ရက်စွဲ: ${_date.day}/${_date.month}/${_date.year}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () async {
                      DateTime? p = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime(2030));
                      if (p != null) setState(() { _date = p; });
                    }
                  )
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _in("မနက်", _m)),
                    const SizedBox(width: 6),
                    Expanded(child: _in("နေ့လည်", _a)),
                    const SizedBox(width: 6),
                    Expanded(child: _in("ည", _e)),
                  ],
                ),
                _in("တစ်စီးချင်းကားခ", _r),
                _in("ဆီပေပါ ဈေးနှုန်း", _f),
                _in("ပြုပြင်စရိတ်", _rp),
                const Text("🧮 မောင်းကြေးစနစ် ရွေးချယ်ရန်", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white30), borderRadius: BorderRadius.circular(6)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: _option,
                      isExpanded: true,
                      dropdownColor: const Color(0xFF1E1E2C),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ %")),
                        DropdownMenuItem(value: 2, child: Text("Option 2: စိတ်ကြိုက် %")),
                        DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေး")),
                      ],
                      onChanged: (v) => setState(() { _option = v!; }),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (_option == 1 || _option == 2) _in("မောင်းကြေး ရာခိုင်နှုန်း (%)", _p),
                if (_option == 3) _in("တစ်ခေါက်ချင်း အပြတ်ကြေး (ကျပ်)", _w),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _logs.insert(0, {"date": "${_date.day}/${_date.month}/${_date.year}", "trips": "$trips", "fare": "$fare", "profit": "$profit"});
                      _saveData(); // 💾 သိမ်းဆည်းရန်ခလုတ်နှိပ်လျှင် ဖုန်းထဲသို့ပါ တစ်ခါတည်း အသေသိမ်းဆည်းသွားမည်
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 40)),
                  child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                const Text("📊 နေ့စဉ်ခေါက်ရေ စာရင်းချုပ် (Sheet စတိုင်လ်)", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Table(
                  border: TableBorder.all(color: Colors.white24, width: 1),
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Color(0xFF1E1E2C)),
                      children: [
                        Padding(padding: EdgeInsets.all(6), child: Text("နေ့စွဲ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber))),
                        Padding(padding: EdgeInsets.all(6), child: Text("ခေါက်ရေ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber))),
                        Padding(padding: EdgeInsets.all(6), child: Text("ကားခ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.greenAccent))),
                        Padding(padding: EdgeInsets.all(6), child: Text("အမြတ်/အရှုံး", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber))),
                      ],
                    ),
                    ..._logs.map((log) => TableRow(
                      children: [
                        Padding(padding: const EdgeInsets.all(6), child: Text(log["date"].toString(), style: const TextStyle(fontSize: 11))),
                        Padding(padding: const EdgeInsets.all(6), child: Text(log["trips"].toString(), style: const TextStyle(fontSize: 11))),
                        Padding(padding: const EdgeInsets.all(6), child: Text(log["fare"].toString(), style: const TextStyle(fontSize: 11))),
                        Padding(padding: const EdgeInsets.all(6), child: Text(log["profit"].toString(), style: TextStyle(fontSize: 11, color: int.tryParse(log["profit"].toString()) != null && int.parse(log["profit"].toString()) >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold))),
                      ],
                    )),
                  ],
                )
              ],
              if (_subView == "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း") ...[
                const Text("💰 ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း (Sheet စတိုင်လ်)", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Table(
                  border: TableBorder.all(color: Colors.white24, width: 1),
                  children: [
                    const TableRow(
