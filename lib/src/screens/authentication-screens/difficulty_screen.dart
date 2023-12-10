import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class DifficultyScreen extends StatefulWidget {
  DifficultyScreen({
    super.key,
    required this.chosenLanguage,
    required this.resetMainPage,
  });

  final String chosenLanguage;
  final void Function() resetMainPage;

  @override
  State<DifficultyScreen> createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> {
  final ScrollController controller = ScrollController();

  String chosenDifficulty = '';

  void onDifficultyPress(String difficulty) {
    setState(() {
      chosenDifficulty = difficulty;
    });
  }

  void onCheckPress() async {
    final _firebase = FirebaseAuth.instance;
    final id = _firebase.currentUser!.uid;
    double score = 0;

    switch (chosenDifficulty) {
      case 'Novice':
        score = 0;
        break;
      case 'Beginner':
        score = 200;
        break;
      case 'Intermediate':
        score = 500;
        break;
      case 'Expert':
        score = 1000;
        break;
      default:
        break;
    }
    Response response = await dio.put(
      'http://localhost:3000/v1/user/editUserById/${id}',
      data: {
        'language': widget.chosenLanguage,
        'score': score,
      },
    );

    widget.resetMainPage();
  }

  double _padding = 6.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // title: Row(
      //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   //   children: [
      //   //     Expanded(
      //   //       child: Container(
      //   //         height: 10,
      //   //         color: Colors.white,
      //   //       ),
      //   //     ),
      //   //     SizedBox(
      //   //       width: 20,
      //   //     ),
      //   //     Expanded(
      //   //       child: Container(
      //   //         height: 10,
      //   //         color: Colors.white,
      //   //       ),
      //   //     ),
      //   //   ],
      //   // ),
      // ),
      backgroundColor: Color.fromARGB(255, 0, 194, 255),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 40,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Final step.',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'What\'s your current ${widget.chosenLanguage} level?',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              // bottom: 10,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      children: [
                        Spacer(),
                        DifficultyCard(
                          difficulty: 'Novice',
                          chosenDifficulty: chosenDifficulty,
                          onDifficultyPress: onDifficultyPress,
                        ),
                        DifficultyCard(
                          difficulty: 'Beginner',
                          chosenDifficulty: chosenDifficulty,
                          onDifficultyPress: onDifficultyPress,
                        ),
                        DifficultyCard(
                          difficulty: 'Intermediate',
                          chosenDifficulty: chosenDifficulty,
                          onDifficultyPress: onDifficultyPress,
                        ),
                        DifficultyCard(
                          difficulty: 'Expert',
                          chosenDifficulty: chosenDifficulty,
                          onDifficultyPress: onDifficultyPress,
                        ),
                        SizedBox(height: 16),
                        // FilledButton(
                        //   style: ElevatedButton.styleFrom(
                        //       minimumSize: Size.fromHeight(60),
                        //       backgroundColor: Color.fromARGB(255, 35, 182, 40)),
                        //   onPressed: chosenDifficulty.isEmpty ? null : () {},
                        //   child: Text(
                        //     'Select',
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         letterSpacing: 5,
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: chosenDifficulty.isEmpty
                              ? Container(
                                  padding: EdgeInsets.only(bottom: _padding),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Check',
                                        style: TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 5,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 154, 154, 154),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    onCheckPress();
                                  },
                                  onTapDown: (_) {
                                    setState(() {
                                      _padding = 0;
                                    });
                                  },
                                  onTapUp: (_) {
                                    setState(() {
                                      _padding = 6;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    padding: EdgeInsets.only(bottom: _padding),
                                    margin:
                                        EdgeInsets.only(top: -(_padding - 6)),
                                    decoration: BoxDecoration(
                                      // color: Theme.of(context).primaryColor,
                                      color: Colors.blue[800],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    duration: Duration(milliseconds: 100),
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DifficultyCard extends StatefulWidget {
  const DifficultyCard({
    super.key,
    required this.difficulty,
    required this.chosenDifficulty,
    required this.onDifficultyPress,
  });

  final String difficulty;
  final String chosenDifficulty;
  final Function(String difficultyChosen) onDifficultyPress;

  @override
  State<DifficultyCard> createState() => _DifficultyCardState();
}

class _DifficultyCardState extends State<DifficultyCard> {
  double _padding = 6.0;

  @override
  Widget build(BuildContext context) {
    final String subText;

    switch (widget.difficulty) {
      case 'Novice':
        subText = 'I\'m completely new to this language';
        break;
      case 'Beginner':
        subText = 'I know a little bit about this language';
        break;
      case 'Intermediate':
        subText = 'I\'m no longer a beginner';
        break;
      case 'Expert':
        subText = 'I\'ve mastered this language, hit me with all you\'ve got';
        break;
      default:
        subText = '';
        break;
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          widget.onDifficultyPress(widget.difficulty);
        },
        onTapDown: (_) {
          setState(() {
            _padding = 0.0;
          });
        },
        onTapUp: (_) {
          setState(() {
            _padding = 6.0;
          });
        },
        child: AnimatedContainer(
          padding: EdgeInsets.only(bottom: _padding),
          margin: EdgeInsets.only(top: -(_padding - 6)),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(milliseconds: 100),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.chosenDifficulty == widget.difficulty
                  ? Colors.white
                  : Colors.white.withOpacity(0.8),
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                widget.chosenDifficulty == widget.difficulty
                    ? BoxShadow(
                        color: Colors.white,
                        blurRadius: 1,
                        offset: Offset(0, 0), // Shadow position
                      )
                    : BoxShadow()
              ],
              // border: chosenDifficulty == difficulty
              //     ? Border.all(color: Colors.white, width: 3)
              //     : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.difficulty,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: widget.chosenDifficulty == widget.difficulty
                            ? Colors.blue
                            : Colors.blue[800]),
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: widget.chosenDifficulty == widget.difficulty
                            ? Colors.blue
                            : Colors.blue[800]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    //   return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10),
    //           boxShadow: [
    //             chosenDifficulty == difficulty
    //                 ? BoxShadow(
    //                     color: Colors.blue,
    //                     blurRadius: 0,
    //                     offset: Offset(4, 4), // Shadow position
    //                   )
    //                 : BoxShadow()
    //           ],
    //           // border: chosenDifficulty == difficulty
    //           //     ? Border.all(color: Colors.white, width: 3)
    //           //     : null,
    //         ),
    //         child: Material(
    //           color: Colors.transparent,
    //           child: InkWell(
    //             customBorder: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10),
    //             ),
    //             onTap: () {
    //               onDifficultyPress(difficulty);
    //             },
    //             child: Container(
    //               width: double.infinity,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       difficulty,
    //                       style: TextStyle(
    //                           fontSize: 26,
    //                           fontWeight: FontWeight.bold,
    //                           color: Theme.of(context).primaryColor),
    //                     ),
    //                     Text(
    //                       subText,
    //                       style: TextStyle(
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.normal,
    //                           color: Theme.of(context).primaryColor),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ));
    // }
  }
}
