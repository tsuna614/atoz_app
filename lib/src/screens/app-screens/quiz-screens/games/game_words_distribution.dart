import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Word {
  const Word({
    required this.content,
  });
  final String content;
}

class WordDistribution extends StatefulWidget {
  const WordDistribution({
    super.key,
    required this.question,
    required this.answers,
    required this.correctAnswers1,
    required this.correctAnswers2,
    required this.handleCheckButton,
  });

  final String question;
  final List<String> answers;
  final List<String> correctAnswers1;
  final List<String> correctAnswers2;
  final void Function(bool correctAnswers) handleCheckButton;

  @override
  State<WordDistribution> createState() => _WordDistributionState();
}

class _WordDistributionState extends State<WordDistribution> {
  final List<Word> _answersList = [];
  List<Word> _answers1List = [];
  List<Word> _answers2List = [];

  void getAnswersList() {
    for (int i = 0; i < widget.answers.length; i++) {
      _answersList.add(Word(content: widget.answers[i]));
      // _answers1List.add(Word(content: widget.correctAnswers1[i]));
    }
  }

  void onCheckPressed() {
    for (int i = 0; i < _answers1List.length; i++) {
      if (!widget.correctAnswers1.contains(_answers1List[i].content)) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Wrong',
          btnCancelText: 'Next',
          btnCancelOnPress: () {
            widget.handleCheckButton(false);
          },
          dismissOnTouchOutside: false,
        ).show();
        return;
      }
    }
    for (int i = 0; i < _answers2List.length; i++) {
      if (!widget.correctAnswers2.contains(_answers2List[i].content)) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Wrong',
          btnCancelText: 'Next',
          btnCancelOnPress: () {
            widget.handleCheckButton(false);
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
        widget.handleCheckButton(true);
      },
      dismissOnTouchOutside: false,
    ).show();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnswersList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
          ),
          buildTitleDivider('Past tense'),
          DragTarget<Word>(
            builder: (context, candidateData, rejectedData) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    child: buildDraggableAnswers(_answers1List),
                  ),
                ),
              );
            },
            onAccept: (item) {
              if (!_answers1List.contains(item)) {
                setState(() {
                  _answers1List.add(item);
                  _answers2List.remove(item);
                  _answersList.remove(item);
                });
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          buildTitleDivider('Past participle'),
          DragTarget<Word>(
            builder: (context, candidateData, rejectedData) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    child: buildDraggableAnswers(_answers2List),
                  ),
                ),
              );
            },
            onAccept: (item) {
              if (!_answers2List.contains(item)) {
                setState(() {
                  _answers2List.add(item);
                  _answers1List.remove(item);
                  _answersList.remove(item);
                });
              }
            },
          ),
          Expanded(child: Container()),
          buildDraggableAnswers(_answersList),
          SizedBox(
            height: 20,
          ),
          CheckButton(
            isAllAnswersChosen: _answersList.isEmpty,
            onCheckPressed: onCheckPressed,
          ),
        ],
      ),
    );
  }

  Widget buildDraggableAnswers(List<Word> answersList) {
    return Wrap(
      children: [
        for (int i = 0; i < answersList.length; i++)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: DraggableAnswer(
              word: answersList[i],
            ),
          ),
      ],
    );
  }

  Widget buildTitleDivider(String title) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

///////////////// CHECK BUTTON /////////////////

class CheckButton extends StatefulWidget {
  const CheckButton(
      {super.key,
      required this.isAllAnswersChosen,
      required this.onCheckPressed});

  final bool isAllAnswersChosen;

  final void Function() onCheckPressed;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isAllAnswersChosen ? widget.onCheckPressed : null,
      onTapDown: (_) {
        if (widget.isAllAnswersChosen) {
          setState(() {
            _padding = 0;
          });
        }
      },
      onTapUp: (_) {
        if (widget.isAllAnswersChosen) {
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
              // widget.chosenAnswer.isEmpty ? Colors.grey[600] : Colors.blue[700],
              widget.isAllAnswersChosen ? Colors.blue[700] : Colors.grey[600],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            // color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
            color: widget.isAllAnswersChosen ? Colors.blue : Colors.grey,
            border: Border.all(
              // color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
              color: widget.isAllAnswersChosen ? Colors.blue : Colors.grey,
            ),
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

///////////////// DRAG ANSWERS /////////////////

class DraggableAnswer extends StatelessWidget {
  const DraggableAnswer({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Draggable<Word>(
      data: word,
      // child being dragged by cursor
      feedback: buildWordContainer(word.content),
      // child left behind
      // childWhenDragging: Container(
      //   padding: EdgeInsets.all(8),
      //   margin: EdgeInsets.all(8),
      //   color: Colors.grey,
      //   child: Text(
      //     word.content,
      //     style: TextStyle(color: Colors.grey),
      //   ),
      // ),
      childWhenDragging: Container(
          // padding: EdgeInsets.all(8),
          // margin: EdgeInsets.all(8),
          // color: Colors.grey,
          // child: Text(
          //   word.content,
          //   style: TextStyle(color: Colors.grey),
          // ),
          ),
      // original child
      child: buildWordContainer(word.content),
    );
  }

  Widget buildWordContainer(String wordContent) {
    return MultipleChoiceButton(answer: wordContent);
  }
}

class MultipleChoiceButton extends StatefulWidget {
  const MultipleChoiceButton({
    super.key,
    required this.answer,
  });

  final String answer;

  @override
  State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _padding = 6;
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
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  child: Text(
                    widget.answer,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
