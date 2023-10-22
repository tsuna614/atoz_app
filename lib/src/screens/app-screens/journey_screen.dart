import 'package:atoz_app/src/screens/app-screens/quiz-screens/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const QuizScreen()),
          //     );
          //   },
          //   child: Text('Question Page'),
          // ),
          RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizScreen()),
              );
            },
            elevation: 2.0,
            fillColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
            child: Icon(
              FontAwesomeIcons.question,
              size: 35.0,
            ),
          )
        ],
      ),
    );
  }
}
