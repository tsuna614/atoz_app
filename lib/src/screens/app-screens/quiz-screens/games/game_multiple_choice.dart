import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/src/data/questions.dart';

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  @override
  Widget build(BuildContext context) {
    int currentQuestionIndex = 0;
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: currentQuestionIndex != dummyQuestions.length
          ? Column(
              children: [
                Text(
                  dummyQuestions[currentQuestionIndex].question,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Expanded(child: SizedBox()),
                ...dummyQuestions[currentQuestionIndex]
                    .getShuffledAnswers()
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(
                                40), // fromHeight use double.infinity as width and 40 is the height
                          ),
                          onPressed: () {
                            // _handleAnswerClick(e);
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200,
                                    color: e ==
                                            dummyQuestions[currentQuestionIndex]
                                                .correctAnswer
                                        ? Colors.green
                                        : Colors.red,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text('Modal BottomSheet'),
                                          ElevatedButton(
                                              child: const Text(
                                                  'Close BottomSheet'),
                                              onPressed: () {
                                                _handleAnswerClick(e);
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                });
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
    );
  }
}
