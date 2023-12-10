import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/src/data/questions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atoz_app/src/providers/question_provider.dart';

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
    showModalBottomSheet(
      // backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      barrierColor: Colors.transparent,
      // expand: true
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 160,
          color: selectedAnswer == widget.correctAnswer
              ? Colors.green
              : Color.fromRGBO(244, 67, 54, 1),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: selectedAnswer == widget.correctAnswer
                          ? Text(
                              'Correct answer',
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              'Wrong answer',
                              style: TextStyle(fontSize: 20),
                            ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: const Text('Next question'),
                      onPressed: () {
                        widget.handleCheckButton(chosenAnswer);
                        setState(() {
                          chosenAnswer = '';
                        });
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            widget.question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Card(child: Container()),
          ),

          // call the Answers buttons and Check button Widget
          // MultipleChoiceButton(
          //   shuffledAnswersList: getShuffledAnswers(widget.answers),
          //   handleCheckButton: handleCheckClick,
          // ),

          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         MultipleChoiceButton(),
          //         MultipleChoiceButton(),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         MultipleChoiceButton(),
          //         MultipleChoiceButton(),
          //       ],
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
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
            height: 100,
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
          // color: Theme.of(context).primaryColor,
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
          // color: Theme.of(context).primaryColor,
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
                  color: Colors.white
                  // color: widget.chosenAnswer.isEmpty
                  //     ? Colors.grey
                  //     : Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

// class MultipleChoiceButton extends StatefulWidget {
//   MultipleChoiceButton(
//       {super.key,
//       required this.shuffledAnswersList,
//       required this.handleCheckButton});

//   List<String> shuffledAnswersList;

//   final void Function(String chosenAnswer) handleCheckButton;

//   @override
//   State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
// }

// class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
//   String currentAnswer = '';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // build the listview buttons from the answers list
//         ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemCount: widget.shuffledAnswersList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ElevatedButton(
//               style: widget.shuffledAnswersList[index] == currentAnswer
//                   ? ElevatedButton.styleFrom(
//                       minimumSize: Size.fromHeight(40),
//                       backgroundColor: Colors.green,
//                     )
//                   : ElevatedButton.styleFrom(
//                       minimumSize: Size.fromHeight(
//                           40), // fromHeight use double.infinity as width and 40 is the height
//                       backgroundColor: Colors.blue,
//                     ),
//               onPressed: () {
//                 setState(() {
//                   currentAnswer = widget.shuffledAnswersList[index];
//                 });
//               },
//               child: Text(
//                 widget.shuffledAnswersList[index],
//                 textAlign: TextAlign.center,
//               ),
//             );
//           },
//         ),
//         SizedBox(height: 50),
//         ElevatedButton(
//           // if there is no answer chosen yet, button function is set to null (grey out)
//           onPressed: currentAnswer.trim().isEmpty
//               ? null
//               : () {
//                   widget.handleCheckButton(currentAnswer);
//                 },
//           style: ElevatedButton.styleFrom(
//             minimumSize: Size.fromHeight(50),
//           ),
//           child: Text('Check'),
//         ),
//       ],
//     );
//   }
// }
