// import 'package:atoz_app/game/pixel_adventure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void test() {
    FirebaseFirestore.instance.collection('users').add({
      'username': 'user1',
      'email': 'abc',
    });
  }

  void setUp() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: test,
              child: const Text('Add user'),
            ),
            getUsers(context),
          ],
        ));
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
