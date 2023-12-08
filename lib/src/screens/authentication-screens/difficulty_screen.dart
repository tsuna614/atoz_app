import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DifficultyScreen extends StatefulWidget {
  DifficultyScreen({super.key, required this.chosenLanguage});

  final String chosenLanguage;

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

  double _padding = 6.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 194, 255),
      body: Stack(
        children: [
          Positioned(
            top: 160,
            left: 50,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First, let us set you up!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 50,
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
                      CountryCard(
                        difficulty: 'Novice',
                        chosenDifficulty: chosenDifficulty,
                        onDifficultyPress: onDifficultyPress,
                      ),
                      CountryCard(
                        difficulty: 'Beginner',
                        chosenDifficulty: chosenDifficulty,
                        onDifficultyPress: onDifficultyPress,
                      ),
                      CountryCard(
                        difficulty: 'Intermediate',
                        chosenDifficulty: chosenDifficulty,
                        onDifficultyPress: onDifficultyPress,
                      ),
                      CountryCard(
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
                                        color:
                                            Color.fromARGB(255, 154, 154, 154),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {},
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
                                  margin: EdgeInsets.only(top: -(_padding - 6)),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
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
                                        'Check',
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
    );
  }
}

class CountryCard extends StatefulWidget {
  const CountryCard({
    super.key,
    required this.difficulty,
    required this.chosenDifficulty,
    required this.onDifficultyPress,
  });

  final String difficulty;
  final String chosenDifficulty;
  final Function(String difficultyChosen) onDifficultyPress;

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
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
                        color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    subText,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor),
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
