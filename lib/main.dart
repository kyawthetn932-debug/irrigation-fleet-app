import 'package:flutter/material.dart';

// UI ၏ အဓိက အစိတ်အပိုင်းဖြစ်သော State Class
class _IrrigationFleetAppState extends State<IrrigationFleetApp> {
  // ပုံထဲက data များကို သိမ်းဆည်းရန် ဥပမာ variable များ
  final String dateText = "6/10/2026";
  final int totalPrice = 150000;
  final int carFee = 50000;
  final int optionRate = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // ပုံထဲကအတိုင်း အမည်းရောင် background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- (အပေါ်ပိုင်း Widgets များဖြစ်သည့် ခေါင်းစဉ်နှင့် Input Box များ ဤနေရာတွင်ရှိမည်) ---
              
              const SizedBox(height: 20),

              // ပုံထဲတွင်ပြထားသော 'နေ့စဉ် ကိုယ်ပိုင်မှတ်တမ်းဇယား' (Table Widget အပိုင်း)
              Table(
                border: TableBorder.all(color: Colors.white24),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                children: [
                  // Table Header Row
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('ရက်စွဲ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('ဦးရေ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('ကားခ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('စုစုပေါင်း', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  // Table Data Row (ပုံထဲတွင်ပါသော 05/10/2026 မှတ်တမ်းဒေတာ)
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('05/10/2026', style: TextStyle(color: Colors.white70)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('12', style: TextStyle(color: Colors.white70)),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('600000', style: TextStyle(color: Colors.white70)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.teal, // စုစုပေါင်းပမာဏကို highlight ပြရန်
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          child: const Text(
                            '320000', 
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ], // Table ၏ children list ပိတ်ခြင်း
              ), // Table Widget ပိတ်ခြင်း
              
              const SizedBox(height: 20),
              
              // (လိုအပ်ပါက အခြားအောက်ခြေ widget များကို ဤနေရာတွင် ဆက်ရေးနိုင်သည်)
              
            ], // Column ၏ children list ပိတ်ခြင်း
          ), // Column Widget ပိတ်ခြင်း
        ), // SingleChildScrollView Widget ပိတ်ခြင်း
      ), // Padding Widget ပိတ်ခြင်း
    ); // Scaffold Widget ပိတ်ခြင်း
  } // Widget build ပိတ်ခြင်း
} // Class ပိတ်ခြင်း
