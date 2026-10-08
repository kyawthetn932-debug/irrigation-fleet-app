import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class kyawthetnaingsheet extends StatefulWidget {
  final bool? islargescreen;
  const kyawthetnaingsheet({super.key, this.islargescreen});
  @override
  State<kyawthetnaingsheet> createState() => _sheetstate();
}

class _sheetstate extends State<kyawthetnaingsheet> {
  String _v = "(၅.၁) ဝင်ငွေ"; int _opt = 1; DateTime _dt = DateTime.now();
  final _m = TextEditingController(text: "0"); final _a = TextEditingController(text: "0"); final _e = TextEditingController(text: "0");
  final _r = TextEditingController(text: "50000"); final _f = TextEditingController(text: "150000"); final _rp = TextEditingController(text: "0");
  final _w = TextEditingController(text: "5000"); final _p = TextEditingController(text: "10");

  List<Map<String, dynamic>> _logs = [{"date": "08/10/2026", "trips": "12", "fare": "600000", "profit": "320000"}];
  final List<Map<String, dynamic>> _adv = [{"date": "08/10/2026", "amount": "200000", "note": "ဆည်မြောင်းစိုက်ငွေ"}];
  final List<Map<String, dynamic>> _drv = [{"date": "08/10/2026", "d1": "ဦးအောင် (၆ ခေါက်)", "d2": "ဦးဘ (၆ ခေါက်)", "wage": "၆၀၀၀၀"}];

  @override
  void initState() { super.initState(); _load(); }
  void _load() async {
    final p = await SharedPreferences.getInstance(); final String? c = p.getString('k_logs');
    if (c != null) setState(() { _logs = List<Map<String, dynamic>>.from(json.decode(c)); });
  }
  void _save() async { final p = await SharedPreferences.getInstance(); await p.setString('k_logs', json.encode(_logs)); }

  Widget _in(String l, TextEditingController ctrl) {
    return Padding(padding: const EdgeInsets.only(bottom: 6.0), child: TextField(controller: ctrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), decoration: InputDecoration(labelText: l, labelStyle: const TextStyle(color: Colors.white70), border: const OutlineInputBorder(), contentPadding: const EdgeInsets.all(6)), onChanged: (v) => setState(() {})));
  }

  Widget _cell(String t, {Color? c, bool isH = false}) {
    return Container(padding: const EdgeInsets.all(6.0), alignment: Alignment.center, child: Text(t, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, fontWeight: isH ? FontWeight.bold : FontWeight.w600, color: c ?? (isH ? Colors.amber : Colors.white))));
  }

  @override
  Widget build(BuildContext context) {
    int trips = (int.tryParse(_m.text) ?? 0) + (int.tryParse(_a.text) ?? 0) + (int.tryParse(_e.text) ?? 0);
    int fare = trips * (int.tryParse(_r.text) ?? 0); int fuel = int.tryParse(_f.text) ?? 0; int repair = int.tryParse(_rp.text) ?? 0;
    int wage = 0;
    if (_opt == 1) wage = ((fare - fuel) * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_opt == 2) wage = (fare * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_opt == 3) wage = trips * (int.tryParse(_w.text) ?? 5000);
    int profit = fare - fuel - repair - (wage < 0 ? 0 : wage);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (_v == "(၅.၁) ဝင်ငွေ") ...[
              Card(color: const Color(0xFF1E1E2C), child: ListTile(leading: const Icon(Icons.calendar_today, color: Colors.amber), title: Text("ရက်စွဲ: ${_dt.day}/${_dt.month}/${_dt.year}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), onTap: () async { DateTime? p = await showDatePicker(context: context, initialDate: _dt, firstDate: DateTime(2020), lastDate: DateTime(2030)); if (p != null) setState(() { _dt = p; }); })),
              const SizedBox(height: 6),
              Row(children: [Expanded(child: _in("မနက်", _m)), const SizedBox(width: 4), Expanded(child: _in("နေ့လည်", _a)), const SizedBox(width: 4), Expanded(child: _in("ည", _e))]),
              _in("တစ်စီးချင်းကားခ", _r), _in("ဆီပေပါ ဈေးနှုန်း", _f), _in("ပြုပြင်စရိတ်", _rp),
              DropdownButton<int>(value: _opt, isExpanded: true, dropdownColor: const Color(0xFF1E1E2C), style: const TextStyle(color: Colors.white), items: const [DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ %")), DropdownMenuItem(value: 2, child: Text("Option 2: สိတ်ကြိုက် %")), DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေး"))], onChanged: (v) => setState(() { _opt = v!; })),
              const SizedBox(height: 4),
              if (_opt == 1 || _opt == 2) _in("မောင်းကြေး ရာခိုင်နှုန်း (%)", _p),
              if (_opt == 3) _in("တစ်ခေါက်ချင်း အပြတ်ကြေး", _w),
              ElevatedButton(onPressed: () { setState(() { _logs.insert(0, {"date": "${_dt.day}/${_dt.month}/${_dt.year}", "trips": "$trips", "fare": "$fare", "profit": "$profit"}); _save(); }); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 36)), child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
            ],
            if (_v == "(၅.၂) ကြိုတင်ယူ") ...[
              Table(border: TableBorder.all(color: Colors.white30), children: [TableRow(decoration: const BoxDecoration(color: Color(0xFF1E1E2C)), children: [_cell("နေ့စွဲ", isH: true), _cell("ကြိုတင်ငွေ", isH: true), _cell("မှတ်ချက်", isH: true)]), ..._adv.map((l) => TableRow(children: [_cell(l["date"].toString()), _cell(l["amount"].toString(), c: Colors.greenAccent), _cell(l["note"].toString())]))])
            ],
            if (_v == "(၅.၃) Driver") ...[
              Table(border: TableBorder.all(color: Colors.white30), children: [TableRow(decoration: const BoxDecoration(color: Color(0xFF1E1E2C)), children: [_cell("နေ့စွဲ", isH: true), _cell("ဒရိုင်ဘာ ၁", isH: true), _cell("ဒရိုင်ဘာ 2", isH: true), _cell("မောင်းကြေး", isH: true)]), ..._drv.map((l) => TableRow(children: [_cell(l["date"].toString()), _cell(l["d1"].toString()), _cell(l["d2"].toString()), _cell(l["wage"].toString(), c: Colors.greenAccent)]))])
            ],
            if (_v == "(၅.၄) အချုပ်") ...[
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(8)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("ယနေ့ အသားတင် အခြေအနေ:"), Text("$profit ကျပ်", style: TextStyle(color: profit >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold))]))
            ],
            if (_v == "(၅.၅) စာရင်းချုပ်") ...[
              const Text("📊 နေ့စဉ် စာရင်းချုပ် (Sheet စတိုင်လ် အပြည့်အစုံ)", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Table(border: TableBorder.all(color: Colors.white30), children: [
                TableRow(decoration: const BoxDecoration(color: Color(0xFF1E1E2C)), children: [_cell("နေ့စွဲ", isH: true), _cell("ခေါက်ရေ", isH: true), _cell("ကားခ", isH: true), _cell("အမြတ်/အရှုံး", isH: true), _cell("ပြင်ဆင်", isH: true)]),
                ..._logs.asMap().entries.map((entry) => TableRow(decoration: const BoxDecoration(color: Color(0xFF1A1A24)), children: [_cell(entry.value["date"].toString()), _cell(entry.value["trips"].toString()), _cell(entry.value["fare"].toString(), c: Colors.greenAccent), _cell(entry.value["profit"].toString(), c: int.parse(entry.value["profit"].toString()) >= 0 ? Colors.greenAccent : Colors.redAccent), IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent, size: 16), onPressed: () { setState(() { _logs.removeAt(entry.key); _save(); }); })]))
              ])
            ]
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E2C), selectedItemColor: Colors.amber, unselectedItemColor: Colors.white60, type: BottomNavigationBarType.fixed, selectedFontSize: 10, unselectedFontSize: 10,
        currentIndex: _v == "(၅.၂) ကြိုတင်ယူ" ? 1 : _v == "(၅.၃) Driver" ? 2 : _v == "(၅.၄) အချုပ်" ? 3 : _v == "(၅.၅) စာရင်းချုပ်" ? 4 : 0,
        onTap: (i) { setState(() { if (i == 0) _v = "(၅.၁) ဝင်ငွေ"; if (i == 1) _v = "(၅.၂) ကြိုတင်ယူ"; if (i == 2) _v = "(၅.၃) Driver"; if (i == 3) _v = "(၅.၄) အချုပ်"; if (i == 4) _v = "(၅.၅) စာရင်းချုပ်"; }); },
        items: const [BottomNavigationBarItem(icon: Icon(Icons.table_chart, size: 16), label: "ဝင်ငွေ"), BottomNavigationBarItem(icon: Icon(Icons.monetization_on, size: 16), label: "ကြိုတင်ယူ"), BottomNavigationBarItem(icon: Icon(Icons.people, size: 16), label: "Driver"), BottomNavigationBarItem(icon: Icon(Icons.calculate, size: 16), label: "အချုပ်"), BottomNavigationBarItem(icon: Icon(Icons.analytics, size: 16), label: "၅.၅ ချုပ်")],
      ),
    );
  }
}
