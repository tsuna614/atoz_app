import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:atoz_app/src/widgets/check_button.dart';

class GameTranslate extends StatefulWidget {
  GameTranslate({
    super.key,
    required this.question,
    required this.word,
    required this.correctAnswer,
    required this.imageAsset,
    required this.handleCheckButton,
  });

  final String question;
  final String word;
  final String correctAnswer;
  final String imageAsset;
  final void Function(bool isCorrect) handleCheckButton;

  @override
  State<GameTranslate> createState() => _GameTranslateState();
}

class _GameTranslateState extends State<GameTranslate> {
  final _answerTextField = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _answerTextField.dispose();
  }

  void handleCheckClick(String selectedAnswer) {
    String answer =
        "${selectedAnswer[0].toUpperCase()}${selectedAnswer.substring(1).toLowerCase()}";
    answer == widget.correctAnswer
        ? AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Correct',
            btnOkText: 'Next',
            btnOkOnPress: () {
              widget.handleCheckButton(true);
            },
            dismissOnTouchOutside: false,
          ).show()
        : AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Wrong',
            desc: 'Correct answer: "${widget.correctAnswer}"',
            btnCancelText: 'Next',
            btnCancelOnPress: () {
              widget.handleCheckButton(false);
            },
            dismissOnTouchOutside: false,
          ).show();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          if (widget.imageAsset.isEmpty)
            _buildQuestionType2(screenWidth)
          else
            _buildQuestionType1(),
          Expanded(child: SizedBox()),
          Form(
            child: TextFormField(
              controller: _answerTextField,
              decoration: InputDecoration(
                hintText: 'Enter your answer here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          CheckButton(
            onCheckPressed: () {
              handleCheckClick(_answerTextField.text);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionType1() {
    return Column(
      children: [
        Align(
          alignment: Alignment(0, 0),
          child: Text(
            widget.question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: SizedBox.fromSize(
            size: Size.fromHeight(400),
            child: Image(
              image: AssetImage(widget.imageAsset),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionType2(double screenWidth) {
    return Column(
      children: [
        Align(
          alignment: Alignment(0, 0),
          child: Text(
            widget.question,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 100),
        Card(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: WordButton(
              word: widget.word,
              width: screenWidth,
            ),
          ),
        ),
      ],
    );
  }
}

////////////////// WORD BUTTON //////////////////

class WordButton extends StatefulWidget {
  const WordButton({
    super.key,
    required this.word,
    required this.width,
  });

  final String word;
  final double width;

  @override
  State<WordButton> createState() => _WordButtonState();
}

class _WordButtonState extends State<WordButton> {
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
          // width: widget.width * 0.5,
          // height: widget.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Text(
              widget.word,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
