import 'package:flutter/material.dart';

// Class Name အား ဖိုင်အမည်ဖြစ်သည့် kyawthetnaing_sheet နှင့် တိကျစွာ ချိတ်ဆက်ထားပါသည်
class KyawThetNaingSheet extends StatefulWidget {
  const KyawThetNaingSheet({super.key});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _ObjectiveLedgerState extends State<KyawThetNaingSheet> {
  // ဤနေရာတွင် Class ရဲ့ State အား ယခင်အတိုင်း စနစ်တကျ မောင်းနှင်ပါမည်
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

  final List<Map<String, dynamic>> _logs = [
    {"date": "08/10/2026", "trips": "12", "fare": "600000", "profit": "320000"},
  ];

  final List<Map<String, dynamic>> _advanceLogs = [
    {"date": "08/10/2026", "amount": "200000", "note": "ဆည်မြောင်းစိုက်ငွေ"},
  ];

  final List<Map<String, dynamic>> _driverLogs = [
    {"date": "08/10/2026", "d1": "ဦးအောင် (၆ ခေါက်)", "d2": "ဦးဘ (၆ ခေါက်)", "wage": "၆၀၀၀၀"},
  ];

  Widget _in(String l, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: l,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 11),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 1.5)),
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
        child: _buildSheetContent(trips, fare, fuel, repair, profit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E2C),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white60,
        currentIndex: _getCurrentIndex(),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (index) {
          setState(() {
            if (index == 0) _subView = "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား";
            if (index == 1) _subView = "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း";
            if (index == 2) _subView = "(၅.၃) Driver ၂ ဦး စရိတ်ရှင်းတမ်း";
            if (index == 3) _subView = "(၅.၄) အသားတင် အမြတ်/အရှုံးချုပ်";
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.table_chart, size: 20), label: "(၅.၁) ဝင်ငွေ"),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on, size: 20), label: "(၅.၂) ကြိုတင်ယူ"),
          BottomNavigationBarItem(icon: Icon(Icons.people, size: 20), label: "(၅.၃) Driver"),
          BottomNavigationBarItem(icon: Icon(Icons.calculate, size: 20), label: "(၅.၄) အချုပ်"),
        ],
      ),
    );
  }

  int _getCurrentIndex() {
    if (_subView == "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း") return 1;
    if (_subView == "(၅.၃) Driver ၂ ဦး စရိတ်ရှင်းတမ်း") return 2;
    if (_subView == "(၅.၄) အသားတင် အမြတ်/အရှုံးချုပ်") return 3;
    return 0;
  }
  Widget _buildSheetContent(int trips, int fare, int fuel, int repair, int profit) {
    if (_subView == "(၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား") {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 4),
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
                    Padding(padding: EdgeInsets.all(6), child: Text("อမြတ်/အရှုံး", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amber))),
                  ],
                ),
                ..._logs.map((log) => TableRow(
                  children: [
                    Padding(padding: const EdgeInsets.all(6), child: Text(log["date"].toString(), style: const TextStyle(fontSize: 11, color: Colors.white))),
                    Padding(padding: const EdgeInsets.all(6), child: Text(log["trips"].toString(), style: const TextStyle(fontSize: 11, color: Colors.white))),
                    Padding(padding: const EdgeInsets.all(6), child: Text(log["fare"].toString(), style: const TextStyle(fontSize: 11, color: Colors.white))),
                    Padding(padding: const EdgeInsets.all(6), child: Text(log["profit"].toString(), style: TextStyle(fontSize: 11, color: int.parse(log["profit"].toString()) >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold))),
                  ],
                )),
              ],
            )
          ],
        ),
      );
    }

    if (_subView == "(၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("💰 ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း (Sheet စတိုင်လ်)", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Colors.white24, width: 1),
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFF1E1E2C)),
                children: [
                  Padding(padding: EdgeInsets.all(6), child: Text("နေ့စွဲ", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(6), child: Text("ကြိုတင်ငွေပမာဏ", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(6), child: Text("မှတ်ချက်", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                ],
              ),
              ..._advanceLogs.map((log) => TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["date"].toString(), style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["amount"].toString(), style: const TextStyle(fontSize: 11, color: Colors.greenAccent))),
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["note"].toString(), style: const TextStyle(fontSize: 11))),
                ],
              )),
            ],
          )
        ],
      );
    }

    if (_subView == "(၅.၃) Driver ၂ ဦး စရိတ်ရှင်းတမ်း") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("👥 Driver ၂ ဦး ခေါက်ရေနှင့် မောင်းကြေးရှင်းတမ်း (Sheet စတိုင်လ်)", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(color: Colors.white24, width: 1),
            children: [
              const TableRow(
                decoration: BoxDecoration(color: Color(0xFF1E1E2C)),
                children: [
                  Padding(padding: EdgeInsets.all(6), child: Text("နေ့စွဲ", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(6), child: Text("ဒရိုင်ဘာ ၁", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(6), child: Text("ဒရိုင်ဘာ ၂", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(6), child: Text("စုစုပေါင်းမောင်းကြေး", style: TextStyle(fontSize: 11, color: Colors.amber, fontWeight: FontWeight.bold))),
                ],
              ),
              ..._driverLogs.map((log) => TableRow(
                children: [
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["date"].toString(), style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["d1"].toString(), style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["d2"].toString(), style: const TextStyle(fontSize: 11))),
                  Padding(padding: const EdgeInsets.all(6), child: Text(log["wage"].toString(), style: const TextStyle(fontSize: 11, color: Colors.greenAccent))),
                ],
              )),
            ],
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("📊 (Net P&L) အသားတင် အမြတ်/အရှုံးချုပ် စာရင်း", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("ယနေ့စုစုပေါင်း အသားတင် အခြေအနေ:", style: TextStyle(fontSize: 12)),
