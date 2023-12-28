import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WordDistribution extends StatefulWidget {
  WordDistribution({
    super.key,
    required this.question,
    required this.answers,
    required this.correctAnswers1,
    required this.correctAnswers2,
    required this.handleCheckButton,
  });

  String question;
  List<String> answers;
  List<String> correctAnswers1;
  List<String> correctAnswers2;
  void Function(bool correctAnswers) handleCheckButton;

  @override
  State<WordDistribution> createState() => _WordDistributionState();
}

class _WordDistributionState extends State<WordDistribution> {
  @override
  Widget build(BuildContext context) {
    return DraggableAnswer(
      answer: widget.answers[0],
    );
  }
}

///////////////// MULTIPLE CHOICE BUTTON /////////////////

class MultipleChoiceButton extends StatefulWidget {
  const MultipleChoiceButton({
    super.key,
    required this.answer,
    required this.chosenAnswers,
    required this.handleAnswerClick,
  });

  final String answer;
  final List<String> chosenAnswers;
  final void Function(String answerClicked) handleAnswerClick;

  @override
  State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  double _padding = 6;

  int indexOfAnswerInChosenAnswers(String answer) {
    return widget.chosenAnswers.indexOf(answer);
  }

  @override
  Widget build(BuildContext context) {
    int indexValue = indexOfAnswerInChosenAnswers(widget.answer);

    return GestureDetector(
      onTap: () {
        widget.handleAnswerClick(widget.answer);
      },
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
          color: indexValue == -1
              ? Colors.grey
              : indexValue == 0
                  ? Colors.red
                  : indexValue == 1
                      ? Colors.yellow[700]
                      : indexValue == 2
                          ? Colors.orange[600]
                          : Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Stack(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: indexValue == -1
                      ? Colors.grey
                      : indexValue == 0
                          ? Colors.red
                          : indexValue == 1
                              ? Colors.yellow.shade700
                              : indexValue == 2
                                  ? Colors.orange.shade600
                                  : Colors.green,
                ),
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
                      color: indexValue == -1
                          ? Colors.grey
                          : indexValue == 0
                              ? Colors.red
                              : indexValue == 1
                                  ? Colors.yellow[700]
                                  : indexValue == 2
                                      ? Colors.yellow[700]
                                      : Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -1),
              child: Container(
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    indexValue == -1
                        ? ''
                        : indexValue == 0
                            ? '1'
                            : indexValue == 1
                                ? '2'
                                : indexValue == 2
                                    ? '3'
                                    : '4',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white,
                      color: indexValue == -1
                          ? Colors.grey
                          : indexValue == 0
                              ? Colors.red
                              : indexValue == 1
                                  ? Colors.yellow[700]
                                  : indexValue == 2
                                      ? Colors.orange[600]
                                      : Colors.green,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
