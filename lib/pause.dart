import 'dart:async';
import 'package:flutter/material.dart';


class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int remainingTime = 60;
  int lives = 5;
  bool isPaused = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused && remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else if (remainingTime == 0) {
        setState(() {
          lives--;
          remainingTime = 60;
        });
        if (lives == 0) {
          // End game if no lives left
          showGameOverDialog();
        }
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Nyawa habis. Skor akhir: 0'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lobby');
              },
              child: Text('Kembali ke Lobby'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        timer?.cancel();
      } else {
        startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game')),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Waktu: $remainingTime detik',
                    style: TextStyle(fontSize: 24)),
                Text('Nyawa: $lives', style: TextStyle(fontSize: 24)),
                ElevatedButton(
                  onPressed: togglePause,
                  child: Text(isPaused ? 'Lanjutkan' : 'Jeda'),
                ),
              ],
            ),
          ),
          if (isPaused)
            PauseOverlay(
              onResume: togglePause,
              onExit: () {
                Navigator.pushNamed(context, '/lobby');
              },
            ),
        ],
      ),
    );
  }
}

class PauseOverlay extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onExit;

  PauseOverlay({required this.onResume, required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 300,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Pause',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onResume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.black),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                ),
                child: Text(
                  'Lanjut',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: onExit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.black),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                ),
                child: Text(
                  'Main Menu',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
