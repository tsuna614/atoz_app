import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/result_screen.dart';
import 'package:atoz_app/src/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/src/data/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;

  // List<String> chosenAnswers = [];

  int userScore = 0;

  void _handleAnswerClick(String userAnswer) {
    if (userAnswer == dummyQuestions[currentQuestionIndex].correctAnswer) {
      userScore++;
    }
    setState(() {
      currentQuestionIndex++;
    });
    // if (currentQuestionIndex < questions.length - 1) {
    //   setState(() {
    //     currentQuestionIndex++;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Question'),
        ),
        body: ResultScreen(
          chosenAnswers: [],
        ));
  }
}
