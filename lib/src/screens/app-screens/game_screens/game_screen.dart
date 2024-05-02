import 'package:atoz_app/game/atoz_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Flame.device.fullScreen();
    Flame.device.setPortrait();
    AtozGame game = AtozGame();

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(child: GameWidget(game: kDebugMode ? AtozGame() : game)),
          Container(
            height: screenHeight * 0.4,
            color: Colors.black,
          )
        ],
      ),
    ));
  }
}
