import 'dart:io';

import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/chart/bar_chart.dart';
import 'package:atoz_app/src/screens/app-screens/profile-screen/change_profile_screen.dart';
import 'package:atoz_app/src/widgets/animated_button_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

final dio = Dio();

final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;
  bool hasImage = false;

  request() async {
    Response response;
    response = await dio.get(
        '${global.atozApi}/user/getUserById/${_firebase.currentUser!.uid}');

    if (response.data.toString().contains('profileImage')) {
      hasImage = true;
    }

    setState(() {
      userData = response.data[0];
    });
  }

  @override
  void initState() {
    super.initState();
    request();
  }

  @override
  Widget build(BuildContext context) {
    // print(userData);
    return userData == null
        ? UserProfileLoadingScreen()
        : Scaffold(
            // appBar: AppBar(
            //   title: Text(''),
            //   elevation: 0,
            // ),
            body: Stack(
              children: [
                // THIS IS THE INFO CARD BELOW THE PROFILE
                Align(
                  alignment: Alignment(0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 350,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                ),
                                DetailInfo(
                                  userData: userData,
                                ),
                                Divider(
                                  height: 20,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                StudyingInfo(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(height: 400, child: MyBarChart()),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
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
                        ),
                      ],
                    ),
                  ),
                ),
                // THIS IS THE 2 BACKGROUND CONTAINERS
                Positioned(
                  top: 0,
                  child: Column(
                    children: [
                      // Container(
                      //   height: 50.0,
                      //   decoration: BoxDecoration(
                      //     color: Theme.of(context).primaryColor,
                      //   ),
                      // ),
                      SizedBox(height: 50),
                      Container(
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border:
                          // only bottom border
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ClipPath(
                  clipper: CustomClipPathLightBlue(context: context),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.lightBlue.shade400,
                          Colors.lightBlue.shade100,
                        ],
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CustomClipPathBlue(context: context),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      // gradient
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.blue.shade900,
                          Colors.indigo.shade900,
                        ],
                      ),
                    ),
                  ),
                ),
                // THIS IS THE PROFILE PICTURE AND TITLE/NAME
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            if (hasImage)
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    '${global.atozApi}/user/getProfileImage/${_firebase.currentUser!.uid}'),
                              )
                            else
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        // '${userData['firstName']} ${userData['lastName']}',
                        '${userData["firstName"]} ${userData["lastName"]}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userData["email"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w100),
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
                          // Expanded(
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 20),
                          //     child: AnimatedButton1(
                          //         buttonText: 'Change profile',
                          //         voidFunction: () {}),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                // THIS IS THE PENCIL ICON BUTTON ON THE TOP RIGHT
                Positioned(
                  top: 60,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeProfileScreen(
                            firstName: userData["firstName"],
                            lastName: userData["lastName"],
                            age: userData["age"],
                            emailAddress: userData["email"],
                            userImage: hasImage
                                ? NetworkImage(
                                    '${global.atozApi}/user/getProfileImage/${_firebase.currentUser!.uid}')
                                : null,
                          ),
                        ),
                      ).then((value) {
                        Future.delayed(Duration(seconds: 1), () {
                          request();
                        });
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.pencil,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.8),
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    color: Colors.white,
                    // add shadow to icon
                  ),
                )
              ],
            ),
          );
  }
}

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
    path.lineTo(0, h * 0.1);
    path.quadraticBezierTo(w * 0.3, h * 0.1, w * 0.5, h * 0.12);
    path.quadraticBezierTo(w * 0.88, h * 0.15, w, h * 0.12);
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
    path.lineTo(0, h * 0.14);
    path.quadraticBezierTo(w * 0.2, h * 0.06, w * 0.6, h * 0.14);
    path.quadraticBezierTo(w * 0.8, h * 0.18, w, h * 0.13);
    // path.quadraticBezierTo(w * 0.3, h * 0.05, w, h * 0.2);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
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

class DetailInfo extends StatelessWidget {
  const DetailInfo({super.key, required this.userData});

  final userData;

  @override
  Widget build(BuildContext context) {
    const rowSpacer = TableRow(children: [
      SizedBox(
        height: 8,
      ),
      SizedBox(
        height: 8,
      )
    ]);

    return Padding(
      padding: EdgeInsets.all(12),
      child: Table(
          // border: TableBorder(
          //   top: BorderSide(),
          //   bottom: BorderSide(),
          //   left: BorderSide(),
          //   right: BorderSide(),
          //   horizontalInside: BorderSide(),
          //   verticalInside: BorderSide(),
          // ),
          columnWidths: const {
            1: FixedColumnWidth(190),
            // 1: IntrinsicColumnWidth()
          },
          children: [
            TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.bottom,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.bottom,
                  child:
                      Text('${userData["firstName"]} ${userData["lastName"]}')),
            ]),
            rowSpacer,
            TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.bottom,
                child: Text('Age',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.bottom,
                  child: Text(userData["age"].toString())),
            ]),
            rowSpacer,
            TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.bottom,
                child: Text('Email',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.bottom,
                  child: Text(userData["email"])),
            ]),
            rowSpacer,
            TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.bottom,
                child: Text('Languages',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.bottom,
                  child: Text(userData["language"])),
            ]),
          ]),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: const [
      //         Text(
      //           'Name:',
      //           style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold),
      //         ),
      //         Text(
      //           'Email address:',
      //           style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold),
      //         ),
      //         Text(
      //           'Number:',
      //           style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold),
      //         ),
      //         Text(
      //           'Languages:',
      //           style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.bold),
      //         )
      //       ],
      //     ),
      //     SizedBox(
      //       width: 80,
      //     ),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: const [
      //         Align(
      //           alignment: Alignment.centerLeft,
      //           child: Text(
      //             'Name:',
      //           ),
      //         ),
      //         Text('Email address:'),
      //         Text('Number:'),
      //         Text('Languages:')
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}

class StudyingInfo extends StatelessWidget {
  const StudyingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    const rowSpacer = TableRow(children: [
      SizedBox(
        height: 8,
      ),
      SizedBox(
        height: 8,
      )
    ]);

    return Padding(
      padding: EdgeInsets.all(12),
      child: Table(columnWidths: const {
        1: FixedColumnWidth(190),
        // 1: IntrinsicColumnWidth()
      }, children: [
        TableRow(children: const [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Text(
              'Hours of study',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.bottom,
              child: Text('0')),
        ]),
        rowSpacer,
        TableRow(children: const [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Text('Lessons completed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.bottom,
              child: Text('0')),
        ]),
        rowSpacer,
        TableRow(children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Text('Score',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.bottom,
              child: Text(context.read<UserProvider>().userScore.toString())),
        ]),
        rowSpacer,
        TableRow(children: const [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Text('Ranking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          TableCell(
              verticalAlignment: TableCellVerticalAlignment.bottom,
              child: Text('1')),
        ]),
      ]),
    );
  }
}

class UserProfileLoadingScreen extends StatelessWidget {
  const UserProfileLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPathLightBlue(context: context),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.lightBlue.shade400,
                    Colors.lightBlue.shade100,
                  ],
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPathBlue(context: context),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                // gradient
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue.shade900,
                    Colors.indigo.shade900,
                  ],
                ),
              ),
            ),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
