import 'package:flutter/material.dart';

class UserOption extends StatelessWidget {
  const UserOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            showPopUpMenu(context, details.globalPosition);
          },
          child: Container(
            color: Colors.yellow.shade600,
            padding: const EdgeInsets.all(8),
            // Change button text when light changes state.
            child: Text('Press and hold to show the menu'),
          ),
        ),
      ),
    );
  }

  Future<void> showPopUpMenu(
      BuildContext context, Offset globalPosition) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;
    await showMenu(
      color: Colors.white,
      //add your color
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: [
                Icon(Icons.mail_outline),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Menu 1",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: [
                Icon(Icons.vpn_key),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Menu 2",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(Icons.power_settings_new_sharp),
              SizedBox(
                width: 10,
              ),
              Text(
                "Menu 3",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      print(value);
      if (value == 1) {
        //do your task here for menu 1
      }
      if (value == 2) {
        //do your task here for menu 2
      }
      if (value == 3) {
        //do your task here for menu 3
      }
    });
  }
}
