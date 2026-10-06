import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: IrrigationFleetApp(), debugShowCheckedModeBanner: false));

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});
  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  String _view = "Dashboard";
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
    {"date": "05/10/2026", "trips": 12, "fare": 600000, "profit": 320000},
  ];

  Widget _in(String l, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(labelText: l, border: const OutlineInputBorder(), contentPadding: const EdgeInsets.all(6)),
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
    if (_option == 1) wage = ((fare - fuel) * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_option == 2) wage = (fare * ((int.tryParse(_p.text) ?? 10) / 100)).toInt();
    if (_option == 3) wage = trips * (int.tryParse(_w.text) ?? 5000);
    int profit = fare - fuel - repair - (wage < 0 ? 0 : wage);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: Text(_view, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)), backgroundColor: const Color(0xFF1E1E2C)),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF1E1E2C),
          child: ListView(
            children: [
              const DrawerHeader(child: Center(child: Text("ဆည်မြောင်းဆောက်လုပ်ရေး\nကားစာရင်းချုပ်", style: TextStyle(color: Colors.amber, fontSize: 14), textAlign: TextAlign.center))),
              ListTile(leading: const Icon(Icons.dashboard, color: Colors.amber), title: const Text("📁 ၁။ ပင်မ ဒက်ရှ်ဘုတ်"), onTap: () { setState(() { _view = "Dashboard"; }); Navigator.pop(context); }),
              ListTile(leading: const Icon(Icons.assignment, color: Colors.amber), title: const Text("👤 ၂။ ပိုင်ရှင်များ ကားခရှင်းတမ်း"), onTap: () { setState(() { _view = "ပိုင်ရှင်များ ကားခရှင်းတမ်း"; }); Navigator.pop(context); }),
              ListTile(leading: const Icon(Icons.stars, color: Colors.amber), title: const Text("👑 ၃။ ကိုကျော်သက်နိုင် စာရင်း"), onTap: () { setState(() { _view = "ကိုကျော်သက်နိုင် စာရင်း"; }); Navigator.pop(context); }),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _view == "ကိုကျော်သက်နိုင် စာရင်း"
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(child: ListTile(leading: const Icon(Icons.calendar_today), title: Text("ရက်စွဲ: ${_date.day}/${_date.month}/${_date.year}"), onTap: () async {
                      DateTime? p = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime(2030));
                      if (p != null) setState(() { _date = p; });
                    })),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(10)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Column(children: [const Text("ကားခပေါင်း", style: TextStyle(fontSize: 11)), Text("$fare ကျပ်", style: const TextStyle(fontWeight: FontWeight.bold))]),
                        Column(children: [Text(profit >= 0 ? "အသားတင် အမြတ်" : "အသားတင် အရှုံး", style: const TextStyle(fontSize: 11)), Text("${profit.abs()} ကျပ်", style: TextStyle(color: profit >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold))]),
                      ]),
                    ),
                    const SizedBox(height: 12),
                    Row(children: [Expanded(child: _in("မနက်", _m)), const SizedBox(width: 6), Expanded(child: _in("နေ့လည်", _a)), const SizedBox(width: 6), Expanded(child: _in("ည", _e))]),
                    _in("တစ်စီးချင်းကားခ", _r), _in("ဆီပေပါ ဈေးနှုန်း", _f), _in("ပြုပြင်စရိတ်", _rp),
                    const Text("🧮 မောင်းကြေးစနစ် ရွေးချယ်ရန်", style: TextStyle(fontSize: 12, color: Colors.amber)),
                    DropdownButton(value: _option, isExpanded: true, dropdownColor: const Color(0xFF1E1E2C), items: const [
                      DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ %")),
                      DropdownMenuItem(value: 2, child: Text("Option 2: စိတ်ကြိုက် %")),
                      DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေး")),
                    ], onChanged: (v) => setState(() { _option = v!; })),
                    if (_option == 1 || _option == 2) _in("မောင်းကြေး ရာခိုင်နှုန်း (%)", _p),
                    if (_option == 3) _in("တစ်ခေါက်ချင်း အပြတ်ကြေး", _w),
                    const SizedBox(height: 8),
                    ElevatedButton(onPressed: () {
                      setState(() { _logs.insert(0, {"date": "${_date.day}/${_date.month}/${_date.year}", "trips": trips, "fare": fare, "profit": profit}); });
                    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 36)), child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(color: Colors.black))),
                    const SizedBox(height: 12),
                    const Text("📊 နေ့စဉ် ကိုယ်ပိုင်မှတ်တမ်းဇယား", style: TextStyle(fontSize: 12, color: Colors.amber)),
                    Table(border: TableBorder.all(color: Colors.white12), children: [
                      const TableRow(decoration: BoxDecoration(color: Color(0xFF1E1E2C)), children: [Padding(padding: EdgeInsets.all(5), child: Text("နေ့စွဲ", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("ခေါက်ရေ", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("ကားခ", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("အမြတ်/အရှုံး", style: TextStyle(fontSize: 10)))]),
                      ..._logs.map((log) => TableRow(children: [Padding(padding: const EdgeInsets.all(5), child: Text(log["date"], style: const TextStyle(fontSize: 10))), Padding(padding: const EdgeInsets.all(5), child: Text("${log["trips"]}", style: const TextStyle(fontSize: 10))), Padding(padding: const EdgeInsets.all(5), child: Text("${log["fare"]}", style: const TextStyle(fontSize: 10))), Padding(padding: const EdgeInsets.all(5), child: Text("${log["profit"]}", style: TextStyle(fontSize: 10, color: log["profit"] >= 0 ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold)))]))
                    ])
                  ],
                ),
              )
            : _view == "ပိုင်ရှင်များ ကားခရှင်းတမ်း"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("📊 ကားပိုင်ရှင်အလိုက် တစ်စီးချင်း ကားခစာရင်း", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Card(
                        color: const Color(0xFF1E1E2C),
                        child: ExpansionTile(
                          title: const Text("ဦးဖြူ စာရင်းချုပ် ([▼] နှိပ်ရန်)", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                          children: [
                            Table(border: TableBorder.all(color: Colors.white12), children: const [
                              TableRow(decoration: BoxDecoration(color: Color(0xFF121212)), children: [Padding(padding: EdgeInsets.all(5), child: Text("ကားနံပါတ်", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("ကားခ", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("ရရန်ကျန်", style: TextStyle(fontSize: 10)))]),
                              TableRow(children: [Padding(padding: EdgeInsets.all(5), child: Text("YTN-1111", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("၅၀၀,၀၀၀", style: TextStyle(fontSize: 10))), Padding(padding: EdgeInsets.all(5), child: Text("၃၂၀,၀၀၀", style: TextStyle(fontSize: 10, color: Colors.greenAccent)))]),
                            ])
                          ],
                        ),
                      )
                    ],
                  )
                : Center(child: Text("Welcome to $_view\n[Google Sheets Auto-Sync Ready]", textAlign: TextAlign.center)),
      ),
    );
  }
}
