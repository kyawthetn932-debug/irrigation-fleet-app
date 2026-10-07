import 'package:flutter/material.dart';

class MenuSidebar extends StatelessWidget {
  final String activeMenu;
  final Function(String) onMenuTap;
  final bool isDrawer;
  final bool isLightMode;

  const MenuSidebar({super.key, required this.activeMenu, required this.onMenuTap, required this.isDrawer, required this.isLightMode});

  @override
  Widget build(BuildContext context) {
    Color sidebarBg = isLightMode ? Colors.white : (isDrawer ? Colors.black87 : Colors.transparent);
    Color folderTextColor = isLightMode ? const Color(0xFF121824) : Colors.white;

    return Container(
      color: sidebarBg,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: isLightMode ? const Color(0xFFE2E8F0) : const Color(0xFF243147)),
            child: Center(
              child: Text(
                "🏗️ FLEET & POS\nSYSTEM", 
                style: TextStyle(color: isLightMode ? const Color(0xFF121824) : Colors.amber, fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _buildFolder("👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း", Icons.person, folderTextColor, [
            _buildItem("📄 နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား", context),
            _buildItem("💰 ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း", context),
            _buildItem("👥 Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း", context),
            _buildItem("🧮 အသားတင် အမြတ်/အရှုံးချုပ် (Net P&L)", context),
          ]),
        ],
      ),
    );
  }

  Widget _buildFolder(String title, IconData icon, Color textColor, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.amber, size: 20),
      title: Text(title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: textColor)),
      initiallyExpanded: true,
      iconColor: Colors.amber,
      children: children,
    );
  }

  Widget _buildItem(String title, BuildContext context) {
    bool isSelected = activeMenu == title;
    return ListTile(
      dense: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(title, style: TextStyle(color: isSelected ? Colors.amber : (isLightMode ? Colors.black87 : Colors.white70), fontSize: 12.0, fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold)),
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
