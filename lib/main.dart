  Widget _buildKyawThetNaingLedger() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2C),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black54, offset: Offset(4, 4), blurRadius: 6),
              ]
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("စုစုပေါင်း ကားခ", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    SizedBox(height: 4),
                    Text("၅၀၀,၀၀၀ ကျပ်", style: TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold))
                  ]
                ),
                Column(
                  children: [
                    Text("အသားတင် အမြတ်", style: TextStyle(color: Colors.grey, fontSize: 11)),
                    SizedBox(height: 4),
                    Text("၃၂၀,၀၀၀ ကျပ်", style: TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold))
                  ]
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text("🚜 ခေါက်ရေနှင့် ကားခထည့်သွင်းရန် (Numeric Inputs)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFD700))),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildNumInput("မနက်ခေါက်", _morningCtrl)),
              const SizedBox(width: 8),
              Expanded(child: _buildNumInput("နေ့လည်ခေါက်", _afternoonCtrl)),
              const SizedBox(width: 8),
              Expanded(child: _buildNumInput("ညခေါက်", _eveningCtrl)),
            ],
          ),
          _buildNumInput("တစ်စီးချင်းကားခ (Fare)", _rateCtrl),
          _buildNumInput("ဆီဖိုး နှုတ်ရန် (-)", _fuelCtrl),
          const SizedBox(height: 12),
          const Text("🧮 ဒရိုင်ဘာ မောင်းကြေး တွက်ချက်မှု စနစ် ရွေးချယ်ရန်", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFD700))),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(6)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _driverOption,
                isExpanded: true,
                dropdownColor: const Color(0xFF1E1E2C),
                items: const [
                  DropdownMenuItem(value: 1, child: Text("Option 1: (ကားခ - ဆီဖိုး) ၏ ရာခိုင်နှုန်း %", style: TextStyle(fontSize: 12))),
                  DropdownMenuItem(value: 2, child: Text("Option 2: စိတ်ကြိုက် ရာခိုင်နှုန်း သတ်မှတ်ရန်", style: TextStyle(fontSize: 12))),
                  DropdownMenuItem(value: 3, child: Text("Option 3: တစ်ခေါက်ချင်း အပြတ်ပေးစနစ်", style: TextStyle(fontSize: 12))),
                ],
                onChanged: (val) { 
                  setState(() { _driverOption = val!; }); 
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (_driverOption == 2) _buildNumInput("စိတ်ကြိုက် ရာခိုင်နှုန်း ထည့်ရန် (%)", _customPercentCtrl),
          if (_driverOption == 2) const SizedBox(height: 8),
          const Text("📊 ကားပိုင်ရှင်အလိုက် တစ်စီးချင်း ကားခစာရင်း (Tree Table)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 5),
          Card(
            color: const Color(0xFF1E1E2C),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ExpansionTile(
              title: const Text("ဦးဖြူ စာရင်းချုပ် ([▼] နှိပ်၍ ဖြန့်ချရန်)", style: TextStyle(color: Colors.greenAccent, fontSize: 13)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.white12),
                    children: const [
                      TableRow(
                        decoration: BoxDecoration(color: Color(0xFF121212)),
                        children: [
                          Padding(padding: EdgeInsets.all(6), child: Text("ကားနံပါတ်", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("ကားခ (Fare)", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("ရရန်ကျန်ငွေ", style: TextStyle(fontSize: 11)))
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(padding: EdgeInsets.all(6), child: Text("YTN-1111", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၅၀၀,၀၀၀", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၃၂၀,၀၀၀", style: TextStyle(fontSize: 11, color: Colors.greenAccent)))
                        ]
                      ),
                      TableRow(
                        children: [
                          Padding(padding: EdgeInsets.all(6), child: Text("YTN-2222", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၄၅၀,၀၀၀", style: TextStyle(fontSize: 11))),
                          Padding(padding: EdgeInsets.all(6), child: Text("၂၈၀,၀၀၀", style: TextStyle(fontSize: 11, color: Colors.greenAccent)))
                        ]
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 11, color: Colors.white60),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFFFD700))),
        ),
        onChanged: (val) => setState(() {}),
      ),
    );
  }
}

