import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class kyawthetnaingsheet extends StatefulWidget {
  final bool? islargescreen;
  const kyawthetnaingsheet({super.key, this.islargescreen});
  @override
  State<kyawthetnaingsheet> createState() => _kyawthetnaingsheetstate();
}

class _kyawthetnaingsheetstate extends State<kyawthetnaingsheet> {
  String _v = "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား";
  int _opt = 1;
  DateTime _dt = DateTime.now();

  final _m = TextEditingController(text: "0");
  final _a = TextEditingController(text: "0");
  final _e = TextEditingController(text: "0");
  final _r = TextEditingController(text: "50000");
  final _f = TextEditingController(text: "150000");
  final _rp = TextEditingController(text: "0");
  final _w = TextEditingController(text: "5000");
  final _p = TextEditingController(text: "10");

  List<Map<String, dynamic>> _logs = [{"date": "08/10/2026", "trips": "12", "fare": "600000", "profit": "320000"}];
  final List<Map<String, dynamic>> _adv = [{"date": "08/10/2026", "amount": "200000", "note": "ဆည်မြောင်းစိုက်ငွေ"}];
  final List<Map<String, dynamic>> _drv = [{"date": "08/10/2026", "d1": "ဦးအောင် (၆ ခေါက်)", "d2": "ဦးဘ (၆ ခေါက်)", "wage": "၆၀၀၀၀"}];

  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    final String? c = p.getString('k_logs');
    if (c != null) setState(() { _logs = List<Map<String, dynamic>>.from(json.decode(c)); });
  }
  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('k_logs', json.encode(_logs));
  }

  Widget _in(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), contentPadding: const EdgeInsets.all(6)),
        onChanged: (v) => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int trips = (int.tryParse(_m.text) ?? 0) + (int.tryParse(_a.text) ?? 0) + (int.tryParse(_e.text) ?? 0);
    int fare = trips * (int.tryParse(_r.text) ?? 0);
    int fuel = int.tryParse(_f.text) ?? 0;
    int repair = int.tryParse(_rp.text) ?? 0;
    int wage = 0;
    if (_opt == 1) wage = ((fare - fuel) * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_opt == 2) wage = (fare * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_opt == 3) wage = trips * (int.tryParse(_w.text) ?? 5000);
    int profit = fare - fuel - repair - (wage < 0 ? 0 : wage);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: Text(_v, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13)), backgroundColor: const Color(0xFF1E1E2C)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_v == "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား") ...[
                Card(color: const Color(0xFF1E1E2C), child: ListTile(leading: const Icon(Icons.calendar_today, color: Colors.amber), title: Text("ရက်စွဲ: ${_dt.day}/${_dt.month}/${_dt.year}"), onTap: () async {
                  DateTime? p = await showDatePicker(context: context, initialDate: _dt, firstDate: DateTime(2020), lastDate: DateTime(2030));
                  if (p != null) setState(() { _dt = p; });
                })),
                const SizedBox(height: 6),
                Row(children: [Expanded(child: _in("မနက်", _m)), const SizedBox(width: 6), Expanded(child: _in("နေ့လည်", _a)), const SizedBox(width: 6), Expanded(child: _in("ည", _e))]),
                _in("တစ်စီးချင်းကားခ", _r), _in("ဆီပေပါ ဈေးနှုန်း", _f), _in("ပြုပြင်စရိတ်", _rp),
                DropdownButton<int>(value: _opt, isExpanded: true, dropdownColor: const Color(0xFF1E1E2C), items: const [
                  DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ %")),
                  DropdownMenuItem(value: 2, child: Text("Option 2: စိတ်ကြိုက် %")),
                  DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေး")),
                ], onChanged: (v) => setState(() { _opt = v!; })),
                if (_opt == 1 || _opt == 2) _in("မောင်းကြေး ရာခိုင်နှုန်း (%)", _p),
                if (_opt == 3) _in("တစ်ခေါက်ချင်း အပြတ်ကြေး", _w),
                const SizedBox(height: 6),
                ElevatedButton(onPressed: () { setState(() { _logs.insert(0, {"date": "${_dt.day}/${_dt.month}/${_dt.year}", "trips": "$trips", "fare": "$fare", "profit": "$profit"}); _save(); }); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 36)), child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                const SizedBox(height: 12),
                Table(border: TableBorder.all(color: Colors.white24), children: [
                  const TableRow(decoration: BoxDecoration(color: Color(0xFF1E1E2C)), children: [Padding(padding: EdgeInsets.all(5), child: Text("နေ့စွဲ")), Padding(padding: EdgeInsets.all(5), child: Text("ခေါက်ရေ")), Padding(padding: EdgeInsets.all(5), child: Text("ကားခ")), Padding(padding: EdgeInsets.all(5), child: Text("အမြတ်/အရှုံး"))]),
                  ..._logs.map((l) => TableRow(children: [Padding(padding: const EdgeInsets.all(5), child: Text(l["date"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["trips"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["fare"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["profit"].toString(), style: TextStyle(color: int.parse(l["profit"].toString()) >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold)))]))
                ])
              ],
              if (_v == "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း") ...[
                Table(border: TableBorder.all(color: Colors.white24), children: [
                  const TableRow(decoration: BoxDecoration(color: Color(0xFF1E1E2C)), children: [Padding(padding: EdgeInsets.all(5), child: Text("နေ့စွဲ")), Padding(padding: EdgeInsets.all(5), child: Text("ကြိုတင်ငွေ")), Padding(padding: EdgeInsets.all(5), child: Text("မှတ်ချက်"))]),
                  ..._adv.map((l) => TableRow(children: [Padding(padding: const EdgeInsets.all(5), child: Text(l["date"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["amount"].toString(), style: const TextStyle(color: Colors.greenAccent))), Padding(padding: const EdgeInsets.all(5), child: Text(l["note"].toString()))]))
                ])
              ],
              if (_v == "(၅.၃) Driver ၂ ဦး စရိတ်ရှင်းတမ်း") ...[
                Table(border: TableBorder.all(color: Colors.white24), children: [
                  const TableRow(decoration: BoxDecoration(color: Color(0xFF1E1E2C)), children: [Padding(padding: EdgeInsets.all(5), child: Text("နေ့စွဲ")), Padding(padding: EdgeInsets.all(5), child: Text("ဒရိုင်ဘာ ၁")), Padding(padding: EdgeInsets.all(5), child: Text("ဒရိုင်ဘာ ၂")), Padding(padding: EdgeInsets.all(5), child: Text("မောင်းကြေး"))]),
                  ..._drv.map((l) => TableRow(children: [Padding(padding: const EdgeInsets.all(5), child: Text(l["date"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["d1"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["d2"].toString())), Padding(padding: const EdgeInsets.all(5), child: Text(l["wage"].toString(), style: const TextStyle(color: Colors.greenAccent)))]))
                ])
              ],
              if (_v == "(၅.၄) အသားတင် အမြတ်/အရှုံးချုပ်") ...[
                Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(8)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("ယနေ့ အသားတင် အခြေအနေ:"), Text("$profit ကျပ်", style: TextStyle(color: profit >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold))]))
              ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E2C), selectedItemColor: Colors.amber, unselectedItemColor: Colors.white60,
        currentIndex: _v == "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း" ? 1 : _v == "(၅.၃) Driver ၂ ဦး စရိတ်ရှင်းတမ်း" ? 2 : _v == "(၅.၄) အသားတင် အမြတ်/အရှုံးချုပ်" ? 3 : 0,
        type: BottomNavigationBarType.fixed, selectedFontSize: 10, unselectedFontSize: 10,
        onTap: (i) { setState(() { if (i == 0) _v = "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား"; if (i == 1) _v = "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း"; if (i == 2) _v = "(၅.၃) Driver ၂ ဦး စရိတ်ရှင်းတမ်း"; if (i == 3) _v = "(၅.၄) အသားတင် အမြတ်/အရှုံးချုပ်"; }); },
        items: const [BottomNavigationBarItem(icon: Icon(Icons.table_chart, size: 18), label: "ဝင်ငွေ"), BottomNavigationBarItem(icon: Icon(Icons.monetization_on, size: 18), label: "ကြိုတင်ယူ"), BottomNavigationBarItem(icon: Icon(Icons.people, size: 18), label: "Driver"), BottomNavigationBarItem(icon: Icon(Icons.calculate, size: 18), label: "အချုပ်")],
      ),
    );
  }
}
