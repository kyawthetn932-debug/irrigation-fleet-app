import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: IrrigationFleetApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class IrrigationFleetApp extends StatelessWidget {
  const IrrigationFleetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Row(
        children: [
          // Left Sidebar Menu
          Container(
            width: 260,
            color: const Color(0xFF1E1E1E),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  color: Colors.blue,
                  child: const Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.amber, size: 35),
                      SizedBox(width: 10),
                      Text('ဆည်မြောင်း ကားစာရင်း', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber)),
                    ],
                  ),
                ),
                const ListTile(leading: Icon(Icons.dashboard, color: Colors.amber), title: Text("၁။ ပင်မ ဒက်ရှ်ဘုတ်")),
                const ListTile(leading: Icon(Icons.star, color: Colors.amber), title: Text("၄။ ကိုကျော်သက်နိုင် သီးသန့်")),
              ],
            ),
          ),
          // Right Main Screen Placeholder
          const Expanded(
            child: Center(
              child: Text("ဆည်မြောင်း ကားစာရင်း App (အဆင့် ၁ အောင်မြင်ပါသည်)", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
