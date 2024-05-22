import 'package:atoz_app/src/models/chapter_model.dart';
import 'package:atoz_app/src/providers/chapter_provider.dart';
import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/stage-select/stage_select_screen.dart';
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

  void _pushToStageSelectScreen(int index, String chapterName) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => StageSelectScreen(chapterName: chapterName),
    //   ),
    // );
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return StageSelectScreen(
              chapterIndex: index, chapterName: chapterName);
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // getUserData();
    // currentUserProgress = context.watch<UserProvider>().currentUserProgress;
  }

  @override
  Widget build(BuildContext context) {
    // int currentUserProgress = context.watch<UserProvider>().currentUserProgress;

    // double height = MediaQuery.of(context).size.height;

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
                      _buildChapterCard(context, 0, "Greetings",
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
                      _buildChapterCard(context, 1, "Travel",
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
                      _buildChapterCard(context, 2, "Food",
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

  Widget _buildChapterCard(
      BuildContext context, int index, String chapterName, String imageUrl) {
    // get user's current progression in the chapter
    List<StageDetails> currentChapterProgression =
        context.watch<UserProvider>().currentUserProgress[index];
    // get chapter data from provider
    Chapter currentChapter = context.read<ChapterProvider>().chapters[index];

    int currentChapterStarsCount = 0;
    int currentChapterTotalStars = currentChapter.stages.length * 3;

    for (int i = 0; i < currentChapterProgression.length; i++) {
      currentChapterStarsCount += currentChapterProgression[i].star;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => _pushToStageSelectScreen(index, chapterName),
        child: Stack(
          children: [
            FadeInImage(
              height: 250,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                        ),
                        Text(
                          "$currentChapterStarsCount/$currentChapterTotalStars",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Stage: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          (currentChapterProgression.length + 1).toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
