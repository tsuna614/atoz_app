import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/profile-screen/spectate_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dio/dio.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;
import 'package:provider/provider.dart';

final dio = Dio();

class LeaderboardScreen extends StatefulWidget {
  LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  var userData;

  void arrangeUserData() {
    // // rearrange the userData array from highest score to lowest score
    userData.sort((b, a) {
      int aScore = a['score'];
      int bScore = b['score'];
      return aScore.compareTo(bScore);
    });
  }

  void getAllUsers() async {
    Response response = await dio.get('${globals.atozApi}/user/getAllUsers');
    setState(() {
      userData = response.data;
      arrangeUserData();
    });
  }

  Future<bool> checkForExistingRequest(String friendId) async {
    String userId = Provider.of<UserProvider>(context, listen: false).userId;
    bool isExisting = false;
    await FirebaseFirestore.instance
        .collection('notifications')
        .where('sender', isEqualTo: userId)
        .where('receiver', isEqualTo: friendId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        isExisting = true;
      }
    });
    return isExisting;
  }

  void cancelFriendRequest(String friendId) {
    String userId = Provider.of<UserProvider>(context, listen: false).userId;

    FirebaseFirestore.instance
        .collection('notifications')
        .where('sender', isEqualTo: userId)
        .where('receiver', isEqualTo: friendId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('notifications')
            .doc(element.id)
            .delete();
      });
    });
  }

  void addFriend(String friendId) {
    String userId = Provider.of<UserProvider>(context, listen: false).userId;

    FirebaseFirestore.instance.collection('notifications').add({
      'sender': userId,
      'receiver': friendId,
      'timeCreated': DateTime.now(),
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 350.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                // border:
                // only bottom border
                // border: Border(
                //   bottom: BorderSide(
                //     color: Colors.grey.shade300,
                //     width: 1.0,
                //   ),
                // ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  userData == null
                      ? Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      : buildTopPlayerCard(context),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            userData == null
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: userData == null ? 0 : userData.length,
                      itemBuilder: (context, index) {
                        return buildPlayerTitleCard(context, index);
                      },
                    ),
                  ),
          ],
        ),
        ClipPath(
          clipper: CustomClipPathLightBlue(context: context),
          child: Container(
            // gradient
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.lightBlue.shade600,
                  Colors.lightBlue.shade400,
                ],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: CustomClipPathBlue(context: context),
          child: Container(
            // gradient
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blue.shade800,
                  Colors.blue.shade900,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTopPlayerCard(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 100,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 16, 101, 171),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                      height: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              userData[1]['firstName'],
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            userData[1]['score'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      height: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.crown,
                            color: Colors.yellow,
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              userData[0]['firstName'],
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            userData[0]['score'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                userData[2]['firstName'],
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              userData[2]['score'].toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 0,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: userData[1]
                                    .toString()
                                    .contains('profileImage')
                                ? Image.asset(
                                        'assets/images/avatar/${userData[1]['profileImage']}.jpeg')
                                    .image
                                : AssetImage(
                                    "assets/images/profile.jpg",
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: userData[0]
                                    .toString()
                                    .contains('profileImage')
                                ? Image.asset(
                                        'assets/images/avatar/${userData[0]['profileImage']}.jpeg')
                                    .image
                                : AssetImage(
                                    "assets/images/profile.jpg",
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage: userData[2]
                                    .toString()
                                    .contains('profileImage')
                                ? Image.asset(
                                        'assets/images/avatar/${userData[2]['profileImage']}.jpeg')
                                    .image
                                : AssetImage(
                                    "assets/images/profile.jpg",
                                  ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    // Text(
                    //   'Khanh',
                    //   style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w800,
                    //       color: Colors.white),
                    // ),
                    // Text(
                    //   '2190',
                    //   style: TextStyle(
                    //       fontSize: 26,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white),
                    // )
                  ],
                ),
                SizedBox(
                  width: 0,
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Future<void> showPopUpMenu(
      BuildContext context, Offset globalPosition, int userIndex) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;
    String currentUserId =
        Provider.of<UserProvider>(context, listen: false).userId;

    bool isFriendRequestExisted =
        await checkForExistingRequest(userData[userIndex]['userId']);

    if (context.mounted) {
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
                children: const [
                  Icon(FontAwesomeIcons.circleUser),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "View profile",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            enabled:
                userData[userIndex]['userId'] == currentUserId ? false : true,
            value: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 40),
              child: Row(
                children: [
                  isFriendRequestExisted
                      ? Icon(Icons.person_remove_alt_1_outlined)
                      : Icon(Icons.person_add_alt_1_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    isFriendRequestExisted
                        ? "Cancel request"
                        : "Send friend request",
                    style: TextStyle(
                        color: userData[userIndex]['userId'] == currentUserId
                            ? Colors.grey
                            : Colors.black),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            enabled:
                userData[userIndex]['userId'] == currentUserId ? false : true,
            value: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 40),
              child: Row(
                children: [
                  Icon(Icons.message),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Message",
                    style: TextStyle(
                        color: userData[userIndex]['userId'] == currentUserId
                            ? Colors.grey
                            : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
        elevation: 8.0,
      ).then((value) {
        if (value == 1) {
          // VIEWING PROFILE
          showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            // backgroundColor: Colors.transparent,
            builder: (context) => AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: MediaQuery.of(context).size.height * 1,
              child: Stack(
                children: [
                  SpectateProfile(
                    userId: userData[userIndex]['userId'],
                    isDirectedFromLeaderboard: true,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (value == 2) {
          // SENDING FRIEND REQUEST / CANCELLING FRIEND REQUEST
          if (isFriendRequestExisted) {
            cancelFriendRequest(userData[userIndex]['userId']);
          } else
            addFriend(userData[userIndex]['userId']);
        }
      });
    }
  }

  Widget buildPlayerTitleCard(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onLongPressEnd: (LongPressEndDetails details) {
          showPopUpMenu(context, details.globalPosition, index);
        },
        child: ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: userData[index]
                                  .toString()
                                  .contains('profileImage')
                              ? Image.asset(
                                      'assets/images/avatar/${userData[index]['profileImage']}.jpeg')
                                  .image
                              : AssetImage(
                                  "assets/images/profile.jpg",
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      userData[index]['firstName'] +
                          ' ' +
                          userData[index]['lastName'],
                      style: TextStyle(
                        // fontSize: 16,
                        color: userData[index]['userId'] ==
                                context.watch<UserProvider>().userId
                            ? Colors.black
                            : Colors.grey.shade800,
                        fontWeight: userData[index]['userId'] ==
                                context.watch<UserProvider>().userId
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    userData[index]['score'].toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // trailing: Text(
      //   '2190',
      //   style: TextStyle(
      //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      // ),
    );
  }
}

//////////////// THIS IS THE DECORATION ON THE TOP OF THE SCREEN ////////////////

class CustomClipPathBlue extends CustomClipper<Path> {
  CustomClipPathBlue({required this.context});

  final BuildContext context;

  @override
  Path getClip(Size size) {
    // print(size);
    // double w = size.width;
    // double h = size.height;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.12);
    // create a s shaped line to x = w, y = h * 0.2
    path.quadraticBezierTo(w * 0.4, h * 0.15, w * 0.7, h * 0.12);
    path.quadraticBezierTo(w * 0.9, h * 0.1, w, h * 0.1);
    // path.quadraticBezierTo(w * 0.5, h * 0.2, w, h * 0.3);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPathLightBlue extends CustomClipper<Path> {
  CustomClipPathLightBlue({required this.context});

  final BuildContext context;

  @override
  Path getClip(Size size) {
    // print(size);
    // double w = size.width;
    // double h = size.height;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.15);
    // create a s shaped line to x = w, y = h * 0.2
    path.quadraticBezierTo(w * 0.3, h * 0.12, w * 0.6, h * 0.15);
    path.quadraticBezierTo(w * 0.9, h * 0.18, w, h * 0.14);
    // path.quadraticBezierTo(w * 0.5, h * 0.2, w, h * 0.3);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
