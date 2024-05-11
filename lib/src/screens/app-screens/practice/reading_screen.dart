import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_reading.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/result_screen.dart';
import 'package:atoz_app/src/screens/main-screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';
import 'dart:math';

import 'package:provider/provider.dart';

final dio = Dio();

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  Widget chosenScreen = LoadingScreen();
  List<String> paragraphsList = [];
  List<ReadingMultipleChoiceQuestion> questionsList = [];
  String title = '';

  int getRandomLevel(int maxLevel) {
    Random random = Random();
    int randomNumber = random.nextInt(maxLevel);
    return randomNumber;
  }

  void initQuiz() async {
    final userLanguage = context.read<UserProvider>().userLanguage;
    final userProgression = context.read<UserProvider>().userProgressionPoint;

    final response = await dio
        .get('${global.atozApi}/readingQuiz/getAllQuizzesWithCondition', data: {
      'language': userLanguage,
      'userProgression': userProgression,
    });
    final data = response.data.length;
    int randomLevel = getRandomLevel(data);
    title = response.data[randomLevel]['title'];
    for (int i = 0;
        i < response.data[randomLevel]['paragraphsList'].length;
        i++) {
      paragraphsList
          .add(response.data[randomLevel]['paragraphsList'][i].toString());
    }
    ;
    for (int i = 0;
        i < response.data[randomLevel]['questionsList'].length;
        i++) {
      final response2 = await dio.get(
          '${global.atozApi}/readingMultipleChoice/getQuizById/${response.data[randomLevel]['questionsList'][i]}');
      // List<String> responseAnswers = response2.data['answers'];
      List<String> responseAnswers = [];
      for (int j = 0; j < response2.data['answers'].length; j++) {
        responseAnswers.add(response2.data['answers'][j].toString());
      }
      questionsList.add(
        ReadingMultipleChoiceQuestion(
            question: response2.data['question'],
            answers: responseAnswers,
            correctAnswer: response2.data['correctAnswer']),
      );
    }
    setState(() {
      chosenScreen = buildReadingScreen();
    });
  }

  void handleCheckButtonPressed(bool isCorrect) {
    setState(() {
      chosenScreen = buildResultScreen(isCorrect);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return chosenScreen;
  }

  Widget buildReadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Practice'),
        elevation: 0,
      ),
      body: SafeArea(
        child: ReadingGame(
          paragraphsList: paragraphsList,
          questionsList: questionsList,
          title: title,
          handleCheckPressed: handleCheckButtonPressed,
        ),
      ),
    );
  }

  Widget buildResultScreen(bool isCorrect) {
    return Scaffold(
      body: SafeArea(
        child: ResultScreen(
          userScore: isCorrect ? 1 : 0,
          totalScore: 1,
          oldUserStage: 0,
        ),
      ),
    );
  }
}
