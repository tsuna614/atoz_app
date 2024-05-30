import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class ListeningTest2 extends StatefulWidget {
  final String fullSentence;
  final List<String> answers;
  final String audioPublicId;
  final void Function(bool) handleCheckButton;

  const ListeningTest2({
    super.key,
    required this.fullSentence,
    required this.answers,
    required this.audioPublicId,
    required this.handleCheckButton,
  });

  @override
  State<ListeningTest2> createState() => _ListeningTest2State();
}

class _ListeningTest2State extends State<ListeningTest2> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // listen to states: playing, paused, stopped
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // listen to audio duration
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // listen to audio position
    player.onPositionChanged.listen((newDuration) {
      setState(() {
        position = newDuration;
      });
    });
  }

  @override
  void didUpdateWidget(covariant ListeningTest2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.audioPublicId != widget.audioPublicId) {
      player.stop();
    }
    textController.clear();
  }

  void onCheckPressed() {
    String answer = widget.fullSentence;
    // remove the last period from the answer if the user didn't type it
    if (widget.fullSentence.endsWith('.') &&
        !textController.text.endsWith('.')) {
      answer = widget.fullSentence.substring(
        0,
        widget.fullSentence.length - 1,
      );
    }
    if (textController.text.trim().toLowerCase() ==
        answer.trim().toLowerCase()) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Correct',
        btnOkText: 'Next',
        btnOkOnPress: () {
          // Navigator.pop(context);
          widget.handleCheckButton(true);
        },
        dismissOnTouchOutside: false,
      ).show();
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Wrong',
        desc: 'Correct answer: ${widget.answers.join(' ')}',
        btnCancelText: 'Next',
        btnCancelOnPress: () {
          // Navigator.pop(context);
          widget.handleCheckButton(false);
        },
        dismissOnTouchOutside: false,
      ).show();
    }
  }

  void playAudio() {
    String url =
        "https://res.cloudinary.com/dm3q8bw0w/video/upload/audio/${widget.audioPublicId}.wav";
    player.stop();
    player.setVolume(1.0);
    player.play(
      UrlSource(url),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Listen to the audio and write down what you hear.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Center(
              child: AudioButton(onCheckPressed: playAudio),
            ),
          ),
          Slider(
            min: 0,
            max: duration.inMilliseconds.toDouble(),
            value: position.inMilliseconds.toDouble(),
            activeColor: Colors.blue,
            onChanged: (value) {},
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: TextField(
                maxLines: 10,
                controller: textController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                  hintText: 'Type your answer here',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CheckButton(onCheckPressed: onCheckPressed),
          // SizedBox(
          //   height: 50,
          // ),
        ],
      ),
    );
  }
}

/////////////////// ANIMATED BUTTONS ///////////////////

class AudioButton extends StatefulWidget {
  const AudioButton({super.key, required this.onCheckPressed});

  final void Function() onCheckPressed;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCheckPressed();
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
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Icon(Icons.volume_up_rounded, color: Colors.blue, size: 80),
          ),
        ),
      ),
    );
  }
}

class CheckButton extends StatefulWidget {
  const CheckButton({super.key, required this.onCheckPressed});

  final void Function() onCheckPressed;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCheckPressed();
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
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Check answer',
              style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
