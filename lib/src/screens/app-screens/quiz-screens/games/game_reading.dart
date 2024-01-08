import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/widgets/check_button.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReadingGame extends StatefulWidget {
  const ReadingGame(
      {super.key,
      required this.paragraphsList,
      required this.questionsList,
      required this.title,
      required this.handleCheckPressed});

  final List<String> paragraphsList;
  final List<ReadingMultipleChoiceQuestion> questionsList;
  final String title;
  final void Function(bool isAnswerCorrect) handleCheckPressed;

  @override
  State<ReadingGame> createState() => _ReadingGameState();
}

class _ReadingGameState extends State<ReadingGame> {
  final _pageController = PageController();

  List<String> chosenAnswers = [];

  void initUserAnswers() {
    for (int i = 0; i < widget.questionsList.length; i++) {
      chosenAnswers.add(widget.questionsList[i].answers[0]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserAnswers();
  }

  void handleCheckButton() {
    for (int i = 0; i < widget.questionsList.length; i++) {
      if (chosenAnswers[i] != widget.questionsList[i].correctAnswer) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Wrong',
          btnCancelText: 'Next',
          btnCancelOnPress: () {
            widget.handleCheckPressed(false);
          },
          dismissOnTouchOutside: false,
        ).show();
        return;
      }
    }
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Correct',
      btnOkText: 'Next',
      btnOkOnPress: () {
        widget.handleCheckPressed(true);
      },
      dismissOnTouchOutside: false,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    print(chosenAnswers);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Expanded(
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  buildParagraphs(),
                  buildQuestionPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildParagraphs() {
    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          'Read the following passage and answer the questions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: widget.paragraphsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.paragraphsList[index],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildQuestionPage() {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: widget.questionsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.questionsList[index].question,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.questionsList[index].answers.length,
                      itemBuilder: (context, answerIndex) {
                        return RadioListTile(
                          title: Text(
                            widget.questionsList[index].answers[answerIndex],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          value:
                              widget.questionsList[index].answers[answerIndex],
                          groupValue: chosenAnswers[index],
                          onChanged: (value) {
                            setState(() {
                              chosenAnswers[index] = value.toString();
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        CheckButton(onCheckPressed: handleCheckButton),
      ],
    );
  }
}
