import 'package:atoz_app/src/screens/app-screens/quiz-screens/result_screen.dart';
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
    if (userAnswer == questions[currentQuestionIndex].correctAnswer) {
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
    print(currentQuestionIndex);
    print(questions.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: currentQuestionIndex != questions.length
            ? Column(
                children: [
                  Text(
                    questions[currentQuestionIndex].question,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: 100),
                  Expanded(child: SizedBox()),
                  ...questions[currentQuestionIndex].getShuffledAnswers().map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(
                                  40), // fromHeight use double.infinity as width and 40 is the height
                            ),
                            onPressed: () {
                              _handleAnswerClick(e);
                            },
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                ],
              )
            : Text(userScore.toString()),
      ),
    );
  }
}
