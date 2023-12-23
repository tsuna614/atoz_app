import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_connect_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/games/game_reorder_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz-screens/result_screen.dart';
import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/questions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

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

    final question = ref.watch(questionsProvider);

    Widget chosenScreen;

    // List<String> getShuffledAnswers() {
    //   final currentQuestion = question[currentQuestionIndex];
    //   // Shuffle the answers if the question is MultipleChoiceQuestion
    //   if (currentQuestion is MultipleChoiceQuestion) {
    //     final shuffledList = List.of(currentQuestion.answers);
    //     shuffledList.shuffle();
    //     return shuffledList;
    //   }
    // }

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
    } else {
      chosenScreen = LoadingScreen();
    }

    // if (currentQuestionIndex == question.length) {
    //   chosenScreen = ResultScreen(userScore: userScore);
    // } else {
    //   chosenScreen = MultipleChoice(
    //     question: question[currentQuestionIndex].question,
    //     answers: getShuffledAnswers(),
    //     correctAnswer: question[currentQuestionIndex].correctAnswer,
    //     handleCheckButton: _handleAnswerClick,
    //     imageAsset: question[currentQuestionIndex].imageAsset,
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('Question ${currentQuestionIndex + 1}'),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: LinearPercentIndicator(
      //     width: MediaQuery.of(context).size.width * 0.7,
      //     lineHeight: 8.0,
      //     percent: currentQuestionIndex / question.length,
      //     progressColor: Colors.blue,
      //     backgroundColor: Colors.white,
      //   ),
      // ),
      // body: SafeArea(child: chosenScreen),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: ProgressBar(
                screenWidth: width,
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
          // padding: EdgeInsets.only(
          //     // right: screenWidth * (1 - 0.16),
          //     // right: 20,
          //     ),
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
