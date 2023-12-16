import 'package:atoz_app/src/screens/app-screens/practice-screens/listening_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/reading_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/speaking_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/writing_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class PracticeScreen extends StatelessWidget {
  PracticeScreen({super.key});

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPathLightBlue(context: context),
            child: Container(
              // gradient color
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.lightBlue.shade400,
                    Colors.lightBlue.shade600,
                  ],
                ),
              ),
            ),
          ),
          PageView(
            // scroll vertically
            scrollDirection: Axis.vertical,
            controller: controller,
            children: const [
              CardItem(
                cardCategory: 'reading',
              ),
              CardItem(
                cardCategory: 'writing',
              ),
              CardItem(
                cardCategory: 'listening',
              ),
              CardItem(
                cardCategory: 'speaking',
              ),
            ],
          ),
          ClipPath(
            clipper: CustomClipPathBlue(context: context),
            child: Container(
              // gradient color
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade800,
                  ],
                ),
              ),
            ),
          ),
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
    path.lineTo(0, h * 0.11);
    // create a s shaped line to x = w, y = h * 0.2
    path.quadraticBezierTo(w * 0.2, h * 0.17, w * 0.5, h * 0.13);
    path.quadraticBezierTo(w * 0.8, h * 0.1, w, h * 0.12);
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
    path.lineTo(0, h * 0.1);
    // create a s shaped line to x = w, y = h * 0.2
    path.quadraticBezierTo(w * 0.1, h * 0.1, w * 0.7, h * 0.15);
    path.quadraticBezierTo(w * 0.9, h * 0.16, w, h * 0.15);
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

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.cardCategory});

  final String cardCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, bottom: 20, left: 20, right: 20),
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                if (cardCategory == 'reading')
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/reading.png'),
                        ),
                      ),
                      getScrollCircle(0),
                      SizedBox(width: 20),
                    ],
                  )
                else if (cardCategory == 'writing')
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/writing.png'),
                        ),
                      ),
                      getScrollCircle(1),
                      SizedBox(width: 20),
                    ],
                  )
                else if (cardCategory == 'listening')
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/listening.png'),
                        ),
                      ),
                      getScrollCircle(2),
                      SizedBox(width: 20),
                    ],
                  )
                else if (cardCategory == 'speaking')
                  Row(
                    children: [
                      SizedBox(width: 30),
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/speaking.png'),
                        ),
                      ),
                      getScrollCircle(3),
                      SizedBox(width: 20),
                    ],
                  ),
                SizedBox(height: 16),
                Text(
                  "${cardCategory[0].toUpperCase()}${cardCategory.substring(1).toLowerCase()}",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                Divider(
                  height: 40,
                  thickness: 3,
                  indent: 100,
                  endIndent: 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Practice your skill with this gamemode. While it is certainly fun to play, it will definitely not give you an easy task. Your heart will not decrease if you lose in this gamemode.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.all(32),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size.fromHeight(40)),
                    onPressed: () {
                      if (cardCategory == 'reading') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReadingScreen()),
                        );
                      } else if (cardCategory == 'listening') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListeningScreen()),
                        );
                      } else if (cardCategory == 'writing') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WritingScreen()),
                        );
                      } else if (cardCategory == 'speaking') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SpeakingScreen()),
                        );
                      }
                    },
                    child: const Text(
                      'Start',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getScrollCircle(int index) {
    return Column(
      children: [
        Container(
          width: 10,
          height: index == 0 ? 30 : 10,
          decoration: BoxDecoration(
            color: index == 0 ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 10,
          height: index == 1 ? 30 : 10,
          decoration: BoxDecoration(
              color: index == 1 ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 10,
          height: index == 2 ? 30 : 10,
          decoration: BoxDecoration(
              color: index == 2 ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 10,
          height: index == 3 ? 30 : 10,
          decoration: BoxDecoration(
              color: index == 3 ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ]),
        ),
      ],
    );
  }
}
