import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/data/questions.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              questions[0].question,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 100),
            Expanded(child: SizedBox()),
            ...questions[0].answers.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                            40), // fromHeight use double.infinity as width and 40 is the height
                      ),
                      onPressed: () => {},
                      child: Text(e),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
