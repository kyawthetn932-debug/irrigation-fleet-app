import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: IrrigationFleetApp(), debugShowCheckedModeBanner: false));

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});
  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  String _view = "ကိုကျော်သက်နိုင် စာရင်း";
  int _option = 1;
  DateTime _date = DateTime.now();

  // စာသားနှင့် ဂဏန်းများ ထင်းခနဲ ပေါ်စေရန် ပြင်ဆင်ခြင်း
  final _m = TextEditingController(text: "0");
  final _a = TextEditingController(text: "0");
  final _e = TextEditingController(text: "0");
  final _r = TextEditingController(text: "50000");
  final _f = TextEditingController(text: "150000");
  final _rp = TextEditingController(text: "0");
  final _w = TextEditingController(text: "5000");
  final _p = TextEditingController(text: "10");

  // နေ့စဉ် ကိုယ်ပိုင်မှတ်တမ်းဇယား (Sheet စတိုင်) အလိုအလျောက် ပေါ်နေမည့် မူလဒေတာ
  final List<Map<String, dynamic>> _logs = [
    {"date": "6/10/2026", "trips": "12", "fare": "600000", "profit": "320000"},
  ];

  Widget _in(String l, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: c,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold), // ၁။ ဂဏန်းရိုက်လျှင် ဖြူဖြူလွင်လွင် ထင်ရှားစွာ ပေါ်စေမည့် စနစ်
        decoration: InputDecoration(
          labelText: l,
          labelStyle: const TextStyle(color: Colors.white70, fontSize: 11),
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
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
        title: Text("ဆည်မြောင်းဆောက်လုပ်ရေးကား - $_view", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
        backgroundColor: const Color(0xFF1E1E2C)
      ),
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
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(children: [const Text("ကားခပေါင်း", style: TextStyle(fontSize: 11, color: Colors.grey)), const SizedBox(height: 4), Text("$fare ကျပ်", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent, fontSize: 14))]),
                          Column(children: [Text(profit >= 0 ? "အသားတင် အမြတ်" : "အသားတင် အရှုံး", style: const TextStyle(fontSize: 11, color: Colors.grey)), const SizedBox(height: 4), Text("${profit.abs()} ကျပ်", style: TextStyle(color: profit >= 0 ? Colors.amber : Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14))]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: _in("မနက်", _m)),
                        const SizedBox(width: 8),
                        Expanded(child: _in("နေ့လည်", _a)),
                        const SizedBox(width: 8),
                        Expanded(child: _in("ည", _e)),
                      ],
                    ),
                    _in("တစ်စီးချင်းကားခ", _r),
                    _in("ဆီပေပါ ဈေးနှုန်း", _f),
                    _in("ပြုပြင်စရိတ်", _rp),
                    const SizedBox(height: 4),
                    const Text("🧮 မောင်းကြေးစနစ် ရွေးချယ်ရန်", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 10),
                    if (_option == 1 || _option == 2) _in("မောင်းကြေး ရာခိုင်နှုန်း (%)", _p),
                    if (_option == 3) _in("တစ်ခေါက်ချင်း အပြတ်ကြေး (ကျပ်)", _w),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _logs.insert(0, {
                            "date": "${_date.day}/${_date.month}/${_date.year}",
                            "trips": "$trips",
                            "fare": "$fare",
                            "profit": "$profit",
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 40)),
                      child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 18),
                    const Text("📊 နေ့စဉ် ကိုယ်ပိုင်မှတ်တမ်းဇယား (Sheet စတိုင်လ်)", style: TextStyle(fontSize: 12, color: Colors.amber, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    
                    // ၂။ ခလုတ်နှိပ်စရာမလိုဘဲ အမြဲတမ်း အလိုအလျောက် ပေါ်နေမည့် Google Sheet ပုံစံ ဇယားကွက်
                    Table(
                      border: TableBorder.all(color: Colors.white24, width: 1),
                      children: [
                        const TableRow(
                          decoration: BoxDecoration(color: Color(0xFF1E1E2C)),
                          children: [
