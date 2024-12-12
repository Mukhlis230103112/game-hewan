import 'package:flutter/material.dart';
import 'lobby.dart'; // Import GameScreen to navigate back

class DeveloperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    blurRadius: 4,
                  ),
                ],
              ),
              width: 300,
              child: Column(
                children: [
                  Text(
                    'Game Developer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFCC00),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '------------------------\n'
                    'Mukhlis\n'
                    'Fajar\n'
                    '------------------------',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // Navigate back to GameScreen (Lobby) when "Lanjut" is pressed
                Navigator.pop(context); // Pops DeveloperScreen and returns to GameScreen
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Color(0xFFD2691E),
                side: BorderSide(color: Color(0xFF8B4513)),
              ),
              child: Text(
                'Lanjut',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFCC00),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GameScreen(), // Start from GameScreen (Lobby)
  ));
}