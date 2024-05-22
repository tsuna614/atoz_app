import 'package:atoz_app/src/models/chapter_model.dart';
import 'package:atoz_app/src/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dio/dio.dart';
import 'package:atoz_app/src/data/global_data.dart' as global_data;
import 'package:provider/provider.dart';

final _firebase = FirebaseAuth.instance;
final dio = Dio();

class ResultScreen extends StatelessWidget {
  ResultScreen({
    super.key,
    required this.userScore,
    required this.totalScore,
    required this.oldUserStage,
    required this.currentChapter,
  });

  final int userScore;
  final int totalScore;
  final int oldUserStage;
  final int currentChapter;
  // List<String> chosenAnswers;

  List<List<Map<String, dynamic>>> convertStagesToJson(
      List<List<StageDetails>> stages) {
    return stages
        .map((innerList) => innerList.map((stage) => stage.toJson()).toList())
        .toList();
  }

  void updateUserData(BuildContext context) async {
    if (oldUserStage ==
        context
            .read<UserProvider>()
            .currentUserProgress[currentChapter]
            .length) {
      context
          .read<UserProvider>()
          .currentUserProgress[currentChapter]
          .add(StageDetails(
            star: convertScoreToStar(),
            clearTime: 90,
          ));
      // increment user score and progression by 20 only if user complete a new stage
      context
          .read<UserProvider>()
          .setUserScore(context.read<UserProvider>().userScore + 20);
      context.read<UserProvider>().setUserProgressionPoint(
          context.read<UserProvider>().userProgressionPoint + 20);
    } else {
      // update the user's star and clear time if they complete the stage again with better score
      if (convertScoreToStar() >
          context
              .read<UserProvider>()
              .currentUserProgress[currentChapter][oldUserStage]
              .star) {
        context.read<UserProvider>().currentUserProgress[currentChapter]
            [oldUserStage] = StageDetails(
          star: convertScoreToStar(),
          clearTime: 90,
        );
      }
    }

    // get the newly updated user progression to be ready to update the database
    List<List<StageDetails>> newUserProgression =
        context.read<UserProvider>().currentUserProgress;

    // update user's stage and score in database
    await dio.put(
      '${global_data.atozApi}/user/editUserById/${_firebase.currentUser!.uid}',
      data: {
        'userStage': convertStagesToJson(newUserProgression),
        'score': context.read<UserProvider>().userScore + 20,
        'progression': context.read<UserProvider>().userProgressionPoint + 20,
      },
    );
  }

  int convertScoreToStar() {
    if (userScore == totalScore) {
      return 3;
    } else if (userScore >= totalScore * 0.7) {
      return 2;
    } else if (userScore >= totalScore * 0.3) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text(
              'Congratulations on completing the test!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your score:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              CircularPercentIndicator(
                radius: 100,
                lineWidth: 10,
                percent: userScore / totalScore,
                animation: true,
                animationDuration: 2000,
                progressColor: Colors.blue,
                center: Text(
                  '${(userScore / totalScore * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: CheckButton(
              onButtonPressed: () async {
                // if user complete the current stage that they are in, only then the current user progress will be updated
                // increment user progress (in provider) by 2, and update user progress in database
                // i did this so it doesn't need to wait to load everytime user complete a stage

                updateUserData(context);
                Navigator.pop(context);
                // Navigator.popUntil(context, (route) => route.isFirst);
                await dio.post(
                  '${global_data.atozApi}/userScore/addUserScore',
                  data: {
                    'userId': _firebase.currentUser!.uid,
                    'score': 20,
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CheckButton extends StatefulWidget {
  const CheckButton({super.key, required this.onButtonPressed});

  final void Function() onButtonPressed;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onButtonPressed,
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
            color: Colors.white,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Return home',
              style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
