import 'package:atoz_app/src/screens/app-screens/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';

class StageSelectScreen extends StatefulWidget {
  final int chapterIndex;
  final String chapterName;
  const StageSelectScreen(
      {super.key, required this.chapterIndex, required this.chapterName});

  @override
  State<StageSelectScreen> createState() => _StageSelectScreenState();
}

class _StageSelectScreenState extends State<StageSelectScreen>
    with SingleTickerProviderStateMixin {
  bool show = false;

  // OVERLAY PORTAL PROPERTIES
  final _overlayController = OverlayPortalController();
  late double _overlayChildPositionX;
  late double _overlayChildPositionY;

  late AnimationController _animationController;
  late Animation _animation;

  late int currentChosenStage;

  @override
  void initState() {
    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    // Define the Animation
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOverlayChild(Offset globalPosition, int index) {
    setState(() {
      // show the overlay
      _overlayController.toggle();
      _overlayChildPositionX = globalPosition.dx;
      _overlayChildPositionY = globalPosition.dy;

      // this is to make sure the overlay child doesn't get rendered outside of the screen
      if (_overlayChildPositionX < 125) {
        _overlayChildPositionX = 125;
      } else if (_overlayChildPositionX >
          MediaQuery.of(context).size.width - 125) {
        _overlayChildPositionX = MediaQuery.of(context).size.width - 125;
      }

      // fading animation
      if (!_animationController.isCompleted) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }

      // set the current chosen stage
      currentChosenStage = index;
    });
  }

  void _pushToLevel() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          currentStage: currentChosenStage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Chapter ${widget.chapterIndex + 1}: ${widget.chapterName}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: GestureDetector(
        onTapDown: (details) {
          if (_overlayController.isShowing) {
            _overlayController.hide();
            _animationController.reverse();
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: OverlayPortal(
                controller: _overlayController,
                overlayChildBuilder: ((context) {
                  return Positioned(
                    left: _overlayChildPositionX - 125,
                    top: _overlayChildPositionY + 20,
                    child: ScaleTransition(
                      scale: _animation as Animation<double>,
                      // opacity: _animation as Animation<double>,
                      child: Card(
                        child: Container(
                          width: 250,
                          // height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 8, left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 50,
                                      color: Colors.yellow.shade600,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 50,
                                      color: Colors.yellow.shade600,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 50,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ],
                                ),
                              ),
                              _buildStageDetails(context),
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: AnimatedButton1(
                                  buttonText: "Start level",
                                  height: 40,
                                  onPressed: () {
                                    _pushToLevel();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                child: _buildNodeButtonColumn(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageDetails(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Stage:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentChosenStage.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Clear time:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "19:20",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
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

        return Stack(
          children: [
            if (index + 1 % 10 == 0 && index != 0)
              Padding(
                padding: EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                  left: 4 * scale - paddingLeft,
                  right: paddingLeft,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: GameNodeButton(
                    index: index,
                    userProgress: 100,
                    toggleChildOverlay: _toggleOverlayChild,
                  ),
                ),
              ),
            Padding(
              // padding: const EdgeInsets.symmetric(vertical: 16.0),
              padding: EdgeInsets.only(
                top: 16.0,
                bottom: 16.0,
                left: paddingLeft,
                right: 4 * scale - paddingLeft,
              ),
              child: Align(
                child: GameNodeButton(
                  index: index,
                  userProgress: 5,
                  toggleChildOverlay: _toggleOverlayChild,
                ),
              ),
            ),
          ],
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
    required this.toggleChildOverlay,
  });

  final int index;
  final int userProgress;
  final Function(Offset, int) toggleChildOverlay;

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
      // onTap: widget.index > widget.userProgress
      //     ? null
      //     : () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => QuizScreen(
      //               currentStage: widget.index - 1,
      //             ),
      //           ),
      //         );
      //       },
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
      onTapUp: (details) {
        if (widget.index <= widget.userProgress) {
          widget.toggleChildOverlay(details.globalPosition, widget.index);
        }
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

class AnimatedButton1 extends StatefulWidget {
  const AnimatedButton1(
      {super.key,
      required this.buttonText,
      required this.height,
      required this.onPressed});

  final String buttonText;
  final double height;
  final void Function() onPressed;

  @override
  State<AnimatedButton1> createState() => _AnimatedButton1State();
}

class _AnimatedButton1State extends State<AnimatedButton1> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
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
          // color: Theme.of(context).primaryColor,
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue.shade800),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
