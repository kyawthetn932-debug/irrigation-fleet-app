import 'package:flutter/material.dart';

void main() {
  runApp(const IrrigationFleetApp());
}

class IrrigationFleetApp extends StatelessWidget {
  const IrrigationFleetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irrigation Fleet & POS System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121824), // Slate Dark Background
      ),
      home: const MainFleetNavigationScreen(),
    );
  }
}

class MainFleetNavigationScreen extends StatefulWidget {
  const MainFleetNavigationScreen({super.key});

  @override
  State<MainFleetNavigationScreen> createState() => _MainFleetNavigationScreenState();
}

class _MainFleetNavigationScreenState extends State<MainFleetNavigationScreen> {
  String _currentScreenTitle = "👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း (၅)";
  bool _isLightMode = false;

  // ==========================================
  // SPREADSHEET SAMPLE DATA LISTS
  // ==========================================
  final List<Map<String, String>> _kyawThetNaingRecords = [
    {"date": "05/10/2026", "morn": "4", "noon": "4", "night": "4", "rate": "50000", "total": "600000", "repair": "0", "net": "320000"},
    {"date": "06/10/2026", "morn": "5", "noon": "5", "night": "2", "rate": "50000", "total": "600000", "repair": "50000", "net": "350000"}
  ];

  void _editCell(List<Map<String, String>> currentList, int rowIndex, String key, String columnName, double dialogFontSize) {
    TextEditingController editCtrl = TextEditingController(text: currentList[rowIndex][key]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F293D),
        title: Text("$columnName ကွက်ကို ပြင်ဆင်ရန်", style: TextStyle(color: Colors.amber, fontSize: dialogFontSize + 2)),
        content: TextField(
          controller: editCtrl,
          style: TextStyle(color: Colors.white, fontSize: dialogFontSize),
          decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber))),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("ပယ်ဖျက်", style: TextStyle(color: Colors.white54, fontSize: dialogFontSize - 2))),
          TextButton(
            onPressed: () {
              setState(() {
                currentList[rowIndex][key] = editCtrl.text;
              });
              Navigator.pop(context);
            },
            child: Text("ပြင်ဆင်မည်", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: dialogFontSize - 2)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 760; // Tablet & PC ခွဲခြားသည့် သတ်မှတ်ချက်

    // ==========================================
    // 📱 ဖုန်းနှင့် 💻 TABLET အလိုက် FONT SIZE များ သတ်မှတ်ခြင်း (RESPONSIVE TYPOGRAPHY)
    // ==========================================
    double titleFontSize = isLargeScreen ? 22.0 : 16.0;   // App Bar နှင့် ခေါင်းစဉ်ကြီးများအတွက်
    double menuHeaderFontSize = isLargeScreen ? 16.0 : 13.0; // Sidebar တွဲဖက် Folder ခေါင်းစဉ်အတွက်
    double menuItemFontSize = isLargeScreen ? 15.0 : 12.0;   // Menu တစ်ခုချင်းစီအတွက်
    double tableHeaderFontSize = isLargeScreen ? 14.0 : 11.0; // ဇယားခေါင်းစဉ်များအတွက်
    double tableCellFontSize = isLargeScreen ? 14.0 : 12.0;   // ဇယားတွင်း စာသား/ဂဏန်းများအတွက်

    return Scaffold(
      backgroundColor: _isLightMode ? const Color(0xFFF4F6F9) : const Color(0xFF121824),
      appBar: AppBar(
        title: Text(_currentScreenTitle, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: titleFontSize)),
        backgroundColor: _isLightMode ? Colors.white : const Color(0xFF1A2333),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isLightMode ? Icons.dark_mode : Icons.light_mode, color: Colors.amber),
            onPressed: () => setState(() => _isLightMode = !_isLightMode),
          ),
        ],
        leading: !isLargeScreen
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.amber),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : const Icon(Icons.local_shipping, color: Colors.amber),
      ),
      drawer: !isLargeScreen ? Drawer(child: _buildTreeMenu(context, isDrawer: true, folderSize: menuHeaderFontSize, itemSize: menuItemFontSize)) : null,
      body: Row(
        children: [
          if (isLargeScreen)
            SizedBox(
              width: screenWidth * 0.20, // ၂၀% Sidebar Menu
              child: Container(
                decoration: BoxDecoration(
                  color: _isLightMode ? Colors.white.withOpacity(0.9) : const Color(0xFF1A2333).withOpacity(0.9),
                  border: const Border(right: BorderSide(color: Colors.white12)),
                ),
                child: _buildTreeMenu(context, isDrawer: false, folderSize: menuHeaderFontSize, itemSize: menuItemFontSize),
              ),
            ),
          
          // ၈၀% Spreadsheet View
          Expanded(
            child: Container(
              width: isLargeScreen ? screenWidth * 0.80 : screenWidth,
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: _isLightMode ? Colors.white : const Color(0xFF1A2333),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildSheetStructure(
                    headers: ["ရက်စွဲ", "မနက်", "နေ့လည်", "ည", "ကားခနှုန်း", "စုစုပေါင်း", "ပြင်ဆင်စရိတ်", "အသားတင်မြတ်"],
                    keys: ["date", "morn", "noon", "night", "rate", "total", "repair", "net"],
                    dataList: _kyawThetNaingRecords,
                    headerSize: tableHeaderFontSize,
                    cellSize: tableCellFontSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TREE SIDEBAR MENU WIDGET
  // ==========================================
  Widget _buildTreeMenu(BuildContext context, {required bool isDrawer, required double folderSize, required double itemSize}) {
    return Container(
      color: isDrawer ? Colors.white.withOpacity(0.85) : Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF243147)),
            child: Center(
              child: Text(
                "ဆည်မြောင်း\nကားစာရင်း Ledger", 
                style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _buildFolder(
            title: "၄။ ကားပိုင်ရှင် သီးသန့်စာရင်း",
            icon: Icons.person,
            fontSize: folderSize,
            children: [
              _buildItem("👤 ကားပိုင်ရှင်တစ်ဦးချင်း သီးသန့်စာရင်း (4)", isDrawer, itemSize),
              _buildItem("👑 ကိုကျော်သက်နိုင် သီးသန့် ကားစာရင်း (၅)", isDrawer, itemSize),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFolder({required String title, required IconData icon, required double fontSize, required List<Widget> children}) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.amber, size: 20),
      title: Text(title, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
      initiallyExpanded: true,
      children: children,
    );
  }

  Widget _buildItem(String title, bool isDrawer, double fontSize) {
    bool isSelected = _currentScreenTitle == title;
    return ListTile(
      dense: true,
      title: Padding(
        padding: const EdgeInsets.left(12.0),
        child: Text(title, style: TextStyle(color: isSelected ? Colors.amber : Colors.white, fontSize: fontSize, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ),
      selected: isSelected,
      selectedTileColor: Colors.amber.withOpacity(0.15),
      onTap: () {
        setState(() {
          _currentScreenTitle = title;
        });
        if (isDrawer) Navigator.pop(context);
      },
    );
  }

  // ==========================================
  // RESPONSIVE SPREADSHEET WIDGET
  // ==========================================
  Widget _buildSheetStructure({
    required List<String> headers,
    required List<String> keys,
    required List<Map<String, String>> dataList,
    required double headerSize,
    required double cellSize,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white12)),
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(110), // ကော်လံတစ်ကွက်ချင်းစီ၏ အကျယ်
            border: TableBorder.all(color: Colors.white12, width: 1),
            children: [
              // Header Row
              TableRow(
                decoration: const BoxDecoration(color: Color(0xFF243147)),
                children: headers.map((header) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(header, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: headerSize)),
                  );
                }).toList(),
              ),
              // Data Rows
