import 'package:flutter/material.dart';
import 'developer.dart'; // Import DeveloperScreen file
import 'settings.dart';  // Import SettingsScreen file
import 'start.dart'; // Import StartGameScreen file

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFD2691E),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF8B4513),
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Game Mencocokkan Nama Hewan',
                  style: TextStyle(
                    color: Color(0xFFFFCC00),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              // Button for Starting the Game
              GameButton(
                text: 'Mulai Game',
                onPressed: () {
                  // Debug print statement to verify if button is pressed
                  print('Navigating to StartGameScreen');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StartGameScreen(),
                    ),
                  );
                },
              ),
              GameButton(
                text: 'Pengembang',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeveloperScreen()),
                  );
                },
              ),
              GameButton(
                text: 'Pengaturan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
              GameButton(
                text: 'Keluar Game',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GameButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFD2691E),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          shadowColor: Color(0xFF8B4513),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFFFFCC00),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}