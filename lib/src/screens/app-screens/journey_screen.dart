import 'package:atoz_app/src/providers/user_provider.dart';

import 'package:atoz_app/src/screens/app-screens/quiz-screens/quiz_screen.dart';
import 'package:atoz_app/src/screens/app-screens/stage_select_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

final _firebase = FirebaseAuth.instance;
final dio = Dio();

class JourneyScreen extends StatefulWidget {
  JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  // void getUserData() async {
  //   Response response;
  //   response = await dio.get(
  //       '${global_data.atozApi}/user/getUserById/${_firebase.currentUser!.uid}');
  //   setState(() {
  //     currentUserProgress = response.data[0]['userStage'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getUserData();
    // currentUserProgress = context.watch<UserProvider>().currentUserProgress;
  }

  @override
  Widget build(BuildContext context) {
    int currentUserProgress = context.watch<UserProvider>().currentUserProgress;

    return Scaffold(
      // extendBodyBehindAppBar: true,
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
                      // _buildStageSelectionGrid(context, 1, currentUserProgress)
                      _buildChapterCard(context, "Greetings",
                          "https://www.candacesmithetiquette.com/images/Friends_meeting_in_the_street.jpg"),
                    ],
                  ),
                  SizedBox(height: 50),
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
                      // _buildStageSelectionGrid(context, 11, currentUserProgress)
                      _buildChapterCard(context, "Travel",
                          "https://www.westernunion.com/blog/wp-content/uploads/2016/06/Travel_Abroad_01.jpg"),
                    ],
                  ),
                  SizedBox(height: 50),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          'Chapter 3   -   FOOD',
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
                      // _buildStageSelectionGrid(context, 21, currentUserProgress)
                      _buildChapterCard(context, "Food",
                          "https://images.unsplash.com/photo-1592861956120-e524fc739696?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVvcGxlJTIwZWF0aW5nfGVufDB8fDB8fHww")
                    ],
                  ),
                  SizedBox(height: 50),
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

  Widget _buildStageSelectionGrid(
      BuildContext context, int startingStage, int currentUserProgress) {
    return GridView.builder(
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
          index: index + startingStage,
          userProgress: currentUserProgress,
        );
      },
    );
  }

  Widget _buildChapterCard(
      BuildContext context, String chapterName, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StageSelectScreen(chapterName: chapterName),
            ),
          );
        },
        child: FadeInImage(
          height: 250,
          width: double.infinity,
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
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

  double width = 80;
  double height = 70;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.index > widget.userProgress
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    currentStage: widget.index - 1,
                  ),
                ),
              );
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
          borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          width: width,
          height: height,
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
            borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
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
