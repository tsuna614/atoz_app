import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firebase = FirebaseAuth.instance;

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.switchScreen});

  final void Function(int index) switchScreen;

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color.fromARGB(255, 60, 151, 255),
              Color.fromARGB(255, 56, 135, 208),
              Color.fromARGB(255, 0, 13, 150),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'AToz',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 40,
                  letterSpacing: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  buildAnimatedButton(context, 0),
                  SizedBox(
                    height: 40,
                  ),
                  buildAnimatedButton(context, 1),
                  SizedBox(
                    height: 40,
                  ),
                  buildAnimatedButton(context, 2),
                  SizedBox(
                    height: 40,
                  ),
                  buildAnimatedButton(context, 3),
                  SizedBox(
                    height: 40,
                  ),
                  buildAnimatedButton(context, 4),
                ],
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  _dialogBuilder(context);
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        letterSpacing: 4,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedButton(BuildContext context, int itemIndex) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      padding: EdgeInsets.only(
        left: _selectedIndex == itemIndex ? 20 : 0,
      ),
      height: _selectedIndex == itemIndex ? 60 : 50,
      decoration: BoxDecoration(
        color: _selectedIndex == itemIndex
            ? Colors.white.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = itemIndex;
            widget.switchScreen(itemIndex);
          });
        },
        child: Row(
          children: [
            Icon(
              itemIndex == 0
                  ? FontAwesomeIcons.house
                  : itemIndex == 1
                      ? FontAwesomeIcons.userLarge
                      : itemIndex == 2
                          ? FontAwesomeIcons.users
                          : itemIndex == 3
                              ? FontAwesomeIcons.medal
                              : FontAwesomeIcons.gear,
              color: Colors.white,
              size: 16,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              itemIndex == 0
                  ? 'Home'
                  : itemIndex == 1
                      ? 'Profile'
                      : itemIndex == 2
                          ? 'Social'
                          : itemIndex == 3
                              ? 'Leaderboard'
                              : 'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout?'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                _firebase.signOut();
              },
            ),
          ],
        );
      },
    );
  }
}
