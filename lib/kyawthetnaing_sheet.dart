import 'package:flutter/material.dart';

class KyawThetNaingSheet extends StatefulWidget {
  final bool isLargeScreen;
  final String activeSubMenu;
  final bool isLightMode;

  const KyawThetNaingSheet({super.key, required this.isLargeScreen, required this.activeSubMenu, required this.isLightMode});

  @override
  State<KyawThetNaingSheet> createState() => _KyawThetNaingSheetState();
}

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  // စာရင်းသွင်းရန် လက်နဲ့ရိုက်ထည့်ရမည့် အကွက်များအတွက် အစစ်အမှန် Controllers 
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

  // 📥 စာရိုက်သွင်းရမည့် အကွက်အစစ်များ ဖန်တီးပေးသည့် ဘုံ Widget
  Widget _buildRealInputField(TextEditingController ctrl, String label, {bool isTrip = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: widget.isLightMode ? Colors.white : const Color(0xFF121824),
        border: Border.all(color: Colors.amber, width: 1.4),
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: isTrip ? TextInputType.number : TextInputType.text,
        maxLength: isTrip ? 2 : null,
        style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white, fontSize: 13.5, fontWeight: FontWeight.w900),
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold), border: InputBorder.none, counterText: ""),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(40)),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('လုပ်ငန်းခွင်ဒေတာအား အောင်မြင်စွာ သိမ်းဆည်းပြီးပါပြီ။')));
        },
        icon: const Icon(Icons.save, size: 16),
        label: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = !widget.isLightMode ? const Color(0xFF1E293D) : Colors.white;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 📄 ၁။ ရက်စွဲနှင့် ခေါက်ရေ ဝင်ငွေဖြည့်သွင်းသည့် ကဏ္ဍ
            if (widget.activeSubMenu.contains("ခေါက်ရေနှင့် ဝင်ငွေဇယား"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text("📄 နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 14)),
                      const SizedBox(height: 8),
                      _buildRealInputField(_dateCtrl, "ရက်စွဲဖြည့်ရန် (နေ့/လ/ခုနှစ်)"),
                      _buildRealInputField(_rateCtrl, "တစ်စီးချင်း ကားခနှုန်း (Auto ဖြည့်ပြီးသား)"),
                      Row(
                        children: [
                          Expanded(child: _buildRealInputField(_mornCtrl, "မနက်ခေါက်", isTrip: true)),
                          const SizedBox(width: 4),
                          Expanded(child: _buildRealInputField(_noonCtrl, "နေ့လည်ခေါက်", isTrip: true)),
                          const SizedBox(width: 4),
                          Expanded(child: _buildRealInputField(_nightCtrl, "ညခေါက်", isTrip: true)),
                        ],
                      ),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),

            // 💰 ၂။ ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း ဖြည့်သွင်းသည့် ကဏ္ဍ
            if (widget.activeSubMenu.contains("ကြိုတင်ယူငွေစာရင်း"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text("💰 ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 14)),
                      const SizedBox(height: 8),
                      _buildRealInputField(_shareAdvanceCtrl, "ကြိုတင်ငွေ (ခွဲဝေယူငွေဖြည့်ရန်)"),
                      _buildRealInputField(_privateAdvanceCtrl, "ကြိုတင်ငွေ (သီးသန့်ယူငွေဖြည့်ရန်)"),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),

            // 👥 ၃။ Driver ၂ ဦး စရိတ်စာရင်း ဖြည့်သွင်းသည့် ကဏ္ဍ
            if (widget.activeSubMenu.contains("Driver ၂ ဦး"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text("👥 Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 14)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(flex: 2, child: _buildRealInputField(_d1NameCtrl, "Driver ၁ အမည်")),
                          const SizedBox(width: 4),
                          Expanded(flex: 1, child: _buildRealInputField(_d1TripsCtrl, "ခေါက်ရေ", isTrip: true)),
                          const SizedBox(width: 4),
                          Expanded(flex: 2, child: _buildRealInputField(_d1AdvanceCtrl, "ကြိုတင်ငွေ")),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(flex: 2, child: _buildRealInputField(_d2NameCtrl, "Driver ၂ အမည်")),
                          const SizedBox(width: 4),
                          Expanded(flex: 1, child: _buildRealInputField(_d2TripsCtrl, "ခေါက်ရေ", isTrip: true)),
                          const SizedBox(width: 4),
                          Expanded(flex: 2, child: _buildRealInputField(_d2AdvanceCtrl, "ကြိုတင်ငွေ")),
                        ],
                      ),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),

            // 🧮 ၄။ အသားတင် စရိတ်နှင့် အမြတ်ချုပ် ဖြည့်သွင်းသည့် ကဏ္ဍ
            if (widget.activeSubMenu.contains("အသားတင် အမြတ်/အရှုံးချုပ်"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Text("🧮 အသားတင် အမြတ်/အရှုံးချုပ် (Net P&L)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 14)),
                      const SizedBox(height: 8),
                      _buildRealInputField(_fuelCtrl, "ယနေ့ သုံးစွဲသည့် ဆီဖိုးကျသင့်ငွေ (-)"),
                      _buildRealInputField(_foodCtrl, "ဆည်မြောင်းဌာနသို့ ရှင်းရမည့် ထမင်းဖိုး (-)"),
                      _buildRealInputField(_repairCtrl, "မိမိကား၏ ပြင်ဆင်စရိတ်သီးသန့် (-)"),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "အသားတင်အမြတ်စုစုပေါင်း (Net P&L Auto): စာရင်းချုပ်တွက်ချက်ရန်အသင့်", 
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12), 
                          textAlign: TextAlign.center
                        ),
                      ),
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
