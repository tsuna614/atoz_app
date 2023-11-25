import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            height: 50.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          // Center(
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          //     onPressed: () {
          //       _firebase.signOut();
          //     },
          //     child: const Text(
          //       'Log Out',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(50),
                    child: Image.asset('assets/images/pfp.jpeg',
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Nguyen Quoc Khanh',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Student',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ProfileNumberWidget(number: 0, title: 'Friends'),
                    ProfileNumberWidget(number: 0, title: 'Follower'),
                    ProfileNumberWidget(number: 0, title: 'Following'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                        ),
                        Row(
                          children: [],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size.fromHeight(40)),
                          onPressed: () {
                            _firebase.signOut();
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileNumberWidget extends StatelessWidget {
  const ProfileNumberWidget(
      {super.key, required this.number, required this.title});

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
