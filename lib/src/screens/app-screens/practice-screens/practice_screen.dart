import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/admin-practice-screen/view_listening.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/admin-practice-screen/view_reading_question.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/admin-practice-screen/view_speaking.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/admin-practice-screen/view_writing_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/listening_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/reading_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/speaking_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/writing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class PracticeScreen extends StatefulWidget {
  PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final controller = PageController(
    initialPage: 0,
  );

  int pageIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

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
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
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
          Positioned(
            top: 260,
            right: 35,
            child: buildScrollIndex(pageIndex),
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

  Widget buildScrollIndex(int index) {
    return Column(
      children: [
        AnimatedContainer(
          width: 10,
          height: index == 0 ? 30 : 10,
          decoration: BoxDecoration(
            color: index == 0 ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          duration: Duration(milliseconds: 300),
        ),
        SizedBox(
          height: 10,
        ),
        AnimatedContainer(
          width: 10,
          height: index == 1 ? 30 : 10,
          decoration: BoxDecoration(
            color: index == 1 ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          duration: Duration(milliseconds: 300),
        ),
        SizedBox(
          height: 10,
        ),
        AnimatedContainer(
          width: 10,
          height: index == 2 ? 30 : 10,
          decoration: BoxDecoration(
            color: index == 2 ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          duration: Duration(
            milliseconds: 300,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        AnimatedContainer(
          width: 10,
          height: index == 3 ? 30 : 10,
          decoration: BoxDecoration(
            color: index == 3 ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          duration: Duration(milliseconds: 300),
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
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/reading.png'),
                        ),
                      ),
                    ],
                  )
                else if (cardCategory == 'writing')
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/writing.png'),
                        ),
                      ),
                    ],
                  )
                else if (cardCategory == 'listening')
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/listening.png'),
                        ),
                      ),
                    ],
                  )
                else if (cardCategory == 'speaking')
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/speaking.png'),
                        ),
                      ),
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
                    cardCategory == 'reading'
                        ? 'Read the text and answer the questions'
                        : cardCategory == 'writing'
                            ? 'Write the text based on the picture'
                            : cardCategory == 'listening'
                                ? 'Listen to the audio and answer the questions'
                                : 'Record your voice and answer the questions',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                if (context.read<UserProvider>().userType != 'admin')
                  SizedBox(
                    height: 32,
                  ),
                if (context.read<UserProvider>().userType == 'admin')
                  Padding(
                    padding: EdgeInsets.only(
                        left: 32, right: 32, bottom: 32, top: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          minimumSize: Size.fromHeight(40)),
                      onPressed: () {
                        if (cardCategory == 'reading') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ViewReadingScreen()),
                          );
                        } else if (cardCategory == 'listening') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ViewListeningScreen()),
                          );
                        } else if (cardCategory == 'writing') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ViewWritingScreen()),
                          );
                        } else if (cardCategory == 'speaking') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ViewSpeakingScreen()),
                          );
                        }
                      },
                      child: const Text(
                        'Edit Question',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
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
}
