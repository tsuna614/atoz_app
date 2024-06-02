import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reorderables/reorderables.dart';

class ListeningTest extends StatefulWidget {
  final String fullSentence;
  final List<String> answers;
  final String audioPublicId;
  final void Function(bool) handleCheckButton;

  const ListeningTest({
    super.key,
    required this.fullSentence,
    required this.answers,
    required this.audioPublicId,
    required this.handleCheckButton,
  });

  @override
  State<ListeningTest> createState() => _ListeningTestState();
}

class _ListeningTestState extends State<ListeningTest> {
  late List userAnswers;
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    shuffleAnswers();

    if (context.mounted) {
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
  }

  // holy cow this took me a fuck ton of time to figure out
  @override
  void didUpdateWidget(covariant ListeningTest oldWidget) {
    shuffleAnswers();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    // player.dispose();
  }

  void shuffleAnswers() {
    setState(() {
      userAnswers = widget.answers.toList()..shuffle();
    });
  }

  void onCheckPressed() {
    if (userAnswers.join(' ') == widget.answers.join(' ')) {
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

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      final element = userAnswers.removeAt(oldIndex);
      userAnswers.insert(newIndex, element);
    });
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
              child: WrapExample(
                data: userAnswers,
                onReorder: onReorder,
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

/////////////////// WRAP REORDERABLE BUTTONS ///////////////////

class WrapExample extends StatefulWidget {
  const WrapExample({super.key, required this.data, required this.onReorder});

  final List data;
  final void Function(int oldIndex, int newIndex) onReorder;

  @override
  State<WrapExample> createState() => _WrapExampleState();
}

class _WrapExampleState extends State<WrapExample> {
  @override
  Widget build(BuildContext context) {
    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        widget.onReorder(oldIndex, newIndex);
      });
    }

    return ReorderableWrap(
      spacing: 8.0,
      runSpacing: 4.0,
      padding: const EdgeInsets.all(8),
      onReorder: onReorder,
      // onNoReorder: (int index) {
      //   //this callback is optional
      //   debugPrint(
      //       '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      // },
      needsLongPressDraggable: false,
      children: widget.data
          .map((e) => MultipleChoiceButton(key: ValueKey(e), answer: e))
          .toList(),
      // onReorderStarted: (int index) {
      //   //this callback is optional
      //   debugPrint(
      //       '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
      // },
    );
  }
}

/////////////////// THE BUTTONS THEMSELVES ///////////////////

class MultipleChoiceButton extends StatefulWidget {
  const MultipleChoiceButton({
    super.key,
    required this.answer,
  });

  final String answer;

  @override
  State<MultipleChoiceButton> createState() => _MultipleChoiceButtonState();
}

class _MultipleChoiceButtonState extends State<MultipleChoiceButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        duration: Duration(milliseconds: 50),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.answer,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
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
