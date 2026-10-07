import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  final bool isLargeScreen;
  final String activeSubMenu;
  final bool isLightMode;

  const KyawThetNaingSheet({
    super.key, 
    required this.isLargeScreen, 
    required this.activeSubMenu, 
    required this.isLightMode
  });

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  // Input Controllers
  final TextEditingController _dateCtrl = TextEditingController(text: "07/10/2026");
  final TextEditingController _rateCtrl = TextEditingController(text: "50000");
  final TextEditingController _mornCtrl = TextEditingController(text: "00");
  final TextEditingController _noonCtrl = TextEditingController(text: "00");
  final TextEditingController _nightCtrl = TextEditingController(text: "00");

  final TextEditingController _shareAdvanceCtrl = TextEditingController(text: "0");
  final TextEditingController _privateAdvanceCtrl = TextEditingController(text: "0");

  final TextEditingController _d1NameCtrl = TextEditingController(text: "မောင်မောင်");
  final TextEditingController _d1TripsCtrl = TextEditingController(text: "0");
  final TextEditingController _d1AdvanceCtrl = TextEditingController(text: "0");
  final TextEditingController _d2NameCtrl = TextEditingController(text: "အောင်အောင်");
  final TextEditingController _d2TripsCtrl = TextEditingController(text: "0");
  final TextEditingController _d2AdvanceCtrl = TextEditingController(text: "0");

  final TextEditingController _fuelCtrl = TextEditingController(text: "0");
  final TextEditingController _foodCtrl = TextEditingController(text: "0");
  final TextEditingController _repairCtrl = TextEditingController(text: "0");

  @override
  void dispose() {
    _dateCtrl.dispose(); _rateCtrl.dispose(); _mornCtrl.dispose(); _noonCtrl.dispose(); _nightCtrl.dispose();
    _shareAdvanceCtrl.dispose(); _privateAdvanceCtrl.dispose();
    _d1NameCtrl.dispose(); _d1TripsCtrl.dispose(); _d1AdvanceCtrl.dispose();
    _d2NameCtrl.dispose(); _d2TripsCtrl.dispose(); _d2AdvanceCtrl.dispose();
    _fuelCtrl.dispose(); _foodCtrl.dispose(); _repairCtrl.dispose();
    super.dispose();
  }

  Widget _buildInputField(TextEditingController ctrl, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: widget.isLightMode ? Colors.white : const Color(0xFF121824),
        border: Border.all(color: Colors.amber, width: 1.4),
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextField(
        controller: ctrl, keyboardType: TextInputType.number,
        style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white, fontSize: 13.0, fontWeight: FontWeight.w900),
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold), border: InputBorder.none),
      ),
    );
  }

  Widget _buildRowTable(List<String> items, {bool isHeader = false, Color? bgColor}) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: bgColor ?? (isHeader ? const Color(0xFF243147) : Colors.black12),
      child: Row(
        mainAxisAlignment: CrossAxisAlignment.spaceAround,
        children: items.map((text) => Expanded(
          child: Text(
            text, 
            style: TextStyle(color: isHeader ? Colors.amber : (widget.isLightMode ? Colors.black87 : Colors.white), fontWeight: FontWeight.w900, fontSize: 11.5), 
            textAlign: TextAlign.center
          ),
        )).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = !widget.isLightMode ? const Color(0xFF1E293D) : Colors.white;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 📄 ခေါက်ရေနှင့် ဝင်ငွေဇယား ကဏ္ဍ
          if (widget.activeSubMenu.contains("ခေါက်ရေနှင့် ဝင်ငွေဇယား"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _buildInputField(_dateCtrl, "ရက်စွဲ"),
                    _buildInputField(_rateCtrl, "ကားခနှုန်း (Auto)"),
                    Row(
                      children: [
                        Expanded(child: _buildInputField(_mornCtrl, "မနက်")),
                        const SizedBox(width: 4),
                        Expanded(child: _buildInputField(_noonCtrl, "နေ့လည်")),
                        const SizedBox(width: 4),
                        Expanded(child: _buildInputField(_nightCtrl, "ည")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildRowTable(["ရက်စွဲ", "မနက်", "နေ့လည်", "ည", "ကားခ", "ရငွေ"], isHeader: true),
                    _buildRowTable(["06/10", "04", "04", "02", "50k", "500,000"]),
                  ],
                ),
              ),
            ),

          // 💰 ကြိုတင်ယူငွေစာရင်း ကဏ္ဍ
          if (widget.activeSubMenu.contains("ကြိုတင်ယူငွေစာရင်း"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _buildInputField(_shareAdvanceCtrl, "ကြိုတင်ငွေ (ခွဲဝေယူ)"),
                    _buildInputField(_privateAdvanceCtrl, "ကြိုတင်ငွေ (သီးသန့်ယူ)"),
                    const SizedBox(height: 10),
                    _buildRowTable(["ရက်စွဲ", "ခွဲဝေယူငွေ", "သီးသန့်ယူငွေ"], isHeader: true),
                    _buildRowTable(["06/10", "200,000 ကျပ်", "100,000 ကျပ်"]),
                  ],
                ),
              ),
            ),

          // 👥 Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း ကဏ္ဍ
          if (widget.activeSubMenu.contains("Driver ၂ ဦး"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildInputField(_d1NameCtrl, "Driver၁ အမည်")),
                        const SizedBox(width: 4),
                        Expanded(child: _buildInputField(_d1TripsCtrl, "ခေါက်ရေ")),
                        const SizedBox(width: 4),
                        Expanded(child: _buildInputField(_d1AdvanceCtrl, "ကြိုတင်")),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _buildInputField(_d2NameCtrl, "Driver၂ အမည်")),
                        const SizedBox(width: 4),
                        Expanded(child: _buildInputField(_d2TripsCtrl, "ခေါက်ရေ")),
                        const SizedBox(width: 4),
                        Expanded(child: _buildInputField(_d2AdvanceCtrl, "ကြိုတင်")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildRowTable(["Driver", "ခေါက်ရေ", "ကြိုတင်ယူငွေ"], isHeader: true),
                    _buildRowTable(["မောင်မောင်", "6 ခေါက်", "20,000 ကျပ်"]),
                    _buildRowTable(["အောင်အောင်", "4 ခေါက်", "15,000 ကျပ်"]),
                  ],
                ),
              ),
            ),

          // 🧮 အသားတင် အမြတ်/အရှုံးချုပ် ကဏ္ဍ
          if (widget.activeSubMenu.contains("အသားတင် အမြတ်/အရှုံးချုပ်"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    _buildInputField(_fuelCtrl, "ဆီဖိုး (-)"),
                    _buildInputField(_foodCtrl, "ထမင်းဖိုး (-)"),
                    _buildInputField(_repairCtrl, "ပြင်စရိတ် (-)"),
                    const SizedBox(height: 10),
                    _buildRowTable(["ရက်စွဲ", "ရငွေ", "ဆီဖိုး", "ထမင်း", "ပြင်စရိတ်", "အမြတ်"], isHeader: true),
                    _buildRowTable(["06/10", "500k", "150k", "20k", "0", "+330k"], bgColor: Colors.teal.withOpacity(0.8)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
