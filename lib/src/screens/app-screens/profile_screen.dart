import 'package:atoz_app/src/screens/app-screens/chart/bar_chart.dart';
import 'package:atoz_app/src/widgets/animated_button_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

final _firebase = FirebaseAuth.instance;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void testFunction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          DetailInfo(),
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
                      backgroundImage: AssetImage("assets/images/pfp.jpeg"),
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
                children: [
                  // ProfileNumberWidget(number: 0, title: 'Friends'),
                  // ProfileNumberWidget(number: 0, title: 'Follower'),
                  // ProfileNumberWidget(number: 0, title: 'Following'),
                  Expanded(
                    child: AnimatedButton1(
                        buttonText: 'Add Friend', voidFunction: testFunction),
                  ),
                  Expanded(
                    child: AnimatedButton1(
                        buttonText: 'Add Friend', voidFunction: testFunction),
                  ),
                ],
              ),
            ]),
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
  const DetailInfo({super.key});

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
          Text(
            'Name',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Nguyen Quoc Khanh'),
        ]),
        rowSpacer,
        TableRow(children: [
          Text('Age',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('19'),
        ]),
        rowSpacer,
        TableRow(children: [
          Text('Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('thedarkspiritaway@gmail.com'),
        ]),
        rowSpacer,
        TableRow(children: [
          Text('Languages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('English, Japanese'),
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
          Text(
            'Hours of study',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('16'),
        ]),
        rowSpacer,
        TableRow(children: [
          Text('Lessons completed',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('52'),
        ]),
        rowSpacer,
        TableRow(children: [
          Text('Score',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('815'),
        ]),
        rowSpacer,
        TableRow(children: [
          Text('Ranking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('161'),
        ]),
      ]),
    );
  }
}
