import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConnectString extends StatefulWidget {
  ConnectString({
    super.key,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.handleCheckButton,
  });

  String question;
  List<String> answers;
  String correctAnswer;
  void Function(String userAnswer) handleCheckButton;

  @override
  State<ConnectString> createState() => _ConnectStringState();
}

class _ConnectStringState extends State<ConnectString> {
  // final List myTiles = ['A', 'B', 'C', 'D'];

  String chosenAnswer = '';

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
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
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
            height: 50,
          ),
          Card(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
              ),
            ),
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: answers.length,
          //   itemBuilder: (context, index) =>
          //       DraggableAnswer(answer: answers[index]),
          /* */
          // ReorderableListView.builder(
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) => ListTile(
          //     key: ValueKey(widget.answers[index]),
          //     tileColor: Colors.grey,
          //     title: Text(widget.answers[index]),
          //   ),
          //   itemCount: widget.answers.length,
          //   onReorder: ((oldIndex, newIndex) => {}),
          // ),
          Expanded(child: Container()),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              for (final answer in widget.answers)
                Chip(
                    label: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 30,
                    // color: Colors.black,
                  ),
                ))
              // Chip(
              //   label: Text('Hamilton'),
              // ),
              // Chip(
              //   label: Text('Lafayette'),
              // ),
              // Chip(
              //   label: Text('Mullilkmblsdfmbdskmbgan'),
              // ),
              // Chip(
              //   label: Text('Laurens'),
              // ),
            ],
          ),
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
    // return ReorderableListView(
    //   physics: NeverScrollableScrollPhysics(),
    //   children: [
    //     for (final tile in myTiles)
    //       ListTile(
    //         key: ValueKey(tile),
    //         title: Text(tile),
    //         trailing: ReorderableDragStartListener(
    //           index: myTiles.indexOf(tile),
    //           child: const Icon(Icons.drag_handle),
    //         ),
    //       )
    //   ],
    //   onReorder: (oldIndex, newIndex) => {},
    // );
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
/////////////////  /////////////////

class DraggableAnswer extends StatelessWidget {
  const DraggableAnswer({super.key, required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Material(
        child: Container(
          padding: EdgeInsets.all(8),
          // margin: EdgeInsets.all(8),
          color: Colors.grey,
          child: Text(answer),
        ),
      ),
      // childWhenDragging: Container(
      //   padding: EdgeInsets.all(8),
      //   margin: EdgeInsets.all(8),
      //   color: Colors.grey,
      //   child: Text(answer),
      // ),
      childWhenDragging: Container(),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        color: Colors.grey,
        child: Text(answer),
      ),
    );
  }
}

class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableExampleState();
}

class _ReorderableExampleState extends State<ReorderableExample> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final Color oddItemColor = Colors.lime.shade100;
    final Color evenItemColor = Colors.deepPurple.shade100;

    final List<Card> cards = <Card>[
      for (int index = 0; index < _items.length; index += 1)
        Card(
          key: Key('$index'),
          color: _items[index].isOdd ? oddItemColor : evenItemColor,
          child: SizedBox(
            height: 80,
            child: Center(
              child: Text('Card ${_items[index]}'),
            ),
          ),
        ),
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(1, 6, animValue)!;
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            // Create a Card based on the color and the content of the dragged one
            // and set its elevation to the animated value.
            child: Card(
              elevation: elevation,
              color: cards[index].color,
              child: cards[index].child,
            ),
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      proxyDecorator: proxyDecorator,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
      children: [
        for (final card in cards)
          ListTile(
            key: ValueKey(card),
            title: card,
            trailing: ReorderableDragStartListener(
              index: cards.indexOf(card),
              child: const Icon(Icons.drag_handle),
            ),
          )
      ],
    );
  }
}
