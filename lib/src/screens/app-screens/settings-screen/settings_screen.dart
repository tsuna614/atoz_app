// import 'package:atoz_app/game/pixel_adventure.dart';
// import 'package:atoz_app/game/atoz_game.dart';
// import 'package:flame/game.dart';
import 'package:atoz_app/src/screens/app-screens/game_screens/game_over_screen.dart';
import 'package:atoz_app/src/screens/app-screens/game_screens/game_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _switchScreen(int score) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GameOverScreen(score: score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // AtozGame game = AtozGame(
    //   question: "Hello adventurer",
    //   totalTime: 90,
    //   switchScreen: (int score) {},
    // );
    // return Scaffold(body: GameWidget(game: game));
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GameScreen(
                  switchScreen: _switchScreen,
                ),
              ),
            );
          },
          child: const Text('Test'),
        ),
      ),
    );
  }
}
