import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  final void Function(int score) switchScreen;
  const GameScreen({
    super.key,
    required this.switchScreen,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<FishingQuestion> fishingQuests;
  late AtozGame game;

  bool isPaused = false;

  @override
  void initState() {
    fishingQuests = context.read<QuestionProvider>().fishingQuests;
    game = AtozGame(
      question: fishingQuests[1],
      totalTime: 180,
      switchScreen: _switchScreen,
      setPauseGame: () {
        setState(() {
          isPaused = true;
        });
      },
    );
    super.initState();
  }

  void _switchScreen(int score) {
    widget.switchScreen(score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GameWidget(game: game),
          if (isPaused) _buildPauseMenu(context),
        ],
      ),
    );
  }

  Widget _buildPauseMenu(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isPaused = false;
                    game.pauseGame();
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20.0),
                ),
                child: Text(
                  'RESUME',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  game.triggerGameOver(true);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 20.0),
                ),
                child: Text(
                  'BACK TO MENU',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
