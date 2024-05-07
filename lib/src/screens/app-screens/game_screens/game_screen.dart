import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    Flame.device.setPortrait();
    AtozGame game = AtozGame(question: "Hello adventurer");

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(child: GameWidget(game: game)),
          Container(
            height: screenHeight * 0.4,
            color: Colors.black,
          )
        ],
      ),
    ));
  }
}
