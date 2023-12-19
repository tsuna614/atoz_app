import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
        // Align(
        //   alignment: Alignment(0, 1),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //         TemporaryPlayerTitle(),
        //       ],
        //     ),
        //   ),
        // ),
        Positioned(
          // top: 0,
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
                    TopPlayerCard(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TemporaryPlayerTitle(index: 1),
                      TemporaryPlayerTitle(index: 2),
                      TemporaryPlayerTitle(index: 3),
                      TemporaryPlayerTitle(index: 4),
                      TemporaryPlayerTitle(index: 5),
                      TemporaryPlayerTitle(index: 6),
                      TemporaryPlayerTitle(index: 7),
                      TemporaryPlayerTitle(index: 8),
                      TemporaryPlayerTitle(index: 9),
                      TemporaryPlayerTitle(index: 10),
                      TemporaryPlayerTitle(index: 11),
                      TemporaryPlayerTitle(index: 12),
                      TemporaryPlayerTitle(index: 13),
                      TemporaryPlayerTitle(index: 14),
                      TemporaryPlayerTitle(index: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

class TopPlayerCard extends StatelessWidget {
  const TopPlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Khanh',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            '2190',
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
                        children: const [
                          Icon(
                            FontAwesomeIcons.crown,
                            color: Colors.yellow,
                          ),
                          Text(
                            'Khanh',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            '2190',
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
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Khanh',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '2190',
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
                            backgroundImage:
                                AssetImage("assets/images/pfp.jpeg"),
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
                            backgroundImage:
                                AssetImage("assets/images/pfp.jpeg"),
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
                            backgroundImage:
                                AssetImage("assets/images/pfp.jpeg"),
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
}

class TemporaryPlayerTitle extends StatelessWidget {
  const TemporaryPlayerTitle({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListTile(
        // leading: Text(
        //   index.toString(),
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        title: Container(
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  index.toString(),
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
                    children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/profile.jpg",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                // Text(
                //   'Khanh Nguyen Quoc',
                //   style: TextStyle(
                //     // fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    'Khanh Nguyen Quoc',
                    style: TextStyle(
                      // fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '2190',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        // trailing: Text(
        //   '2190',
        //   style: TextStyle(
        //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        // ),
      ),
    );
  }
}
