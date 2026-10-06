import 'package:flutter/material.dart';

class DashboardSheet extends StatelessWidget {
  final bool isLargeScreen;
  const DashboardSheet({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🏗️ တာ အမည်အလိုက် စာရင်းချုပ် (Dashboard Sheet)", style: TextStyle(color: Colors.amber, fontSize: isLargeScreen ? 14 : 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          DataTable(
            columns: const [
              DataColumn(label: Text('တာ အမည် / ဆိုဒ်', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('စုစုပေါင်း ဝင်ငွေ', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('စုစုပေါင်း စရိတ်', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('အသားတင်အမြတ်', style: TextStyle(color: Colors.amber))),
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('တာ-၁ (မြေသယ်ဆိုဒ်)')),
                DataCell(Text('1,200,000 ကျပ်')),
                DataCell(Text('500,000 ကျပ်')),
                DataCell(Text('700,000 ကျပ်', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

