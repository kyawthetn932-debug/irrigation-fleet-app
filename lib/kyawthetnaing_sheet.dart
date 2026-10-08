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
  bool _isSavingProcess = false;

  final TextEditingController _dateCtrl = TextEditingController(text: "08/10/2026");
  final TextEditingController _rateCtrl = TextEditingController(text: "50000");
  final TextEditingController _mornCtrl = TextEditingController(text: "00");
  final TextEditingController _noonCtrl = TextEditingController(text: "00");
  final TextEditingController _nightCtrl = TextEditingController(text: "00");
  final TextEditingController _shareAdvanceCtrl = TextEditingController(text: "0");
  final TextEditingController _privateAdvanceCtrl = TextEditingController(text: "0");
  final TextEditingController _fuelCtrl = TextEditingController(text: "0");
  final TextEditingController _foodCtrl = TextEditingController(text: "0");
  final TextEditingController = TextEditingController(text: "0");

  void _safeSaveDataTrigger() async {
    if (_isSavingProcess) return;
    setState(() => _isSavingProcess = true);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('လုပ်ငန်းခွင်ဒေတာအား တစ်ကြိမ်တည်း ကွက်တိသိမ်းဆည်းပြီးပါပြီ။'))
    );

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isSavingProcess = false);
  }

  Widget _buildInputField(TextEditingController ctrl, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        color: widget.isLightMode ? Colors.white : const Color(0xFF121824),
        border: Border.all(color: Colors.amber, width: 1.5),
        borderRadius: BorderRadius.circular(8)
      ),
      child: TextField(
        controller: ctrl,
        style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white, fontSize: 13.5, fontWeight: FontWeight.w900),
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold), border: InputBorder.none),
      ),
    );
  }

  Widget _buildPlainSheetTable(List<String> headers, List<String> data) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.white24, width: 1.2)),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF1E3A8A),
            padding: const EdgeInsets.all(8),
            child: Row(children: headers.map((h) => Expanded(child: Text(h, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11), textAlign: TextAlign.center))).toList()),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.black12,
            child: Row(children: data.map((d) => Expanded(child: Text(d, style: TextStyle(color: widget.isLightMode ? Colors.black87 : Colors.white70, fontWeight: FontWeight.w900, fontSize: 11), textAlign: TextAlign.center))).toList()),
          ),
        ],
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
          children: [
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
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: _isSavingProcess ? Colors.grey : Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(36)),
                        onPressed: _isSavingProcess ? null : _safeSaveDataTrigger,
                        child: Text(_isSavingProcess ? "သိမ်းနေပါသည်..." : "နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      ),
                      _buildPlainSheetTable(["ရက်စွဲ", "မနက်", "နေ့လည်", "ည", "ကားခ", "ရငွေ"], ["08/10", "04", "04", "02", "50k", "500k"]),
                    ],
                  ),
                ),
              ),

            if (widget.activeSubMenu.contains("ကြိုတင်ယူငွေစာရင်း"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInputField(_shareAdvanceCtrl, "ကြိုတင်ငွေ (ခွဲဝေယူ)"),
                      _buildInputField(_privateAdvanceCtrl, "ကြိုတင်ငွေ (သီးသန့်ယူ)"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(36)),
                        onPressed: _safeSaveDataTrigger,
                        child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      ),
                      _buildPlainSheetTable(["ရက်စွဲ", "ခွဲဝေယူ", "သီးသန့်ယူ"], ["08/10", "200k", "100k"]),
                    ],
                  ),
                ),
              ),

            if (widget.activeSubMenu.contains("Driver ၂ ဦး"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInputField(_d1NameCtrl, "Driver၁ အမည်"),
                      _buildInputField(_d1TripsCtrl, "ခေါက်ရေ"),
                      _buildInputField(_d2NameCtrl, "Driver၂ အမည်"),
                      _buildInputField(_d2TripsCtrl, "ခေါက်ရေ"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(36)),
                        onPressed: _safeSaveDataTrigger,
                        child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့  သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      ),
                      _buildPlainSheetTable(["ရက်စွဲ", "D1 အမည်", "ခေါက်", "D2 အမည်", "ခေါက်"], ["08/10", "မောင်မောင်", "6", "အောင်အောင်", "4"]),
                    ],
                  ),
                ),
              ),

            if (widget.activeSubMenu.contains("အသားတင် အမြတ်/အရှုံးချုပ်"))
              Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInputField(_fuelCtrl, "ဆီဖိုး (-)"),
                      _buildInputField(_foodCtrl, "ထမင်းဖိုး (-)"),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size.fromHeight(36)),
                        onPressed: _safeSaveDataTrigger,
                        child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                      ),
                      _buildPlainSheetTable(["ရက်စွဲ", "ရငွေ", "ဆီဖိုး", "ထမင်း", "အမြတ်ချုပ်"], ["08/10", "500k", "150k", "20k", "+330k"]),
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
