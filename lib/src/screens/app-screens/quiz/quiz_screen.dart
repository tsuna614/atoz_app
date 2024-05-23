import 'dart:async';

import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/chapter_provider.dart';
import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_connect_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_drop_down.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_reading.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_reorder_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_translate.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_words_distribution.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/result_screen.dart';
import 'package:atoz_app/src/screens/main-screens/loading_screen.dart';
import 'package:atoz_app/src/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.currentSelectedChapter,
    required this.currentChosenStage,
  });

  final int currentSelectedChapter;
  final int currentChosenStage;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  // List<String> chosenAnswers = [];
  int userScore = 0;
  List<QuizQuestion> question = [];
  late Widget chosenScreen;

  void _getQuestions() {
    if (context.read<UserProvider>().userLanguage == 'English') {
      question = context
          .read<ChapterProvider>()
          .chapters[widget.currentSelectedChapter]
          .stages[widget.currentChosenStage]
          .questions;
    } else {
      question = context
          .read<ChapterProvider>()
          .chapters[widget.currentSelectedChapter]
          .stages[widget.currentChosenStage]
          .questions;
    }
    // // Japanese and other languages is currently postponed and has not updated to the new chapter selecting system
    // else if (context.read<UserProvider>().userLanguage == 'Japanese') {
    //   question = context
    //       .read<QuestionProvider>()
    //       .dummyJapaneseQuizz[widget.currentChosenStage];
    // }
  }

  void _handleAnswerClick(bool isCorrect) {
    if (isCorrect) {
      userScore++;
    } else {
      question.add(question[currentQuestionIndex]);
    }
    setState(() {
      currentQuestionIndex++;
    });
  }

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

  @override
  void initState() {
    _getQuestions();
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

    if (currentQuestionIndex == question.length) {
      _timer.cancel();
      chosenScreen = ResultScreen(
        userScore: userScore,
        totalScore: question.length,
        oldUserStage: widget.currentChosenStage,
        currentChapter: widget.currentSelectedChapter,
        clearTime: _totalTime.value,
      );
      // clear question
      Future.delayed(Duration(seconds: 2), () {
        question = [];
      });
    } else {
      final currentQuestion = question[currentQuestionIndex];
      if (currentQuestion is MultipleChoiceQuestion) {
        chosenScreen = MultipleChoice(
          question: currentQuestion.question,
          answers: currentQuestion.getShuffledAnswers(),
          correctAnswer: currentQuestion.correctAnswer,
          handleCheckButton: _handleAnswerClick,
          imageAsset: currentQuestion.imageAsset,
        );
      } else if (currentQuestion is ReorderStringQuestion) {
        chosenScreen = ReorderString(
          question: currentQuestion.question,
          answers: currentQuestion.getShuffledAnswers(),
          correctAnswer: currentQuestion.correctAnswer,
          handleCheckButton: _handleAnswerClick,
          imageAsset: currentQuestion.imageAsset,
        );
      } else if (currentQuestion is ConnectStringQuestion) {
        chosenScreen = ConnectString(
          question: currentQuestion.question,
          leftAnswers:
              currentQuestion.getShuffledAnswers(currentQuestion.leftAnswers),
          rightAnswers:
              currentQuestion.getShuffledAnswers(currentQuestion.rightAnswers),
          correctAnswers: currentQuestion.correctAnswers,
          handleCheckButton: _handleAnswerClick,
          imageAsset: currentQuestion.imageAsset,
        );
      } else if (currentQuestion is WordsDistributionQuestion) {
        chosenScreen = WordDistribution(
          question: currentQuestion.question,
          answers: currentQuestion.getShuffledAnswers(currentQuestion.answers),
          group1Name: currentQuestion.group1Name,
          group2Name: currentQuestion.group2Name,
          correctAnswers1: currentQuestion.correctAnswers1,
          correctAnswers2: currentQuestion.correctAnswers2,
          handleCheckButton: _handleAnswerClick,
        );
      } else if (currentQuestion is TranslateQuestion) {
        chosenScreen = GameTranslate(
          question: currentQuestion.question,
          word: currentQuestion.word,
          correctAnswer: currentQuestion.correctAnswer,
          imageAsset: currentQuestion.imageAsset,
          handleCheckButton: _handleAnswerClick,
        );
      } else if (currentQuestion is DropDownQuestion) {
        chosenScreen = DropDownGame(
          question: currentQuestion.question,
          sentenceList: currentQuestion.sentencesList,
          handleCheckButton: _handleAnswerClick,
        );
      } else if (currentQuestion is ReadingQuestion) {
        chosenScreen = ReadingGame(
          paragraphsList: currentQuestion.paragraphsList,
          questionsList: currentQuestion.questionsList,
          title: currentQuestion.title,
          handleCheckPressed: _handleAnswerClick,
        );
      } else {
        chosenScreen = LoadingScreen();
      }
    }

    return Scaffold(
      appBar: chosenScreen is ResultScreen
          ? null
          : AppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  // Spacer(),
                  // Text(
                  //   formattedTime(timeInSecond: _totalTime),
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  ValueListenableBuilder<int>(
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
                ],
              ),
              leading: IconButton(
                onPressed: () {
                  // clear question
                  question = [];
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
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
                    ratio: question.length != 0
                        ? currentQuestionIndex / question.length
                        : 1 / 1),
              ),
              chosenScreen,
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
          // margin: EdgeInsets.symmetric(
          //   // horizontal: screenWidth * 0.05,
          //   horizontal: screenWidth * 0.01,
          //   // right: 20,
          // ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          duration: Duration(milliseconds: 250),
          // child: Container(
          //   // width: 40,
          //   // height: 20,
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //     border: Border.all(color: Colors.blue),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          // ),
        ),
      ],
    );
  }
}
