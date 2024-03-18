import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/chart/bar_chart.dart';
import 'package:atoz_app/src/screens/app-screens/profile-screen/change_profile_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

final dio = Dio();

final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  ProfileScreen(
      {super.key,
      required this.userId,
      required this.isDirectedFromLeaderboard});

  final String userId;
  final bool isDirectedFromLeaderboard;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;
  bool hasImage = false;
  int selectedTab = 0;

  request() async {
    Response response;
    // response = await dio.get(
    //     '${global.atozApi}/user/getUserById/${_firebase.currentUser!.uid}');
    response =
        await dio.get('${global.atozApi}/user/getUserById/${widget.userId}');

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
    // // this is the CURRENTLY SIGNED IN account
    // // it's might be different from widget.userId because you might be seeing someone else's profile
    // bool isCurrentlySignedInUser =
    //     context.watch<UserProvider>().userId == widget.userId;

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
                if (selectedTab == 0)
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
                              color: Colors.white,
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
                            height: 20,
                          ),
                          Text(
                            'User\'s score chart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                // THIS IS THE BACKGROUND CONTAINER
                Positioned(
                  top: 0,
                  child: Column(
                    children: [
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
                  clipper: CustomClipPathPurple(context: context),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      // gradient
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.blue.shade500, Colors.blue.shade500],
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: CustomClipPathPurpleAccent(context: context),
                  child: Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.lightBlue.shade700,
                          Colors.lightBlue.shade400,
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
                                backgroundImage: Image.asset(
                                        'assets/images/avatar/${userData['profileImage']}.jpeg')
                                    .image,
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
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = 0;
                                  });
                                },
                                child: Text(
                                  "Stats",
                                  style: TextStyle(
                                    color: selectedTab == 0
                                        ? Colors.blue
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 3,
                                width: selectedTab == 0 ? 30 : 0,
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: selectedTab == 0
                                      ? Colors.blue
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = 1;
                                  });
                                },
                                child: Text(
                                  "Friends",
                                  style: TextStyle(
                                    color: selectedTab == 1
                                        ? Colors.blue
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 3,
                                width: selectedTab == 1 ? 30 : 0,
                                margin: EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: selectedTab == 1
                                      ? Colors.blue
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                // THIS IS THE IOS BACK BUTTON ON THE TOP LEFT
                if (widget.isDirectedFromLeaderboard)
                  Positioned(
                    top: 60,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
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
                            userImage: hasImage ? userData["profileImage"] : '',
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
    );
  }
}

class StudyingInfo extends StatelessWidget {
  const StudyingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final userProgression = context.read<UserProvider>().userProgressionPoint;
    String difficulty = 'Novice';
    if (userProgression >= 200) {
      difficulty = 'Intermediate';
    } else if (userProgression >= 500) {
      difficulty = 'Expert';
    } else if (userProgression >= 1000) {
      difficulty = 'Master';
    }

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
        // TableRow(children: const [
        //   TableCell(
        //     verticalAlignment: TableCellVerticalAlignment.bottom,
        //     child: Text(
        //       'Hours of study',
        //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        //   TableCell(
        //       verticalAlignment: TableCellVerticalAlignment.bottom,
        //       child: Text('0')),
        // ]),
        // rowSpacer,
        TableRow(children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Text('Difficulty',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.bottom,
            child: Text(
              difficulty,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
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
            clipper: CustomClipPathPurple(context: context),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                // gradient
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue.shade500, Colors.blue.shade500],
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPathPurpleAccent(context: context),
            child: Container(
              height: 200.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.lightBlue.shade700,
                    Colors.lightBlue.shade400,
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

class CustomClipPathPurple extends CustomClipper<Path> {
  CustomClipPathPurple({required this.context});

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
    path.lineTo(0, h * 0.05);
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

class CustomClipPathPurpleAccent extends CustomClipper<Path> {
  CustomClipPathPurpleAccent({required this.context});

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
    path.lineTo(0, h * 0.2);
    path.lineTo(w, h * 0.05);

    // path.quadraticBezierTo(w * 0.1, h * 0.1, w * 0.7, h * 0.12);
    // path.quadraticBezierTo(w * 1, h * 0.13, w, h * 0.08);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
