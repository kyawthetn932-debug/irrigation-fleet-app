import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  const KyawThetNaingSheet({super.key});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  // Numeric Inputs for calculations (Sliders မဟုတ်ဘဲ နံပါတ်ရိုက်ထည့်ရန်)
  final TextEditingController _d1WageController = TextEditingController(text: '20000');
  final TextEditingController _d2WageController = TextEditingController(text: '15000');
  final TextEditingController _d1AdvanceController = TextEditingController(text: '5000');
  final TextEditingController _d2AdvanceController = TextEditingController(text: '3000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F141C), // Obsidian Black
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3D Card Style Driver 1 Section
              _buildDriverAdvanceCard('ဒရိုင်ဘာ ၁ (ဦးအေးအောင်) ကြိုတင်ငွေ ရှင်းလင်းရေး', Colors.amber, _d1WageController, _d1AdvanceController),
              const SizedBox(height: 16),
              
              // 3D Card Style Driver 2 Section
              _buildDriverAdvanceCard('ဒရိုင်ဘာ ၂ (ဦးမောင်မောင်) ကြိုတင်ငွေ ရှင်းလင်းရေး', Colors.cyanAccent, _d2WageController, _d2AdvanceController),
              const SizedBox(height: 25),

              const Text(
                '၅.၅ နေ့စဉ်မှတ်တမ်းစာရင်းချုပ် (ဒရိုင်ဘာ ၂ ဦး ကြိုတင်ငွေကော်လံပါဝင်မှု)',
                style: TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              // Spreadsheet-Style Sheet Layout
              _buildAdvanceDataTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriverAdvanceCard(String title, Color accentColor, TextEditingController wageCtrl, TextEditingController advCtrl) {
    return Card(
      color: const Color(0xFF161E2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: wageCtrl,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'မောင်းကြေး (ဝေစု)',
                      labelStyle: const TextStyle(color: Colors.white60, fontSize: 12),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white12), borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentColor), borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: const Color(0xFF0F141C),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: advCtrl,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'ကြိုတင်ထုတ်ယူငွေ',
                      labelStyle: const TextStyle(color: Colors.white60, fontSize: 12),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white12), borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: accentColor), borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: const Color(0xFF0F141C),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvanceDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Card(
        color: const Color(0xFF161E2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFF24324D)),
          dataRowMinHeight: 36,
          dataRowMaxHeight: 44,
          horizontalMargin: 12,
          columnSpacing: 14,
          columns: const [
            DataColumn(label: Text('ရက်စွဲ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
            DataColumn(label: Text('ကားခဝင်ငွေ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
            DataColumn(label: Text('D1 ကြိုတင်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
            DataColumn(label: Text('D2 ကြိုတင်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
            DataColumn(label: Text('ဆီဖိုး', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
            DataColumn(label: Text('ပေးရန်ကျန်ငွေ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
          ],
          rows: [
            ...List.generate(3, (index) {
              return DataRow(
                cells: [
                  DataCell(Text('${index + 10}/10/2026', style: const TextStyle(color: Colors.white70, fontSize: 12))),
                  const DataCell(Text('၁၅၀,၀၀၀', style: TextStyle(color: Colors.white, fontSize: 12))),
                  const DataCell(Text('၅,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 12))),
                  const DataCell(Text('၃,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 12))),
                  const DataCell(Text('၅၀,၀၀၀', style: TextStyle(color: Colors.white70, fontSize: 12))),
                  const DataCell(Text('၂၇,၀၀၀', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12))),
                ],
              );
            }),
            DataRow(
              color: WidgetStateProperty.all(const Color(0xFF332B00)),
              cells: [
                const DataCell(Text('စုစုပေါင်းချုပ်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))),
                const DataCell(Text('၄၅၀,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))),
                const DataCell(Text('၁၅,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))),
                const DataCell(Text('၉,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))),
                const DataCell(Text('၁၅၀,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))),
                const DataCell(Text('၈၁,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
