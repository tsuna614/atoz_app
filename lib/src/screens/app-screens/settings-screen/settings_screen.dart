// import 'package:atoz_app/game/pixel_adventure.dart';
import 'package:atoz_app/game/atoz_game.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
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
    AtozGame game = AtozGame(
      question: "Hello adventurer",
      totalTime: 90,
      switchScreen: (int score) {},
    );
    return Scaffold(body: GameWidget(game: game));
  }

  Widget getUsers(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['username']),
              subtitle: Text(data['email']),
            );
          }).toList(),
        );
      },
    );
  }
}
