import 'package:flutter/material.dart';

class MenuSidebar extends StatelessWidget {
  final String activeMenu;
  final Function(String) onMenuTap;
  final bool isDrawer;
  final bool isLightMode;

  const MenuSidebar({super.key, required this.activeMenu, required this.onMenuTap, required this.isDrawer, required this.isLightMode});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 800;
    double folderSize = isLargeScreen ? 14.0 : 13.0;
    double itemSize = isLargeScreen ? 13.0 : 11.5;

    // နေ့ဘက်သုံး မုဒ်ဖြစ်ပါက အဖြူမှိန်မှိန် Soft Opacity သုံး၍ ညဘက်ဖြစ်က ၎င်းအတိုင်းထားမည်
    Color sidebarBg = isLightMode 
        ? Colors.white.withOpacity(0.95) 
        : (isDrawer ? Colors.black87.withOpacity(0.85) : Colors.transparent);

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
                style: TextStyle(color: isLightMode ? const Color(0xFF121824) : Colors.amber, fontWeight: FontWeight.bold, fontSize: isLargeScreen ? 16 : 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _buildFolder("၄။ ကားပိုင်ရှင် သီးသန့်စာရင်း", Icons.person, folderSize, folderTextColor, [
            _buildItem("📄 (၅.၁) နေ့စဉ် ခေါက်ရေနှင့် ဝင်ငွေဇယား", itemSize, context),
            _buildItem("💰 (၅.၂) ဆည်မြောင်း ကြိုတင်ယူငွေစာရင်း", itemSize, context),
            _buildItem("👥 (၅.၃) Driver ၂ ဦး ခေါက်ရေနှင့် စရိတ်ရှင်းတမ်း", itemSize, context),
            _buildItem("🧮 (၅.၄) အသားတင် အမြတ်/အရှုံးချုပ် (Net P&L)", itemSize, context),
          ]),
        ],
      ),
    );
  }

  Widget _buildFolder(String title, IconData icon, double fontSize, Color textColor, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.amber, size: 20),
      title: Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor)),
      initiallyExpanded: true,
      iconColor: Colors.amber,
      collapsedIconColor: isLightMode ? Colors.black54 : Colors.white60,
      children: children,
    );
  }

  Widget _buildItem(String title, double fontSize, BuildContext context) {
    bool isSelected = activeMenu == title;
    Color normalItemColor = isLightMode ? const Color(0xFF475569) : Colors.white70;

    return ListTile(
      dense: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          title, 
          style: TextStyle(
            color: isSelected ? Colors.amber : normalItemColor, 
            fontSize: fontSize, 
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
          ),
        ),
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
