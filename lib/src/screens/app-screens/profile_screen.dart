import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            height: 75.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _firebase.signOut();
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }
}
