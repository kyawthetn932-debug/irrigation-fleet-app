import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  const KyawThetNaingSheet({super.key});
  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this, initialIndex: 4);
  }
  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F141C),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: const Color(0xFF161E2E),
          bottom: TabBar(
            controller: _tabCtrl,
            isScrollable: true,
            indicatorColor: Colors.amber,
            tabs: const [
              Tab(text: '၅.၁ ဆိုဒ်'), Tab(text: '၅.၂ ပိုင်ရှင်'),
              Tab(text: '၅.၃ မှတ်တမ်း'), Tab(text: '၅.၄ ဆီ'), Tab(text: '၅.၅ စာရင်းချုပ်'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _bCard('၅.၁ ဆိုက်ရွေးချယ်မှု စာရင်းဇယား', 'ဆည်မြောင်း ဆောက်လုပ်ရေး လုပ်ငန်းခွင် အတည်ပြုပြီး'),
          _bCard('၅.၂ ပိုင်ရှင်စာရင်းနှင့် ဝေစု', 'ယာဉ်ပိုင်ရှင် - ကိုကျော်သက်နိုင် (၁၀၀%)'),
          _bCard('၅.၃ နေ့စဉ်အလုပ်လုပ်မှု မှတ်တမ်း', 'နေ့စဉ် ကားခဝင်ငွေနှင့် ခေါက်ရေ တွက်ချက်မှုကွက်'),
          _bCard('၅.၄ ဆီမှတ်တမ်းစာရင်း', 'စုစုပေါင်း ကျသင့်ဆီဖိုးကျပ် = ၅၀,၀၀၀ ကျပ်'),
          _buildSpreadsheetSummary(),
        ],
      ),
    );
  }

  Widget _bCard(String t, String desc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 12),
          Card(
            color: const Color(0xFF161E2E),
            child: Padding(padding: const EdgeInsets.all(16), child: Text(desc, style: const TextStyle(color: Colors.white70))),
          ),
        ],
      ),
    );
  }

  Widget _buildSpreadsheetSummary() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('၅.၅ ဒရိုင်ဘာ ၂ ဦး ကြိုတင်ငွေ ရှင်းလင်းရေး ကတ်များ', style: TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _bDriver('D1 (ဦးအေးအောင်)', Colors.amber),
          _bDriver('D2 (ဦးမောင်မောင်)', Colors.cyanAccent),
          const SizedBox(height: 16),
          _buildTable(),
        ],
      ),
    );
  }

  Widget _bDriver(String lbl, Color c) {
    return Card(
      color: const Color(0xFF161E2E),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(lbl, style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(width: 10),
            const Expanded(child: SizedBox(height: 35, child: TextField(keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'မောင်းကြေး', filled: true, fillColor: Color(0xFF0F141C))))),
            const SizedBox(width: 8),
            const Expanded(child: SizedBox(height: 35, child: TextField(keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'ကြိုတင်ငွေ', filled: true, fillColor: Color(0xFF0F141C))))),
          ],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        color: const Color(0xFF161E2E),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFF24324D)),
          dataRowMinHeight: 34, dataRowMaxHeight: 38,
          columns: const [
            DataColumn(label: Text('ရက်စွဲ', style: TextStyle(color: Colors.amber, fontSize: 12))),
            DataColumn(label: Text('ကားခ', style: TextStyle(color: Colors.amber, fontSize: 12))),
            DataColumn(label: Text('D1ကြိုတင်', style: TextStyle(color: Colors.amber, fontSize: 12))),
            DataColumn(label: Text('D2ကြိုတင်', style: TextStyle(color: Colors.amber, fontSize: 12))),
            DataColumn(label: Text('ဆီဖိုး', style: TextStyle(color: Colors.amber, fontSize: 12))),
            DataColumn(label: Text('အသားတင်', style: TextStyle(color: Colors.amber, fontSize: 12))),
          ],
          rows: [
            ...List.generate(2, (i) => DataRow(cells: [
              DataCell(Text('1${i}/10/2026', style: const TextStyle(color: Colors.white70, fontSize: 11))),
              const DataCell(Text('၁၅၀,၀၀၀', style: TextStyle(color: Colors.white, fontSize: 11))),
              const DataCell(Text('၅,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 11))),
              const DataCell(Text('၃,၀၀၀', style: TextStyle(color: Colors.redAccent, fontSize: 11))),
              const DataCell(Text('၅၀,၀၀၀', style: TextStyle(color: Colors.white70, fontSize: 11))),
              const DataCell(Text('၇၅,၀၀၀', style: TextStyle(color: Colors.greenAccent, fontSize: 11))),
            ])),
            DataRow(
              color: WidgetStateProperty.all(const Color(0xFF332B00)),
              cells: [
                const DataCell(Text('စုစုပေါင်း', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 11))),
                const DataCell(Text('၃၀၀,၀၀၀', style: TextStyle(color: Colors.amber, fontSize: 11))),
                const DataCell(Text('၁block,၀၀၀', style: TextStyle(color: Colors.amber, fontSize: 11))),
                const DataCell(Text('၆,၀၀၀', style: TextStyle(color: Colors.amber, fontSize: 11))),
                const DataCell(Text('၁၀၀,၀၀၀', style: TextStyle(color: Colors.amber, fontSize: 11))),
                const DataCell(Text('၁၅block,၀၀၀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
