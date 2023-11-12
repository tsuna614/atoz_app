import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.userScore});

  // List<String> chosenAnswers;
  int userScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(userScore.toString()),
      ),
    );
  }
}
