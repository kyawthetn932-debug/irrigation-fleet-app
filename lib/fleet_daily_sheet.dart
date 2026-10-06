import 'package:flutter/material.dart';

class FleetDailySheet extends StatelessWidget {
  final bool isLargeScreen;
  final String currentSubMenu;
  const FleetDailySheet({super.key, required this.isLargeScreen, required this.currentSubMenu});

  @override
  Widget build(BuildContext context) {
    bool isFuelMode = currentSubMenu.contains("ဆီစာရင်း");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isFuelMode ? "⛽ ကားအားလုံး ဆီစာရင်း (ဦးဖြူ/ဦးနီ ခွဲဝေမှု)" : "📄 နေ့စဉ် ကားအားလုံး စာရင်းချုပ်", style: TextStyle(color: Colors.amber, fontSize: isLargeScreen ? 14 : 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (!isFuelMode)
            DataTable(
              columns: const [
                DataColumn(label: Text('နေ့စွဲ', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('အမည်', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('ခေါက်ရေ', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('စုစုပေါင်းကားခ', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('ဆီဖိုး (-)', style: TextStyle(color: Colors.amber))),
              ],
              rows: const [
                DataRow(cells: [DataCell(Text('06/10/2026')), DataCell(Text('ဦးဖြူ')), DataCell(Text('၁၅')), DataCell(Text('၇၅၀,၀၀၀')), DataCell(Text('၁၅၀,၀၀၀'))]),
              ],
            )
          else
            DataTable(
              columns: const [
                DataColumn(label: Text('နေ့စွဲ', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('အမည်', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('ဆီပမာဏ (ဂါလံ)', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('ဆီပေပါဈေး', style: TextStyle(color: Colors.amber))),
              ],
              rows: const [
                DataRow(cells: [DataCell(Text('06/10/2026')), DataCell(Text('ဦးဖြူ')), DataCell(Text('၂၀ ဂါလံ')), DataCell(Text('၁၅၀,၀၀၀'))]),
              ],
            ),
        ],
      ),
    );
  }
}

