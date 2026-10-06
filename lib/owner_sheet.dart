import 'package:flutter/material.dart';

class OwnerSheet extends StatelessWidget {
  final bool isLargeScreen;
  final String currentSubMenu;

  const OwnerSheet({
    super.key, 
    required this.isLargeScreen, 
    required this.currentSubMenu,
  });

  @override
  Widget build(BuildContext context) {
    bool isRankMode = currentSubMenu.contains("ပြိုင်ဆိုင်မှု");
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isRankMode ? "🔒 နေ့စဉ် အစီးအရေအတွက် ပြိုင်ဆိုင်မှု (သီးသန့်)" : "🚙 ကားပိုင်ရှင်များ အမည်စာရင်း (Bulk Add)", 
            style: TextStyle(
              color: Colors.amber, 
              fontSize: isLargeScreen ? 14 : 12, 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (!isRankMode)
            DataTable(
              columns: const [
                DataColumn(label: Text('အမည်', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('Viber ဖုန်း', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('ကားနံပါတ်', style: TextStyle(color: Colors.amber))),
              ],
              rows: const [
                DataRow(cells: [DataCell(Text('ဦးဖြူ')), DataCell(Text('091234567')), DataCell(Text('7D/9999'))]),
                DataRow(cells: [DataCell(Text('ကိုကျော်သက်နိုင်')), DataCell(Text('094444444')), DataCell(Text('1A/2222'))]),
              ],
            )
          else
            DataTable(
              columns: const [
                DataColumn(label: Text('အဆင့်', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('အမည်', style: TextStyle(color: Colors.amber))),
                DataColumn(label: Text('အစီးအရေအတွက် (ခေါက်ရေ)', style: TextStyle(color: Colors.amber))),
              ],
              rows: const [
                DataRow(cells: [DataCell(Text('၁')), DataCell(Text('ဦးဖြူ')), DataCell(Text('၁၅ ခေါက်'))]),
                DataRow(cells: [DataCell(Text('၂')), DataCell(Text('ကိုကျော်သက်နိုင်')), DataCell(Text('၁၂ ခေါက်'))]),
              ],
            ),
        ],
      ),
    );
  }
}
