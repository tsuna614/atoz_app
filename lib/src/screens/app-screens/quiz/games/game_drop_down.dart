import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropDownGame extends StatefulWidget {
  const DropDownGame(
      {super.key,
      required this.question,
      required this.sentenceList,
      required this.handleCheckButton});

  final String question;
  final List<DropDownQuestionChild> sentenceList;
  final void Function(bool) handleCheckButton;

  @override
  State<DropDownGame> createState() => _DropDownGameState();
}

class _DropDownGameState extends State<DropDownGame> {
  List<String> userAnswers = [];

  void initUserAnswers() {
    for (int i = 0; i < widget.sentenceList.length; i++) {
      userAnswers.add(widget.sentenceList[i].answers[0]);
    }
  }

  void onCheckPressed() {
    for (int i = 0; i < widget.sentenceList.length; i++) {
      if (userAnswers[i] != widget.sentenceList[i].correctAnswer) {
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
    initUserAnswers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              widget.question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: ListView.builder(
              itemCount: widget.sentenceList.length,
              itemBuilder: (context, index) {
                return buildSentence(widget.sentenceList[index], index);
              },
            ),
          ),
          SizedBox(height: 20),
          CheckButton(
            isAllAnswersChosen: true,
            onCheckPressed: onCheckPressed,
          ),
        ],
      ),
    );
  }

  Widget buildSentence(DropDownQuestionChild sentence, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${index.toString()}.     ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              sentence.sentence1,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 20),
            buildDropDownButton(sentence.answers, index),
            SizedBox(width: 20),
            Text(
              sentence.sentence2,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropDownButton(List<String> answers, int index) {
    // return DropdownButton(
    //   value: userAnswers[index],
    //   onChanged: (value) {
    //     setState(() {
    //       userAnswers[index] = value!;
    //     });
    //   },
    //   items: answers.map((answer) {
    //     return DropdownMenuItem(
    //       value: answer,
    //       child: Padding(
    //         padding: const EdgeInsets.all(0),
    //         child: Text(answer, style: TextStyle(fontSize: 20)),
    //       ),
    //     );
    //   }).toList(),
    // );
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: userAnswers[index],
          onChanged: (value) {
            setState(() {
              userAnswers[index] = value as String;
            });
          },
          items: answers.map((answer) {
            return DropdownMenuItem(
              value: answer,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(answer, style: TextStyle(fontSize: 16)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

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
