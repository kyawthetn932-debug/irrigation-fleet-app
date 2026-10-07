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

class _KeepState {} // Widget Configuration Tag

class _KyawThetNaingSheetState extends State<KyawThetNaingSheet> {
  @override
  Widget build(BuildContext context) {
    bool isDark = !widget.isLightMode;
    Color cardColor = isDark ? const Color(0xFF1E293D) : Colors.white;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 📄 (၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား ကဏ္ဍ
          if (widget.activeSubMenu.contains("၅.၁"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("📄 နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: widget.isLargeScreen ? 16 : 14)),
                    const SizedBox(height: 12),
                    _buildFakeInput("ရက်စွဲ: 06/10/2026"),
                    _buildFakeInput("ကားခနှုန်း (Auto): 50,000 ကျပ်"),
                    _buildFakeInput("မနက်ခေါက်: 04  |  နေ့လည်ခေါက်: 04  |  ညခေါက်: 02"),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      onPressed: () {},
                      child: const Text("နေ့စဉ်မှတ်တမ်းထဲသို့ သိမ်းဆည်းမည်", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),

          // 💰 (၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း ကဏ္ဍ
          if (widget.activeSubMenu.contains("၅.၂"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("💰 ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    _buildFakeInput("ကြိုတင်ငွေ (ခွဲဝေယူ): 200,000 ကျပ်"),
                    _buildFakeInput("ကြိုတင်ငွေ (သီးသန့်ယူ): 100,000 ကျပ်"),
                  ],
                ),
              ),
            ),

          // 👥 (၅.၃) Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း ကဏ္ဍ
          if (widget.activeSubMenu.contains("၅.၃"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("👥 Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    _buildFakeInput("Driver ၁ (မောင်မောင်): 6 ခေါက်  |  ကြိုတင်: 20,000 ကျပ်"),
                    _buildFakeInput("Driver ၂ (အောင်အောင်): 4 ခေါက်  |  ကြိုတင်: 15,000 ကျပ်"),
                  ],
                ),
              ),
            ),

          // 🧮 (၅.၄) အသားတင် အမြတ်/အရှုံးချုပ် ကဏ္ဍ
          if (widget.activeSubMenu.contains("၅.၄"))
            Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("🧮 အသားတင် အမြတ်/အရှုံးချုပ် (Net P&L)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    _buildFakeInput("ဆီဖိုး: 150,000 ကျပ်  |  ထမင်းဖိုး: 20,000 ကျပ်"),
                    _buildFakeInput("ပြင်စရိတ်: 0 ကျပ်  |  မောင်းကြေးစနစ်: Option 1 (%)"),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.teal, // <- ကျနော် ဒီနေရာကို Colors.teal လို့ စနစ်တကျ မှန်ကန်အောင် ပြင်ပေးထားပါတယ်
                      child: const Text("အသားတင်အမြတ်စုစုပေါင်း: +350,000 ကျပ်", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFakeInput(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.black12, border: Border.all(color: Colors.amber.withOpacity(0.5)), borderRadius: BorderRadius.circular(6)),
      child: Row(children: [Text(text, style: const TextStyle(fontSize: 13))]),
    );
  }
}
