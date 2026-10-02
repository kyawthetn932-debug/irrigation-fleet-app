import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: IrrigationFleetApp(), debugShowCheckedModeBanner: false));

class IrrigationFleetApp extends StatefulWidget {
  const IrrigationFleetApp({super.key});
  @override
  State<IrrigationFleetApp> createState() => _IrrigationFleetAppState();
}

class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  final _driver = TextEditingController(text: "ဦးအောင်");
  final _morning = TextEditingController(text: "0");
  final _afternoon = TextEditingController(text: "0");
  final _evening = TextEditingController(text: "0");
  final _rate = TextEditingController(text: "5000");

  @override
  Widget build(BuildContext context) {
    int totalTrips = (int.tryParse(_morning.text) ?? 0) + (int.tryParse(_afternoon.text) ?? 0) + (int.tryParse(_evening.text) ?? 0);
    int totalSalary = totalTrips * (int.tryParse(_rate.text) ?? 0);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('ဆည်မြောင်း ကားစာရင်း - အဆင့် (၁)'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း (ဒရိုင်ဘာ အပိုင်း)", style: TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: _driver, decoration: const InputDecoration(labelText: "ယာဉ်မောင်းအမည်", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            Row(children: [
              Expanded(child: TextField(controller: _morning, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "နံနက် ခေါက်ရေ", border: OutlineInputBorder()), onChanged: (v) => setState(() {}))),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: _afternoon, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "နေ့လယ် ခေါက်ရေ", border: OutlineInputBorder()), onChanged: (v) => setState(() {}))),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: _evening, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "ည ခေါက်ရေ", border: OutlineInputBorder()), onChanged: (v) => setState(() {}))),
            ]),
            const SizedBox(height: 15),
            TextField(controller: _rate, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "သတ်မှတ်ခေါက်ကြေးနှုန်း (ကျပ်)", border: OutlineInputBorder()), onChanged: (v) => setState(() {})),
            const Divider(height: 40, color: Colors.white24),
            const Text("📊 တွက်ချက်မှု ရလဒ်များ", style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text("စုစုပေါင်း ခေါက်ရေ: $totalTrips ခေါက်", style: const TextStyle(fontSize: 16, color: Colors.white)),
            Text("ဒရိုင်ဘာ မောင်းကြေး စုစုပေါင်း: $totalSalary ကျပ်", style: const TextStyle(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
