import 'package:atoz_app/src/screens/app-screens/quiz-screens/quiz_screen.dart';
import 'package:flutter/material.dart';

class StageSelectScreen extends StatefulWidget {
  final String chapterName;
  const StageSelectScreen({super.key, required this.chapterName});

  @override
  State<StageSelectScreen> createState() => _StageSelectScreenState();
}

class _StageSelectScreenState extends State<StageSelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: _buildNodeButtonColumn(context),
      ),
    );
  }

  Widget _buildNodeButtonColumn(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          // padding: const EdgeInsets.symmetric(vertical: 16.0),
          padding: EdgeInsets.only(
              top: 16.0, bottom: 16.0, left: index * 100, right: 40),
          child: Align(
            child: GameNodeButton(
              index: index,
              userProgress: 5,
            ),
          ),
        );
      },
    );
  }
}

///////////////// GAME NODE BUTTON BUTTON /////////////////

class GameNodeButton extends StatefulWidget {
  const GameNodeButton({
    super.key,
    required this.index,
    required this.userProgress,
  });

  final int index;
  final int userProgress;

  @override
  State<GameNodeButton> createState() => _GameNodeButtonState();
}

class _GameNodeButtonState extends State<GameNodeButton> {
  double _padding = 6;

  double width = 70;
  double height = 60;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.index > widget.userProgress
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    currentStage: widget.index - 1,
                  ),
                ),
              );
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
          color: widget.index < widget.userProgress
              ? Colors.green
              : widget.index == widget.userProgress
                  ? Colors.blue
                  : Colors.grey,
          // color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: widget.index < widget.userProgress
                  ? Colors.green
                  : widget.index == widget.userProgress
                      ? Colors.blue
                      : Colors.grey,
              // color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(Radius.elliptical(width, height)),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              // question mark icon as child
              // child: Icon(
              //   FontAwesomeIcons.question,
              //   size: 35.0,
              // ),
              child: widget.index < widget.userProgress
                  ? Icon(Icons.check, color: Colors.green, size: 35.0)
                  : widget.index == widget.userProgress
                      ? Text(
                          widget.index.toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        )
                      : Icon(Icons.lock, color: Colors.grey, size: 35.0),
            ),
          ),
        ),
      ),
    );
  }
}
