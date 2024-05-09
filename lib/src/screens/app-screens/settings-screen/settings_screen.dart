// import 'package:atoz_app/game/pixel_adventure.dart';
// import 'package:atoz_app/game/atoz_game.dart';
// import 'package:flame/game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void test() {
    FirebaseFirestore.instance.collection('users').add({
      'username': 'user1',
      'email': 'abc',
    });
  }

  void setUp() async {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
  }

  @override
  void initState() {
    setUp();
    super.initState();
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
        child: Text("Settings Screen"),
      ),
    );
  }
}
