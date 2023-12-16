import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:reorderables/reorderables.dart';

class ReorderString extends StatefulWidget {
  ReorderString({
    super.key,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.handleCheckButton,
    required this.imageAsset,
  });

  String question;
  List<String> answers;
  List<String> correctAnswer;
  String imageAsset;
  void Function(bool isCorrect) handleCheckButton;

  @override
  State<ReorderString> createState() => _ReorderStringState();
}

class _ReorderStringState extends State<ReorderString> {
  late List tempAnswers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempAnswers = widget.answers;
  }

  void onCheckPressed() {
    if (tempAnswers.join(' ') == widget.correctAnswer.join(' ')) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Correct',
        btnOkText: 'Next',
        btnOkOnPress: () {
          // Navigator.pop(context);
          widget.handleCheckButton(true);
        },
        dismissOnTouchOutside: false,
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Wrong',
        desc: 'Correct answer: ${widget.correctAnswer.join(' ')}',
        btnCancelText: 'Next',
        btnCancelOnPress: () {
          // Navigator.pop(context);
          widget.handleCheckButton(false);
        },
        dismissOnTouchOutside: false,
      ).show();
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      setState(() {
        final element = tempAnswers.removeAt(oldIndex);
        tempAnswers.insert(newIndex, element);
      });
      print(tempAnswers);
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Container(
  //     child: Column(
  //       children: [
  // Expanded(
  //   child: ReorderableGridAnswers(
  //     data: tempAnswers,
  //     onReorder: onReorder,
  //   ),
  // ),
  //       ],
  //     ),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              widget.question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: SizedBox.fromSize(
              size: Size.fromHeight(300),
              child: Image(
                image: AssetImage('assets/images/stomachache.png'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: WrapExample(
                data: tempAnswers,
                onReorder: onReorder,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CheckButton(onCheckPressed: onCheckPressed),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

/////////////////// WRAP REORDERABLE BUTTONS ///////////////////

class WrapExample extends StatefulWidget {
  const WrapExample({super.key, required this.data, required this.onReorder});

  final List data;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  State<WrapExample> createState() => _WrapExampleState();
}

class _WrapExampleState extends State<WrapExample> {
  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        widget.onReorder(oldIndex, newIndex);
      });
    }

    return ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      padding: const EdgeInsets.all(8),
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
      children: widget.data
          .map((e) => MultipleChoiceButton(key: ValueKey(e), answer: e))
          .toList(),
      onReorderStarted: (int index) {
        //this callback is optional
        debugPrint(
            '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
      },
    );
  }
}

/////////////////// THE BUTTONS THEMSELVES ///////////////////

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
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/////////////////// CHECK BUTTON ///////////////////

class CheckButton extends StatefulWidget {
  const CheckButton({super.key, required this.onCheckPressed});

  final void Function() onCheckPressed;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCheckPressed();
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
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.blue),
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

// class ReorderableGridAnswers extends StatefulWidget {
//   const ReorderableGridAnswers(
//       {super.key, required this.data, required this.onReorder});

//   final List data;
//   final void Function(int oldIndex, int newIndex) onReorder;

//   @override
//   State<ReorderableGridAnswers> createState() => _ReorderableGridAnswersState();
// }

// class _ReorderableGridAnswersState extends State<ReorderableGridAnswers> {
//   @override
//   Widget build(BuildContext context) {
//     // Widget buildItem(String text) {
//     //   return Card(
//     //     elevation: 0,
//     //     key: ValueKey(text),
//     //     child: Text(text),
//     //   );
//     // }

//     return ReorderableGridView.count(
//       physics: NeverScrollableScrollPhysics(),
//       dragEnabled: true,
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       crossAxisCount: widget.data.length <= 4 ? widget.data.length : 4,
//       childAspectRatio: 10 / 4,
//       children: widget.data
//           .map((e) => MultipleChoiceButton(key: ValueKey(e), answer: e))
//           .toList(),
//       // children: widget.data.map((e) => buildItem(e)).toList(),
//       onReorder: (oldIndex, newIndex) {
//         widget.onReorder(oldIndex, newIndex);
//       },
//       // footer: [
//       //   Card(
//       //     child: Center(
//       //       child: Icon(Icons.add),
//       //     ),
//       //   ),
//       // ],
//     );
//   }
// }

// class MultipleChoiceButton extends StatefulWidget {
//   const MultipleChoiceButton({
//     super.key,
//     required this.answer,
//   });

//   final String answer;

//   @override
//   State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
// }

// class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
//   double _padding = 6;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() {
//           _padding = 0;
//         });
//       },
//       onTapCancel: () {
//         setState(() {
//           _padding = 6;
//         });
//       },
//       onTapUp: (_) {
//         setState(() {
//           _padding = 6;
//         });
//       },
//       child: AnimatedContainer(
//         padding: EdgeInsets.only(bottom: _padding),
//         margin: EdgeInsets.only(top: -(_padding - 6)),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         duration: Duration(milliseconds: 50),
//         child: Container(
//           width: double.infinity,
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.blue),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: FittedBox(
//               fit: BoxFit.scaleDown,
//               child: Text(
//                 widget.answer,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
