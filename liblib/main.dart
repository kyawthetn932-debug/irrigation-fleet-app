import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: IrrigationFleetApp(), debugShowCheckedModeBanner: false));

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});
  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  String _view = "Dashboard";
  final _driver = TextEditingController(text: "ဦးအောင်");
  final _m = TextEditingController(text: "0");
  final _a = TextEditingController(text: "0");
  final _e = TextEditingController(text: "0");
  final _r = TextEditingController(text: "5000");
  final _p = TextEditingController(text: "450000");
  int _gal = 50;

  @override
  Widget build(BuildContext context) {
    int totalTrips = (int.tryParse(_m.text) ?? 0) + (int.tryParse(_a.text) ?? 0) + (int.tryParse(_e.text) ?? 0);
    int salary = totalTrips * (int.tryParse(_r.text) ?? 0);
    double perGal = (int.tryParse(_p.text) ?? 0) / _gal;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Row(
        children: [
          Container(
            width: 260, color: const Color(0xFF1E1E1E),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blue, Color(0xFF121212)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: const Row(children: [Icon(Icons.local_shipping, color: Colors.amber, size: 35), SizedBox(width: 10), Text('ဆည်မြောင်း ကားစာရင်း', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber))]),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(leading: const Icon(Icons.dashboard, color: Colors.amber), title: const Text("၁။ ပင်မ ဒက်ရှ်ဘုတ်"), onTap: () => setState(() => _view = "Dashboard")),
                      ListTile(leading: const Icon(Icons.people, color: Colors.amber), title: const Text("၂။ ကားပိုင်ရှင်များ & ပြိုင်ဆိုင်မှု"), onTap: () => setState(() => _view = "Owners")),
                      ListTile(leading: const Icon(Icons.table_chart, color: Colors.amber), title: const Text("၃။ နေ့စဉ် ကားခနှင့် ဆီစာရင်း"), onTap: () => setState(() => _view = "DailyLogs")),
                      ListTile(leading: const Icon(Icons.star, color: Colors.amber), title: const Text("၄။ ကိုကျော်သက်နိုင် သီးသန့်"), onTap: () => setState(() => _view = "KoKyawThetNaing")),
                      ListTile(leading: const Icon(Icons.person, color: Colors.amber), title: const Text("၅။ ကားပိုင်ရှင် သီးသန့်ရှင်းတမ်း"), onTap: () => setState(() => _view = "OtherOwners")),
                      ListTile(leading: const Icon(Icons.wallet, color: Colors.amber), title: const Text("၆။ ဘဏ္ဍာရေး စာရင်းချုပ်"), onTap: () => setState(() => _view = "Finance")),
                      ListTile(leading: const Icon(Icons.settings, color: Colors.amber), title: const Text("၇။ စနစ် ဆက်တင်များ"), onTap: () => setState(() => _view = "Settings")),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _view == "KoKyawThetNaing" ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
                    const SizedBox(height: 15),
                    TextField(controller: _driver, decoration: const InputDecoration(labelText: "ယာဉ်မောင်းအမည်", border: OutlineInputBorder())),
                    const SizedBox(height: 15),
                    Row(children: [
                      Expanded(child: TextField(controller: _m, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "နံနက် ခေါက်ရေ", border: OutlineInputBorder()), onChanged: (v) => setState(() {}))),
                      const SizedBox(width: 10),
                      Expanded(child: TextField(controller: _a, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "နေ့လယ် ခေါက်ရေ", border: OutlineInputBorder()), onChanged: (v) => setState(() {}))),
                      const SizedBox(width: 10),
                      Expanded(child: TextField(controller: _e, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "ည ခေါက်ရေ", border: OutlineInputBorder()), onChanged: (v) => setState(() {}))),
                    ]),
                    const SizedBox(height: 15),
                    TextField(controller: _r, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "ဒရိုင်ဘာ သတ်မှတ်ခေါက်ကြေးနှုန်း (ကျပ်)", border: OutlineInputBorder()), onChanged: (v) => setState(() {})),
                    const SizedBox(height: 15),
                    const Text("၁ ပေပါလျှင် သတ်မှတ်ဂါလံ ပမာဏ", style: TextStyle(color: Colors.blue)),
                    Row(children: [50, 51, 52].map((g) => Padding(padding: const EdgeInsets.only(right: 10), child: ChoiceChip(label: Text("$g ဂါလံ"), selected: _gal == g, onSelected: (s) => setState(() => _gal = g)))).toList()),
                    const SizedBox(height: 15),
                    TextField(controller: _p, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "ဆီပေပါဈေးနှုန်း (ကျပ်)", border: OutlineInputBorder()), onChanged: (v) => setState(() {})),
                    const Divider(height: 30),
                    const Text("📊 တွက်ချက်မှု ရလဒ်များ", style: TextStyle(fontSize: 18, color: Colors.green)),
                    const SizedBox(height: 10),
                    Text("စုစုပေါင်း ခေါက်ရေ: $totalTrips ခေါက်", style: const TextStyle(fontSize: 15)),
                    Text("ဒရိုင်ဘာ မောင်းကြေး စုစုပေါင်း: $salary ကျပ်", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text("၁ ဂါလံကျသင့်ဈေးနှုန်း: ${perGal.toStringAsFixed(2)} ကျပ်", style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ) : const Text("ဆည်မြောင်း ကားစာရင်း App။ ဘယ်ဘက် မီနူးများမှ ရွေးချယ်စမ်းသပ်နိုင်ပါသည်။", style: TextStyle(fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }
}
