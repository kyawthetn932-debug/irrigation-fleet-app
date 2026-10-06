import 'package:flutter/material.dart';

class SingleOwnerSheet extends StatelessWidget {
  final bool isLargeScreen;
  const SingleOwnerSheet({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("👤 ကားပိုင်ရှင်တစ်ဦးချင်း သီးသန့်စာရင်း (ရရန်ကျန်ငွေရှင်းတမ်း)", style: TextStyle(color: Colors.amber, fontSize: isLargeScreen ? 14 : 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          DataTable(
            columns: const [
              DataColumn(label: Text('ရက်စွဲ', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('အမည်', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('ကားခပေါင်း', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('ကြိုတင်ယူငွေ (-)', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('ဆီဖိုး (-)', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('ထမင်းဖိုး (-)', style: TextStyle(color: Colors.amber))),
              DataColumn(label: Text('နှုတ်ပြီး ရရန်ကျန်ငွေ', style: TextStyle(color: Colors.amber))),
            ],
            rows: const [
              DataRow(cells: [DataCell(Text('06/10/2026')), DataCell(Text('ဦးဖြူ')), DataCell(Text('၇၅၀,၀၀၀')), DataCell(Text('၅၀,၀၀၀')), DataCell(Text('၁၅၀,၀၀၀')), DataCell(Text('၂၀,၀၀၀')), DataCell(Text('၅၃၀,၀၀၀', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)))]),
            ],
          ),
        ],
      ),
    );
  }
}

