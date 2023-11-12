import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ConnectString extends StatelessWidget {
  ConnectString(
      {super.key,
      required this.question,
      required this.answers,
      required this.correctAnswer});

  String question;
  List<String> answers;
  String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(question),
          Text(correctAnswer),
        ],
      ),
    );
  }
}
