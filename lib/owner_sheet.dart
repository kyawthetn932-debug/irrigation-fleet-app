import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  final bool isLargeScreen;
  const KyawThetNaingSheet({super.key, required this.isLargeScreen});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  final List<Map<String, String>> _records = [
    {"date": "05/10/2026", "morn": "4", "noon": "4", "night": "4", "rate": "50000", "total": "600000", "repair": "0", "net": "320000"},
    {"date": "06/10/2026", "morn": "5", "noon": "5", "night": "2", "rate": "50000", "total": "600000", "repair": "50000", "net": "350000"}
  ];

  void _editCell(int rowIndex, String key, String columnName, double dialogFontSize) {
    TextEditingController editCtrl = TextEditingController(text: _records[rowIndex][key]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F293D),
        title: Text("$columnName အကွက်ကို ပြင်ဆင်ရန်", style: TextStyle(color: Colors.amber, fontSize: dialogFontSize + 2)),
        content: TextField(controller: editCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("ပယ်ဖျက်")),
          TextButton(onPressed: () { setState(() { _records[rowIndex][key] = editCtrl.text; }); Navigator.pop(context); }, child: const Text("သိမ်းဆည်းမည်", style: TextStyle(color: Colors.teal))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cellFontSize = widget.isLargeScreen ? 13.0 : 12.0;
    List<String> headers = ["ရက်စွဲ", "မနက်", "နေ့လည်", "ည", "ကားခနှုန်း", "စုစုပေါင်းရငွေ", "ပြင်ဆင်စရိတ်", "အသားတင်မြတ်"];
    List<String> keys = ["date", "morn", "noon", "night", "rate", "total", "repair", "net"];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white12)),
          child: Table(
            defaultColumnWidth: FixedColumnWidth(widget.isLargeScreen ? 120 : 100),
            border: TableBorder.all(color: Colors.white12),
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFF243147)),
                children: headers.map((header) => Padding(padding: const EdgeInsets.all(8.0), child: Text(header, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: cellFontSize - 1)))).toList(),
              ),
              ...List.generate(_records.length, (rowIndex) {
                return TableRow(
                  children: keys.map((key) {
                    String cellValue = _records[rowIndex][key] ?? "";
                    bool isNet = key == "net";
                    return GestureDetector(
                      onTap: () => _editCell(rowIndex, key, headers[keys.indexOf(key)], cellFontSize),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(color: isNet ? Colors.teal.withOpacity(0.8) : Colors.transparent),
                          child: Text(cellValue, style: TextStyle(color: Colors.white, fontSize: cellFontSize, fontWeight: isNet ? FontWeight.bold : FontWeight.normal)),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
