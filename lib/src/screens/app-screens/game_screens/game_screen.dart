import 'package:atoz_app/game/atoz_game.dart';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  final void Function(int score) switchScreen;
  const GameScreen({
    super.key,
    required this.switchScreen,
  });

  void _switchScreen(int score) {
    switchScreen(score);
  }

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    Flame.device.setLandscape();

    List<FishingQuestion> fishingQuests =
        context.read<QuestionProvider>().fishingQuests;

    AtozGame game = AtozGame(
      question: fishingQuests[0],
      totalTime: 90,
      switchScreen: _switchScreen,
    );

    // double screenHeight = MediaQuery.of(context).size.height;

    // return GameWidget(game: game);
    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
