import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/result_screen.dart';
import 'package:atoz_app/src/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/src/data/questions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    final question = ref.watch(questionsProvider);

    Widget chosenScreen;

    if (currentQuestionIndex == question.length) {
      chosenScreen = ResultScreen(userScore: userScore);
    } else {
      chosenScreen = MultipleChoice(
        question: question[currentQuestionIndex].question,
        answers: question[currentQuestionIndex].answers,
        correctAnswer: question[currentQuestionIndex].correctAnswer,
        handleCheckButton: _handleAnswerClick,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Question'),
      ),
      body: chosenScreen,
    );
  }
}
