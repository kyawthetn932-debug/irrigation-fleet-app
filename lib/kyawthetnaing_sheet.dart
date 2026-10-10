import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  const KyawThetNaingSheet({super.key});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('၅.၅ နေ့စဉ်မှတ်တမ်းစာရင်းချုပ်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Theme(
                data: Theme.of(context).copyWith(cardColor: const Color(0xFF1E1E1E)),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(const Color(0xFF2D2D2D)),
                  dataRowMinHeight: 32,
                  dataRowMaxHeight: 40,
                  horizontalMargin: 10,
                  columnSpacing: 15,
                  columns: const [
                    DataColumn(label: Text('ရက်စွဲ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('ကားနံပါတ်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('အလုပ်ဆိုဒ်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('ကျင်းရေ/ခေါက်ရေ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('ရရန်ငွေ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('ဆီဖိုး', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('ဒရိုင်ဘာကြေး', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('အထွေထွေ', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('အသားတင်အမြတ်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    ...List.generate(5, (index) {
                      return DataRow(
                        cells: [
                          DataCell(Text('${index + 1}/10/2026', style: const TextStyle(color: Colors.white70, fontSize: 13))),
                          const DataCell(Text('ဆည်မြောင်း-၁', style: TextStyle(color: Colors.white70, fontSize: 13))),
                          const DataCell(Text('တာပတ်လမ်း', style: TextStyle(color: Colors.white70, fontSize: 13))),
                          const DataCell(Text('၁၀ ခေါက်', style: TextStyle(color: Colors.white70, fontSize: 13))),
                          const DataCell(Text('၁၅၀,၀၀၀', style: TextStyle(color: Colors.white, fontSize: 13))),
                          const DataCell(Text('၅၀,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 13))),
                          const DataCell(Text('၂၀,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 13))),
                          const DataCell(Text('၅,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 13))),
                          const DataCell(Text('၇၅,၀၀၀', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 13))),
                        ],
                      );
                    }),
                    DataRow(
                      color: WidgetStateProperty.all(const Color(0xFF332B00)),
                      cells: [
                        const DataCell(Text('စုစုပေါင်းချုပ်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
                        const DataCell(Text('')),
                        const DataCell(Text('')),
                        const DataCell(Text('၅၀ ခေါက်', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
                        const DataCell(Text('၇၅၀,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
                        const DataCell(Text('၂၅၀,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
                        const DataCell(Text('၁၀၀,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
                        const DataCell(Text('၂၅,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13))),
                        const DataCell(Text('၃၇၅,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
