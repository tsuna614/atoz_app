import 'package:atoz_app/src/screens/app-screens/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';

class StageSelectScreen extends StatefulWidget {
  final String chapterName;
  const StageSelectScreen({super.key, required this.chapterName});

  @override
  State<StageSelectScreen> createState() => _StageSelectScreenState();
}

class _StageSelectScreenState extends State<StageSelectScreen> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.chapterName),
      //   backgroundColor: Colors.blue,
      // ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: _buildNodeButtonColumn(context),
          ),
          Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.9],
                    colors: [
                      Colors.lightBlue.shade900,
                      Colors.blue,
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Chapter 1: ${widget.chapterName}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: !show ? 0 : 150,
                child: Container(
                    color: Colors.blue,
                    child: show
                        ? ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Text(
                                "Chapter 1: ${widget.chapterName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Chapter 1: ${widget.chapterName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Chapter 1: ${widget.chapterName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : null),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNodeButtonColumn(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 50,
      itemBuilder: (context, index) {
        // bool isGoingRight = index % 10 == 0 ||
        //     index % 10 == 1 ||
        //     index % 10 == 2 ||
        //     index % 10 == 3 ||
        //     index % 10 == 4;

        double paddingLeft = 0;
        double scale = 40;

        switch (index % 10) {
          case 0:
            paddingLeft = 0 * scale;
            break;
          case 1:
            paddingLeft = 1 * scale;
            break;
          case 2:
            paddingLeft = 2 * scale;
            break;
          case 3:
            paddingLeft = 3 * scale;
            break;
          case 4:
            paddingLeft = 4 * scale;
            break;
          case 5:
            paddingLeft = 4 * scale;
            break;
          case 6:
            paddingLeft = 3 * scale;
            break;
          case 7:
            paddingLeft = 2 * scale;
            break;
          case 8:
            paddingLeft = 1 * scale;
            break;
          case 9:
            paddingLeft = 0 * scale;
            break;
          default:
        }

        return Padding(
          // padding: const EdgeInsets.symmetric(vertical: 16.0),
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
            left: paddingLeft,
            right: 4 * scale - paddingLeft,
          ),
          child: Align(
            alignment: Alignment.center,
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
