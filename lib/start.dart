import 'dart:async';
import 'package:flutter/material.dart';

class StartGameScreen extends StatefulWidget {
  @override
  _StartGameScreenState createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  Map<String, String> correctAnswers = {
    'Gambar 1': 'Harimau',
    'Gambar 2': 'Kuda Nil',
  };
  Map<String, bool> isAnsweredCorrectly = {
    'Gambar 1': false,
    'Gambar 2': false,
  };
  int currentScore = 0;
  int remainingTime = 60;
  int lives = 5;
  bool isPaused = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isPaused && remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else if (remainingTime == 0) {
        reduceLife();
      }
    });
  }

  void reduceLife() {
    if (lives > 1) {
      setState(() {
        lives--;
        remainingTime = 60; // Reset the timer after losing a life
      });
    } else {
      setState(() {
        lives = 0;
        timer?.cancel();
      });
      showGameOverDialog();
    }
  }

  void updateScore() {
    setState(() {
      currentScore += 10; // Add 10 points for each correct answer
    });
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

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Nyawa habis, permainan selesai.'),
            SizedBox(height: 16),
            Text(
              'Score Akhir: $currentScore',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                currentScore = 0;
                lives = 5;
                remainingTime = 60;
                isAnsweredCorrectly = {
                  'Gambar 1': false,
                  'Gambar 2': false,
                };
              });
              Navigator.of(context).pop();
            },
            child: Text('Main Lagi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 150, 32),
        title: Text('Mulai Game', style: TextStyle(color: Colors.black)),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final maxHeight = constraints.maxHeight;
              final isWide = maxWidth > 600;

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF32CD32), Color(0xFFFFFF00)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.all(isWide ? 32.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GameInfoBox(
                            title: 'Level 1',
                            width: isWide ? 150 : 80,
                          ),
                          GameInfoBox(
                            title: 'Waktu: ${remainingTime}s',
                            width: isWide ? 150 : 80,
                          ),
                          GameInfoBox(
                            title: 'Score: $currentScore',
                            width: isWide ? 150 : 80,
                          ),
                          GameInfoBoxWithLives(
                            lives: lives,
                            width: isWide ? 150 : 80,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: maxHeight * 0.05),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: isWide ? maxWidth * 0.25 : maxWidth * 0.35,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DraggableGameOption(
                                  text: 'Harimau',
                                  width: isWide ? maxWidth * 0.2 : maxWidth * 0.3,
                                ),
                                SizedBox(height: 20),
                                DraggableGameOption(
                                  text: 'Singa',
                                  width: isWide ? maxWidth * 0.2 : maxWidth * 0.3,
                                ),
                                SizedBox(height: 20),
                                DraggableGameOption(
                                  text: 'Kuda Nil',
                                  width: isWide ? maxWidth * 0.2 : maxWidth * 0.3,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DragTargetGameImageBox(
                                  label: 'Gambar 1',
                                  description: isAnsweredCorrectly['Gambar 1'] == true ? 'Harimau' : 'Deskripsi',
                                  onAccepted: (String answer) {
                                    if (answer == correctAnswers['Gambar 1'] && !isAnsweredCorrectly['Gambar 1']!) {
                                      setState(() {
                                        isAnsweredCorrectly['Gambar 1'] = true;
                                        updateScore();
                                      });
                                    }
                                  },
                                  isCorrect: isAnsweredCorrectly['Gambar 1'] ?? false,
                                  size: isWide ? maxWidth * 0.25 : maxWidth * 0.25,
                                ),
                                DragTargetGameImageBox(
                                  label: 'Gambar 2',
                                  description: isAnsweredCorrectly['Gambar 2'] == true ? 'Kuda Nil' : 'Deskripsi',
                                  onAccepted: (String answer) {
                                    if (answer == correctAnswers['Gambar 2'] && !isAnsweredCorrectly['Gambar 2']!) {
                                      setState(() {
                                        isAnsweredCorrectly['Gambar 2'] = true;
                                        updateScore();
                                      });
                                    }
                                  },
                                  isCorrect: isAnsweredCorrectly['Gambar 2'] ?? false,
                                  size: isWide ? maxWidth * 0.25 : maxWidth * 0.25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.pause),
              onPressed: togglePause,
              iconSize: 40,
              color: Colors.white,
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
                child: Text('Resume'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onExit,
                child: Text('Exit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameInfoBox extends StatelessWidget {
  final String title;
  final double width;

  GameInfoBox({required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class GameInfoBoxWithLives extends StatelessWidget {
  final int lives;
  final double width;

  GameInfoBoxWithLives({required this.lives, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return Icon(
            index < lives ? Icons.favorite : Icons.favorite_border,
            color: index < lives ? Colors.red : Colors.grey,
          );
        }),
      ),
    );
  }
}

class DraggableGameOption extends StatelessWidget {
  final String text;
  final double width;

  DraggableGameOption({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: text,
      child: GameOption(text: text, width: width),
      feedback: GameOption(text: text, width: width),
      childWhenDragging: GameOption(text: text, width: width),
    );
  }
}

class GameOption extends StatelessWidget {
  final String text;
  final double width;

  GameOption({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DragTargetGameImageBox extends StatelessWidget {
  final String label;
  final String description;
  final Function(String) onAccepted;
  final bool isCorrect;
  final double size;

  DragTargetGameImageBox({
    required this.label,
    required this.description,
    required this.onAccepted,
    required this.isCorrect,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: onAccepted,
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: size,
          height: size,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCorrect ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              isCorrect ? label : description,
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
