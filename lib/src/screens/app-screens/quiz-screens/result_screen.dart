import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dio/dio.dart';
import 'package:atoz_app/src/data/global_data.dart' as global_data;

final _firebase = FirebaseAuth.instance;
final dio = Dio();

class ResultScreen extends StatelessWidget {
  ResultScreen(
      {super.key,
      required this.userScore,
      required this.totalScore,
      required this.oldUserStage});

  final int userScore;
  final int totalScore;
  final int oldUserStage;
  // List<String> chosenAnswers;

  void handleReturnHomePressed(BuildContext context) async {
    print(oldUserStage + 2);
    await dio.put(
      '${global_data.atozApi}/user/editUserById/${_firebase.currentUser!.uid}',
      data: {
        'userStage': oldUserStage + 2,
      },
    );
    print('Success');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircularPercentIndicator(
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: CheckButton(
              onButtonPressed: () {
                handleReturnHomePressed(context);
                Navigator.pop(context);
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
