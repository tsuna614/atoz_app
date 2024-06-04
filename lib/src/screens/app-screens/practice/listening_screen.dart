import 'dart:async';
import 'dart:math';

import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_listening_1.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_listening_2.dart';
import 'package:atoz_app/src/utils/time_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  late List<ListeningQuestion> listeningQuestions = [];
  int currentQuestionIndex = 0;
  bool isLoading = false;

  late Widget currentScreen;

  late Timer _timer;
  // int _totalTime = 0;
  final ValueNotifier<int> _totalTime = ValueNotifier<int>(0);

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_totalTime.value >= 6039) {
          timer.cancel();
        } else {
          _totalTime.value++;
        }
      },
    );
  }

  Future<void> initQuestionList() async {
    setState(() {
      isLoading = true;
    });

    final dio = Dio();
    final response =
        await dio.get('${global.atozApi}/listeningQuiz/getAllQuizzes');

    List<ListeningQuestion> temp = [];

    for (int i = 0; i < response.data.length; i++) {
      setState(() {
        temp.add(
          ListeningQuestion(
            fullSentence: response.data[i]['fullSentence'].toString(),
            answers: response.data[i]['fullSentence'].toString().split(' '),
            audioPublicId: response.data[i]['publicId'].toString(),
            quizType: Random().nextInt(2) + 1,
            // quizType: 1,
          ),
        );
      });
    }

    // get 5 random questions and add to listeningQuestions list
    temp.shuffle();
    for (int i = 0; i < 5; i++) {
      if (i >= temp.length) {
        break;
      }
      listeningQuestions.add(temp[i]);
    }

    setState(() {
      isLoading = false;
    });
  }

  void handleCheckButton(bool isCorrect) {
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  void initState() {
    initQuestionList();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (currentQuestionIndex == listeningQuestions.length) {
      currentScreen = Center(
        child: Text("End of questions"),
      );
    } else {
      if (listeningQuestions[currentQuestionIndex].quizType == 1) {
        currentScreen = ListeningTest(
          fullSentence: listeningQuestions[currentQuestionIndex].fullSentence,
          answers: listeningQuestions[currentQuestionIndex].answers,
          audioPublicId: listeningQuestions[currentQuestionIndex].audioPublicId,
          handleCheckButton: handleCheckButton,
        );
      } else if (listeningQuestions[currentQuestionIndex].quizType == 2) {
        currentScreen = ListeningTest2(
          fullSentence: listeningQuestions[currentQuestionIndex].fullSentence,
          answers: listeningQuestions[currentQuestionIndex].answers,
          audioPublicId: listeningQuestions[currentQuestionIndex].audioPublicId,
          handleCheckButton: handleCheckButton,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: ValueListenableBuilder<int>(
          valueListenable: _totalTime,
          builder: (context, value, child) {
            return Text(
              formattedTime(timeInSecond: value),
              style: TextStyle(
                color: Colors.white,
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: ProgressBar(
                    screenWidth: width - 80,
                    ratio: listeningQuestions.isNotEmpty
                        ? currentQuestionIndex / listeningQuestions.length
                        : 1 / 1),
              ),
              currentScreen,
              // if (listeningQuestions.isNotEmpty)
              //   listeningQuestions[currentQuestionIndex],
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar(
      {super.key, required this.screenWidth, required this.ratio});

  final double screenWidth;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenWidth,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        AnimatedContainer(
          width: screenWidth * ratio,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          duration: Duration(milliseconds: 250),
        ),
      ],
    );
  }
}
