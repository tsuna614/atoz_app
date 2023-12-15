import 'package:atoz_app/src/screens/app-screens/chart/bar_chart.dart';
import 'package:atoz_app/src/screens/app-screens/profile-screen/change_profile_screen.dart';
import 'package:atoz_app/src/widgets/animated_button_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final dio = Dio();

final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData;

  request() async {
    Response response;
    response = await dio.get(
        '${global.atozApi}/user/getUserById/${_firebase.currentUser!.uid}');

    setState(() {
      userData = response.data[0];
    });

    // print(response.data[0]['lastName'].toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    request();
  }

  @override
  Widget build(BuildContext context) {
    print(userData);
    return userData == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(''),
              elevation: 0,
            ),
            body: Stack(
              children: [
                // THIS IS THE INFO CARD BELOW THE PROFILE
                Align(
                  alignment: Alignment(0, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // THIS IS THE PROFILE PICTURE AND TITLE/NAME
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: [
                    // ClipOval(
                    //   child: SizedBox.fromSize(
                    //     size: Size.fromRadius(50),
                    //     child:
                    //         Image.asset('assets/images/pfp.jpeg', fit: BoxFit.cover),
                    //   ),
                    // ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.expand,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/pfp.jpeg"),
                          ),
                          Positioned(
                              bottom: -10,
                              right: -40,
                              child: SizedBox(
                                height: 50,
                                child: RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  fillColor: Color(0xFFF5F6F9),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      // '${userData['firstName']} ${userData['lastName']}',
                      '${userData["firstName"]} ${userData["lastName"]}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userData["email"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
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
                  ]),
                ),
                // THIS IS THE PENCIL ICON BUTTON ON THE TOP RIGHT
                Align(
                  alignment: Alignment(0.95, -1),
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
                          ),
                        ),
                      );
                    },
                    icon: Icon(FontAwesomeIcons.pencil),
                    color: Colors.white,
                  ),
                )
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
      }, children: const [
        TableRow(children: [
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
        TableRow(children: [
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
              child: Text('0')),
        ]),
        rowSpacer,
        TableRow(children: [
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
