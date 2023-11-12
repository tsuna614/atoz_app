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
  @override
  Widget build(BuildContext context) {
    final question = ref.watch(questionsProvider);

    int currentQuestionIndex = 0;
    int userScore = 0;

    List<String> getShuffledAnswers(List<String> answers) {
      final shuffledAnswers = List.of(answers);
      shuffledAnswers.shuffle();
      return shuffledAnswers;
    }

    // void handleAnswerClick(String chosenAnswer) {
    //   setState(() {
    //     currentAnswer = chosenAnswer;
    //   });
    // }

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Stack(
          children: [
            Text(
              widget.question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // Expanded(child: SizedBox()),
            // ...dummyQuestions[currentQuestionIndex].getShuffledAnswers().map(
            // ...getShuffledAnswers(widget.answers).map(
            //   (e) => Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 6),
            //     child: MultipleChoiceButton(answerText: e),
            //   ),
            // ),
            MultipleChoiceButton(
                shuffledAnswersList: getShuffledAnswers(widget.answers)),
            // Expanded(child: SizedBox()),
            Positioned(
              bottom: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Check'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
              ),
            ),
          ],
        ));
  }
}

String currentAnswer = '';

class MultipleChoiceButton extends StatefulWidget {
  MultipleChoiceButton({super.key, required this.shuffledAnswersList});

  List<String> shuffledAnswersList;

  @override
  State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.shuffledAnswersList.length,
      itemBuilder: (BuildContext context, int index) {
        return ElevatedButton(
          style: widget.shuffledAnswersList[index] == currentAnswer
              ? ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  backgroundColor: Colors.green,
                )
              : ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(
                      40), // fromHeight use double.infinity as width and 40 is the height
                  // backgroundColor: Colors.blue,
                ),
          onPressed: () {
            setState(() {
              currentAnswer = widget.shuffledAnswersList[index];
            });
          },
          child: Text(
            widget.shuffledAnswersList[index],
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

// showModalBottomSheet(
//   context: context,
//   builder: (BuildContext context) {
//     return Container(
//       height: 200,
//       color: e == widget.correctAnswer
//           ? Colors.green
//           : Color.fromRGBO(244, 67, 54, 1),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Text('Modal BottomSheet'),
//             ElevatedButton(
//                 child: const Text('Close BottomSheet'),
//                 onPressed: () {
//                   widget.handleCheckButton(e);
//                   Navigator.pop(context);
//                 }),
//           ],
//         ),
//       ),
//     );
//   },
// );