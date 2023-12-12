import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:atoz_app/src/widgets/animated_button_1.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:atoz_app/src/data/questions.dart';
// import 'package:atoz_app/src/providers/question_provider.dart';

class MultipleChoice extends ConsumerStatefulWidget {
  const MultipleChoice(
      {super.key,
      required this.question,
      required this.answers,
      required this.correctAnswer,
      required this.handleCheckButton});

  final String question;
  final List<String> answers;
  final String correctAnswer;
  final void Function(String userAnswer) handleCheckButton;

  @override
  ConsumerState<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends ConsumerState<MultipleChoice> {
  // int currentQuestionIndex = 0;
  // int userScore = 0;

  String chosenAnswer = '';

  List<String> getShuffledAnswers(List<String> answers) {
    final shuffledAnswers = List.of(answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }

  void handleAnswerClick(String answerClicked) {
    setState(() {
      chosenAnswer = answerClicked;
    });
  }

  void handleCheckClick(String selectedAnswer) {
    selectedAnswer == widget.correctAnswer
        ? AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Correct',
            // desc: 'Dialog description here.............',
            btnOkText: 'Next',
            btnOkOnPress: () {
              widget.handleCheckButton(chosenAnswer);
              setState(() {
                chosenAnswer = '';
              });
              // Navigator.pop(context);
            },
          ).show()
        : AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Wrong',
            desc: 'Correct answer: \"${widget.correctAnswer}\"',
            btnCancelText: 'Next',
            btnCancelOnPress: () {
              widget.handleCheckButton(chosenAnswer);
              setState(() {
                chosenAnswer = '';
              });
              // Navigator.pop(context);
            },
          ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            widget.question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox.fromSize(
              size: Size.fromHeight(400),
              child: Image(
                image: AssetImage('assets/images/train.png'),
              ),
            ),
          ),
          Expanded(child: Container()),
          // Expanded(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(20.0),
          //     child: SizedBox.fromSize(
          //       child: Image(
          //         image: AssetImage('assets/images/train.png'),
          //       ),
          //     ),
          //   ),
          // ),
          GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  childAspectRatio: 10 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10),
              // 20px spacing horizontally and vertically between grid items
              children: [
                MultipleChoiceButton(
                  answer: widget.answers[0],
                  chosenAnswer: chosenAnswer,
                  handleAnswerClick: handleAnswerClick,
                ),
                MultipleChoiceButton(
                  answer: widget.answers[1],
                  chosenAnswer: chosenAnswer,
                  handleAnswerClick: handleAnswerClick,
                ),
                MultipleChoiceButton(
                  answer: widget.answers[2],
                  chosenAnswer: chosenAnswer,
                  handleAnswerClick: handleAnswerClick,
                ),
                MultipleChoiceButton(
                  answer: widget.answers[3],
                  chosenAnswer: chosenAnswer,
                  handleAnswerClick: handleAnswerClick,
                ),
              ]),
          SizedBox(
            height: 50,
          ),
          CheckButton(
            chosenAnswer: chosenAnswer,
            onCheckPressed: handleCheckClick,
          ),
        ],
      ),
    );
  }
}

///////////////// MULTIPLE-CHOICE BUTTON /////////////////

class MultipleChoiceButton extends StatefulWidget {
  const MultipleChoiceButton({
    super.key,
    required this.answer,
    required this.chosenAnswer,
    required this.handleAnswerClick,
  });

  final String answer;
  final String chosenAnswer;
  final void Function(String answerClicked) handleAnswerClick;

  @override
  State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.handleAnswerClick(widget.answer);
      },
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapUp: (_) {
        setState(() {
          _padding = 6;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          color:
              widget.answer == widget.chosenAnswer ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: widget.answer == widget.chosenAnswer
                    ? Colors.blue
                    : Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.answer == widget.chosenAnswer
                      ? Colors.blue
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////// CHECK BUTTON /////////////////

class CheckButton extends StatefulWidget {
  const CheckButton(
      {super.key, required this.chosenAnswer, required this.onCheckPressed});

  final String chosenAnswer;

  final void Function(String chosenAnswer) onCheckPressed;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.chosenAnswer.isEmpty
          ? null
          : () {
              widget.onCheckPressed(widget.chosenAnswer);
            },
      onTapDown: (_) {
        if (widget.chosenAnswer.isNotEmpty) {
          setState(() {
            _padding = 0;
          });
        }
      },
      onTapUp: (_) {
        if (widget.chosenAnswer.isNotEmpty) {
          setState(() {
            _padding = 6;
          });
        }
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          color:
              widget.chosenAnswer.isEmpty ? Colors.grey[600] : Colors.blue[700],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
            border: Border.all(
                color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Check answer',
              style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////// NEXT BUTTON /////////////////

class NextButton extends StatefulWidget {
  const NextButton(
      {super.key, required this.color, required this.onNextPressed});

  final String color;

  final void Function() onNextPressed;

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onNextPressed();
      },
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapUp: (_) {
        setState(() {
          _padding = 6;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          color: widget.color == 'red' ? Colors.red[800] : Colors.green[800],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: widget.color == 'red' ? Colors.red : Colors.green,
            border: Border.all(
                color: widget.color == 'red' ? Colors.red : Colors.green),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
