import 'dart:async';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_speaking.dart';
import 'package:atoz_app/src/utils/time_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  late List<SpeakingQuestion> speakingQuestions = [];
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
        await dio.get('${global.atozApi}/speakingQuiz/getAllQuizzes');

    List<SpeakingQuestion> temp = [];

    for (int i = 0; i < response.data.length; i++) {
      setState(() {
        temp.add(
          SpeakingQuestion(
            sentence: response.data[i]['sentence'].toString(),
          ),
        );
      });
    }

    temp.shuffle();
    for (int i = 0; i < 5; i++) {
      if (i >= temp.length) {
        break;
      }
      speakingQuestions.add(temp[i]);
    }

    speakingQuestions.shuffle();

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
    currentScreen = Center(
      child: CircularProgressIndicator(),
    );
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

    if (currentQuestionIndex == speakingQuestions.length) {
      currentScreen = Center(
        child: Text("End of questions"),
      );
    } else {
      currentScreen = SpeakingTest(
        fullSentence: speakingQuestions[currentQuestionIndex].sentence,
        handleCheckButton: handleCheckButton,
      );
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
                    ratio: speakingQuestions.isNotEmpty
                        ? currentQuestionIndex / speakingQuestions.length
                        : 1 / 1),
              ),
              currentScreen,
              // if (speakingQuestions.isNotEmpty)
              //   speakingQuestions[currentQuestionIndex],
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
