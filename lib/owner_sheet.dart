import 'package:flutter/material.dart';

class FinanceShareSheet extends StatelessWidget {
  final bool isLargeScreen;
  final String currentSubMenu;
  const FinanceShareSheet({super.key, required this.isLargeScreen, required this.currentSubMenu});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("📊 ဘဏ္ဍာရေး ကဏ္ဍခွဲ: $currentSubMenu", style: TextStyle(color: Colors.amber, fontSize: isLargeScreen ? 14 : 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          DataTable(
            columns: const [
              DataColumn(label: Text('အသေးစိတ် အချက်အလက်ချုပ်', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('ပမာဏ / အခြေအနေ', style: TextStyle(color: Colors.amber))),
            ],
            rows: [
              DataRow(cells: [const DataCell(Text('ဆည်မြောင်းဌာန ပေးချေငွေ')), DataCell(Text(currentSubMenu.contains("ကြိုတင်ငွေ") ? '၁,၀၀၀,၀၀၀ ကျပ်' : 'သက်ဆိုင်ခြင်းမရှိပါ'))]),
              DataRow(cells: [const DataCell(Text('Viber Auto Sync Mode')), DataCell(Text(currentSubMenu.contains("Viber") ? 'Manual Toggle Switch' : 'ပိတ်ထားသည်'))]),
              DataRow(cells: [const DataCell(Text('စုစုပေါင်း လုပ်ငန်းချုပ်ဝင်ငွေ')), DataCell(Text(currentSubMenu.contains("Master") ? '၁၁,၅၀၀,၀၀၀ ကျပ်' : 'ချုပ်နေဆဲ'))]),
            ],
          ),
        ],
      ),
    );
  }
}
