import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_connect_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_reorder_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_words_distribution.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/result_screen.dart';
import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/questions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key, required this.currentState});

  final int currentState;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int currentQuestionIndex = 0;

  // List<String> chosenAnswers = [];

  int userScore = 0;

  void _handleAnswerClick(bool isCorrect) {
    if (isCorrect) {
      userScore++;
    }
    setState(() {
      currentQuestionIndex++;
    });
    // final currentQuestion = ref.read(questionsProvider)[currentQuestionIndex];
    // if (currentQuestion is MultipleChoiceQuestion) {
    //   if (userAnswer == currentQuestion.correctAnswer) {
    //     userScore++;
    //   }
    // } else if (currentQuestion is ReorderStringQuestion) {
    //   if (userAnswer == currentQuestion.correctAnswer.join(' ')) {
    //     userScore++;
    //   }
    // } else if (currentQuestion is ConnectStringQuestion) {
    //   if (userAnswer == currentQuestion.correctAnswer) {
    //     userScore++;
    //   }
    // }
    // if (userAnswer == dummyQuestions[currentQuestionIndex].correctAnswer) {
    //   userScore++;
    // }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final question = ref.watch(questionsProvider)[widget.currentState];
    // send an index to the provider

    late Widget chosenScreen;

    /* TEST START */
    // final currentQuestion = question[0];
    // if (currentQuestion is WordsDistributionQuestion) {
    //   chosenScreen = WordDistribution(
    //     question: currentQuestion.question,
    //     answers: currentQuestion.answers,
    //     correctAnswers1: currentQuestion.correctAnswers1,
    //     correctAnswers2: currentQuestion.correctAnswers2,
    //     handleCheckButton: _handleAnswerClick,
    //   );
    // }
    /* TEST END */

    if (currentQuestionIndex == question.length) {
      chosenScreen = ResultScreen(
        userScore: userScore,
        totalScore: question.length,
        oldUserStage: widget.currentState,
      );
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
          answers: currentQuestion.answers,
          correctAnswers1: currentQuestion.correctAnswers1,
          correctAnswers2: currentQuestion.correctAnswers2,
          handleCheckButton: _handleAnswerClick,
        );
      } else {
        chosenScreen = LoadingScreen();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('Question ${currentQuestionIndex + 1}'),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: ProgressBar(
                screenWidth: width - 80,
                ratio: currentQuestionIndex / question.length),
          ),
          chosenScreen,
        ],
      )),
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
