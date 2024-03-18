import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum UserStatus {
  active,
  away,
  doNotDisturb,
}

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  bool isSearchBarExtended = false;
  UserStatus userStatus = UserStatus.active;

  @override
  Widget build(BuildContext context) {
    String profileImagePath = context.watch<UserProvider>().profileImagePath;
    String userFullName = context.watch<UserProvider>().userFullName;

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(context: context),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                // gradient
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueAccent.shade400,
                    Colors.blueAccent.shade100
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    buildSearchBar(context),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // avatar
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                            'assets/images/avatar/$profileImagePath.jpeg'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userFullName,
                              style: TextStyle(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: userStatus == UserStatus.active
                                      ? Colors.greenAccent
                                      : userStatus == UserStatus.away
                                          ? Colors.orange
                                          : Colors.red,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  userStatus == UserStatus.active
                                      ? 'Active now'
                                      : userStatus == UserStatus.away
                                          ? 'Away'
                                          : 'Do not disturb',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    showPopUpMenu(
                                        context, details.globalPosition);
                                  },
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 80, right: 80),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40,
            width: isSearchBarExtended
                ? MediaQuery.of(context).size.width * 0.8
                : 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearchBarExtended = !isSearchBarExtended;
                });
              },
            ),
          ),
          Positioned(
            top: 5,
            left: 50,
            right: 20,
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Search for friends',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showPopUpMenu(
      BuildContext context, Offset globalPosition) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;

    await showMenu(
      elevation: 0,
      shadowColor: Colors.transparent,
      color: Colors.white.withOpacity(0.8),
      //add your color
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.greenAccent,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Active now",
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
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Away",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 40),
            child: Row(
              children: const [
                Icon(
                  Icons.circle,
                  color: Colors.red,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Do not disturb",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      setState(() {
        if (value == 1) {
          userStatus = UserStatus.active;
        } else if (value == 2) {
          userStatus = UserStatus.away;
        } else if (value == 3) {
          userStatus = UserStatus.doNotDisturb;
        }
      });
    });
  }
}

class CustomClipPath extends CustomClipper<Path> {
  CustomClipPath({required this.context});

  final BuildContext context;

  @override
  Path getClip(Size size) {
    // print(size);
    // double w = size.width;
    // double h = size.height;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final path = Path();

    // path.moveTo(0, 0);
    // path.lineTo(w * 0.5, h * 0.0);
    // path.lineTo(w * 0.85, h * 0.12);
    // path.lineTo(w, h * 0.12);

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.2);
    path.lineTo(w, h * 0.2);
    // path.quadraticBezierTo(w * 0.1, h * 0.12, w * 0.5, h * 0.08);
    // path.quadraticBezierTo(w * 0.8, h * 0.05, w, h * 0.11);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
