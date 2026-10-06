import 'package:flutter/material.dart';

class MenuSidebar extends StatelessWidget {
  final String activeMenu;
  final Function(String) onMenuTap;
  final bool isDrawer;

  const MenuSidebar({super.key, required this.activeMenu, required this.onMenuTap, required this.isDrawer});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 800;

    double folderSize = isLargeScreen ? 15.0 : 13.0;
    double itemSize = isLargeScreen ? 14.0 : 12.0;

    return Container(
      color: isDrawer ? Colors.white.withOpacity(0.85) : Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF243147)),
            child: Center(child: Text("ဆည်မြောင်းဆောက်လုပ်ရေး\nFleet System", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.center)),
          ),
          _buildFolder("၁။ ပင်မ ဒက်ရှ်ဘုတ်", Icons.dashboard, folderSize, [
            _buildItem("🏗️ တာ အမည် ရွေးချယ်ရန် (Dashboard)", itemSize, context),
          ], isLargeScreen),
          _buildFolder("၂။ ကားပိုင်ရှင်များစာရင်း", Icons.people, folderSize, [
            _buildItem("🚙 ကားပိုင်ရှင်များ အမည်စာရင်း (1)", itemSize, context),
            _buildItem("🔒 နေ့စဉ် အစီးအရေအတွက် ပြိုင်ဆိုင်မှု (7)", itemSize, context),
          ], isLargeScreen),
          _buildFolder("၃။ နေ့စဉ်ခရီးစဉ်နှင့် ဆီ", Icons.local_gas_station, folderSize, [
            _buildItem("📄 နေ့စဉ် ကားအားလုံး စာရင်း (2)", itemSize, context),
            _buildItem("⛽ ကားအားလုံး ဆီစာရင်း (3)", itemSize, context),
          ], isLargeScreen),
          _buildFolder("၄။ ကားပိုင်ရှင် သီးသန့်စာရင်း", Icons.person, folderSize, [
            _buildItem("👤 ကားပိုင်ရှင်တစ်ဦးချင်း သီးသန့်စာရင်း (4)", itemSize, context),
            _buildItem("👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း (၅)", itemSize, context),
          ], isLargeScreen, initiallyExpanded: true),
          _buildFolder("၅။ ဘဏ္ဍာရေးနှင့် ခွဲဝေမှု", Icons.account_balance_wallet, folderSize, [
            _buildItem("💰 ကြိုတင်ငွေခွဲဝေယူခြင်း စာရင်း (6)", itemSize, context),
            _buildItem("💬 Viber ဖြင့် Share ရန် (8)", itemSize, context),
            _buildItem("📦 စာရင်းချုပ် ခေါင်းစဉ် သီးသန့် (Master Log)", itemSize, context),
          ], isLargeScreen),
        ],
      ),
    );
  }

  Widget _buildFolder(String title, IconData icon, double fontSize, List<Widget> children, bool isLarge, {bool initiallyExpanded = false}) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.amber, size: 20),
      title: Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: isDrawer ? Colors.black87 : Colors.white)),
      initiallyExpanded: initiallyExpanded,
      iconColor: Colors.amber,
      children: children,
    );
  }

  Widget _buildItem(String title, double fontSize, BuildContext context) {
    bool isSelected = activeMenu == title;
    return ListTile(
      dense: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 12.0), // <- ကျနော် ဒီနေရာကို မှန်အောင် ပြင်ပေးထားပါတယ်
        child: Text(title, style: TextStyle(color: isSelected ? Colors.amber : (isDrawer ? Colors.black54 : Colors.white70), fontSize: fontSize, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ),
      selected: isSelected,
      selectedTileColor: Colors.amber.withOpacity(0.15),
      onTap: () {
        onMenuTap(title);
        if (isDrawer) Navigator.pop(context);
      },
    );
  }
}
