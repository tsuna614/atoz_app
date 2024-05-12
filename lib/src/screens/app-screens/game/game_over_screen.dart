import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameOverScreen extends StatefulWidget {
  final int score;
  const GameOverScreen({super.key, required this.score});

  @override
  State<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.score == 0)
              Text('Game Over!')
            else
              Text('Congratulations!'),
            Text('Score: ${widget.score}'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Flame.device.setPortrait();
              },
              child: const Text('Back to Main Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
