import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_connect_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_drop_down.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_multiple_choice.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_reading.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_reorder_string.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_translate.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_words_distribution.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/result_screen.dart';
import 'package:atoz_app/src/screens/main-screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  int userScore = 0;
  int currentQuestionIndex = 0;
  List<QuizQuestion> question = [];
  late Widget chosenScreen;

  void getQuestions() {
    question = context.read<QuestionProvider>().dummyWritingQuizz;
  }

  void _handleAnswerClick(bool isCorrect) {
    if (isCorrect) {
      userScore++;
    }
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (currentQuestionIndex == question.length) {
      chosenScreen = ResultScreen(
        userScore: userScore,
        totalScore: question.length,
        oldUserStage: 0,
        currentChapter: 0,
        clearTime: 0,
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text('Question ${currentQuestionIndex + 1}'),
        leading: IconButton(
          onPressed: () {
            // clear question
            question = [];
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
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
                  ratio: question.length != 0
                      ? currentQuestionIndex / question.length
                      : 1 / 1),
            ),
            chosenScreen,
          ],
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
