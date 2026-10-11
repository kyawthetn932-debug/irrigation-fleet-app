import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  const KyawThetNaingSheet({super.key});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ၅.၁ မှ ၅.၄ အထိ တွက်ချက်မှုဆိုင်ရာ စာသားထိန်းချုပ်ကွက်များ
  final TextEditingController _siteController = TextEditingController(text: 'တာပတ်လမ်း ဆိုဒ်-က');
  final TextEditingController _ownerController = TextEditingController(text: 'ဦးကျော်သက်နိုင်');
  final TextEditingController _incomeController = TextEditingController(text: '150000');
  final TextEditingController _fuelGalsController = TextEditingController(text: '10');
  final TextEditingController _fuelPriceController = TextEditingController(text: '5000');
  
  // ဒရိုင်ဘာ ၂ ဦး ကြိုတင်ငွေ ထိန်းချုပ်ကွက်များ
  final TextEditingController _d1WageController = TextEditingController(text: '20000');
  final TextEditingController _d2WageController = TextEditingController(text: '15000');
  final TextEditingController _d1AdvController = TextEditingController(text: '5000');
  final TextEditingController _d2AdvController = TextEditingController(text: '3000');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 4); // ၅.၅ ကို ပထမဆုံးပြရန်
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F141C),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          backgroundColor: const Color(0xFF161E2E),
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white60,
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: '၅.၁ ဆိုဒ်ရွေးချယ်မှု'),
              Tab(text: '၅.၂ ပိုင်ရှင်စာရင်း'),
              Tab(text: '၅.၃ နေ့စဉ်မှတ်တမ်း'),
              Tab(text: '၅.၄ ဆီမှတ်တမ်း'),
              Tab(text: '၅.၅ စာရင်းချုပ်'),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: [
            _build5_1_SiteSelection(),
            _build5_2_OwnerRegistry(),
            _build5_3_DailyLogInputs(),
            _build5_4_FuelRecords(),
            _build5_5_MasterSpreadsheetSummary(),
          ],
        ),
      ),
    );
  }

  // ၅.၁ ဆိုက်ရွေးချယ်မှု စာရင်း
  Widget _build5_1_SiteSelection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('၅.၁ ဆိုက်ရွေးချယ်မှု စာရင်းဇယား'),
          _build3DInputField('လက်ရှိ လုပ်ငန်းဆိုဒ်အမည်', _siteController, Icons.location_on),
          const SizedBox(height: 20),
          _buildActionStatusCard('လက်ရှိ ရွေးချယ်ထားသော ဆိုဒ်နေရာသည် ဆည်မြောင်း ဆောက်လုပ်ရေး လုပ်ငန်းခွင်အတွက် အတည်ပြုပြီး ဖြစ်ပါသည်။'),
        ],
      ),
    );
  }

  // ၅.၂ ပိုင်ရှင်စာရင်းဇယား
  Widget _build5_2_OwnerRegistry() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('၅.၂ ပိုင်ရှင်စာရင်းနှင့် ဝေစုသတ်မှတ်ချက်'),
          _build3DInputField('ယာဉ်ပိုင်ရှင်အမည်', _ownerController, Icons.person),
          const SizedBox(height: 12),
          _build3DInputField('ပိုင်ရှင်ဝေစု ရာခိုင်နှုန်း (%)', TextEditingController(text: '100%'), Icons.pie_chart, isReadonly: true),
        ],
      ),
    );
  }

  // ၅.三 နေ့စဉ်မှတ်တမ်းစာရင်း
  Widget _build5_3_DailyLogInputs() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('၅.၃ နေ့စဉ်အလုပ်လုပ်မှု မှတ်တမ်းသွင်းကွက်'),
          _build3DInputField('ကားခ ဝင်ငွေ (ကျပ်)', _incomeController, Icons.monetization_on, isNumber: true),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _build3DInputField('ခေါက်ရေ (နေ့)', TextEditingController(text: '8'), Icons.wb_sunny, isNumber: true)),
              const SizedBox(width: 10),
              Expanded(child: _build3DInputField('ခေါက်ရေ (ည)', TextEditingController(text: '2'), Icons.dark_mode, isNumber: true)),
            ],
          ),
        ],
      ),
    );
  }

  // ၅.၄ ဆီမှတ်တမ်းစာရင်း
  Widget _build5_4_FuelRecords() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('၅.၄ ဆီမှတ်တမ်းနှင့် ကုန်ကျစရိတ် တွက်ချက်မှု'),
          Row(
            children: [
              Expanded(child: _build3DInputField('ဆီဖြည့်ဂါလံ', _fuelGalsController, Icons.local_gas_station, isNumber: true)),
              const SizedBox(width: 10),
              Expanded(child: _build3DInputField('၁ ဂါလံနှုန်း (ကျပ်)', _fuelPriceController, Icons.payments, isNumber: true)),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionStatusCard('စုစုပေါင်း ကျသင့်ဆီဖိုးကျပ် = ၅၀,၀၀၀ ကျပ် (အလိုအလျောက် တွက်ချက်ပြီး)'),
        ],
      ),
    );
  }

  // ၅.၅ နေ့စဉ်မှတ်တမ်းစာရင်းချုပ် (Master Spreadsheet)
  Widget _build5_5_MasterSpreadsheetSummary() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('၅.၅ ဒရိုင်ဘာ ၂ ဦးစနစ် ကြိုတင်ထုတ်ယူငွေ ရှင်းလင်းရေး ကတ်များ'),
          _buildDriverAdvanceRow('ဒရိုင်ဘာ ၁ (ဦးအေးအောင်)', Colors.amber, _d1WageController, _d1AdvController),
          const SizedBox(height: 12),
          _buildDriverAdvanceRow('ဒရိုင်ဘာ ၂ (ဦးမောင်မောင်)', Colors.cyanAccent, _d2WageController, _d2AdvController),
          const SizedBox(height: 20),
          
          const Text(
            '၅.၅ နေ့စဉ်မှတ်တမ်းစာရင်းချုပ် ဇယားကွက်ကြီး',
            style: TextStyle(color: Colors.amber, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildSpreadsheetTableLayout(),
        ],
      ),
    );
  }

  // Helper UI Components
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(title, style: const TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _build3DInputField(String label, TextEditingController controller, IconData icon, {bool isNumber = false, bool isReadonly = false}) {
    return TextField(
      controller: controller,
      readOnly: isReadonly,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60, fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.amber, size: 20),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white12), borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.amber), borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: const Color(0xFF161E2E),
      ),
    );
  }

  Widget _buildDriverAdvanceRow(String label, Color color, TextEditingController wage, TextEditingController adv) {
    return Card(
      color: const Color(0xFF161E2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _build3DInputField('မောင်းကြေး (ဝေစု)', wage, Icons.payments, isNumber: true)),
                const SizedBox(width: 10),
                Expanded(child: _build3DInputField('ကြိုတင်ထုတ်ယူငွေ', adv, Icons.price_check, isNumber: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionStatusCard(String msg) {
    return Card(
      color: const Color(0xFF24324D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.amber, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(msg, style: const TextStyle(color: Colors.white90, fontSize: 12))),
          ],
        ),
      ),
    );
  }

  Widget _buildSpreadsheetTableLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Card(
        color: const Color(0xFF161E2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFF24324D)),
          dataRowMinHeight: 34,
          dataRowMaxHeight: 40,
