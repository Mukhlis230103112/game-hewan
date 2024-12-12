import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _volume = 0.5; // Initial volume level

  void _increaseVolume() {
    setState(() {
      if (_volume < 1.0) {
        _volume += 0.1;
      }
    });
  }

  void _decreaseVolume() {
    setState(() {
      if (_volume > 0.0) {
        _volume -= 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header container
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFD2691E),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8B4513),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                'Pengaturan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFCC00),
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Main box container
            Container(
              width: 300,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFD2691E),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF8B4513),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Volume',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFFCC00),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Volume control row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Color(0xFFFFCC00)),
                        onPressed: _decreaseVolume,
                      ),
                      Expanded(
                        child: Slider(
                          value: _volume,
                          onChanged: (value) {
                            setState(() {
                              _volume = value;
                            });
                          },
                          activeColor: Color(0xFFFFCC00),
                          inactiveColor: Color(0xFF8B4513),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Color(0xFFFFCC00)),
                        onPressed: _increaseVolume,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Footer button
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Color(0xFFD2691E),
                side: BorderSide(color: Color(0xFF8B4513)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Lanjut',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFCC00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
