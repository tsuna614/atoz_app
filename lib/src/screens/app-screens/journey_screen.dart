import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dio/dio.dart';
import 'package:atoz_app/src/data/global_data.dart' as global_data;

final dio = Dio();

class JourneyScreen extends StatefulWidget {
  JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  int currentUserProgress = 0;

  void getUserData() async {
    Response response;
    response = await dio.get('${global_data.atozApi}/user/getAllUsers');
    setState(() {
      currentUserProgress = response.data[0]['userStage'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.lightBlue.shade200,
                    Colors.lightBlue.shade400,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'Chapter 1   -   GREETINGS',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return GameNodeButton(
                            index: index + 1,
                            userProgress: currentUserProgress,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'Chapter 2   -   TRAVEL',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return GameNodeButton(
                            index: index + 11,
                            userProgress: currentUserProgress,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'Chapter 3   -   SCHOOL',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return GameNodeButton(
                            index: index + 21,
                            userProgress: currentUserProgress,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPathBlue(context: context),
            child: Container(
              // color: Colors.blue,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade600,
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
    path.lineTo(0, h * 0.1);
    // create a s shaped line to x = w, y = h * 0.2
    path.quadraticBezierTo(w * 0.1, h * 0.12, w * 0.5, h * 0.08);
    path.quadraticBezierTo(w * 0.8, h * 0.05, w, h * 0.11);
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
    path.quadraticBezierTo(w * 0.1, h * 0.1, w * 0.7, h * 0.12);
    path.quadraticBezierTo(w * 1, h * 0.13, w, h * 0.08);
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

///////////////// GAME NODE BUTTON BUTTON /////////////////

class GameNodeButton extends StatefulWidget {
  const GameNodeButton({
    super.key,
    required this.index,
    required this.userProgress,
  });

  final int index;
  final int userProgress;

  @override
  State<GameNodeButton> createState() => _GameNodeButtonState();
}

class _GameNodeButtonState extends State<GameNodeButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.index > widget.userProgress
          ? null
          : () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()));
            },
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _padding = 6;
        });
      },
      onTapUp: (_) {
        setState(() {
          _padding = 6;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          color: widget.index < widget.userProgress
              ? Colors.green
              : widget.index == widget.userProgress
                  ? Colors.blue
                  : Colors.grey,
          // color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: widget.index < widget.userProgress
                  ? Colors.green
                  : widget.index == widget.userProgress
                      ? Colors.blue
                      : Colors.grey,
              // color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              // question mark icon as child
              // child: Icon(
              //   FontAwesomeIcons.question,
              //   size: 35.0,
              // ),
              child: widget.index < widget.userProgress
                  ? Icon(Icons.check, color: Colors.green, size: 35.0)
                  : widget.index == widget.userProgress
                      ? Text(
                          widget.index.toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      : Icon(Icons.lock, color: Colors.grey, size: 35.0),
            ),
          ),
        ),
      ),
    );
  }
}
