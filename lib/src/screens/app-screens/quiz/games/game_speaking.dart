import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:atoz_app/src/data/global_data.dart' as globals;

enum RecordingState { initial, recording, finished }

class SpeakingTest extends StatefulWidget {
  final String fullSentence;
  final void Function(bool) handleCheckButton;

  const SpeakingTest({
    super.key,
    required this.fullSentence,
    required this.handleCheckButton,
  });

  @override
  State<SpeakingTest> createState() => _SpeakingTestState();
}

class _SpeakingTestState extends State<SpeakingTest> {
  late RecordingState recordingState;
  late AudioRecorder recorder;
  late AudioPlayer player;
  String? audioPath;
  String userAnswer = '';
  bool isLoading = false;
  bool hasCheckedAnswer = false;
  late List<bool> result;

  late Widget speakingSentence;

  @override
  void initState() {
    recordingState = RecordingState.initial;
    recorder = AudioRecorder();
    player = AudioPlayer();
    speakingSentence = Text(
      widget.fullSentence,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SpeakingTest oldWidget) {
    // reinstantiate the recorder when the widget is updated
    recordingState = RecordingState.initial;
    recorder = AudioRecorder();
    hasCheckedAnswer = false;
    speakingSentence = Text(
      widget.fullSentence,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
    super.didUpdateWidget(oldWidget);
  }

  String formattedString(String str) {
    return str.replaceAll(RegExp(r'[^\w\s]+'), '').toLowerCase();
  }

  List<bool> compareStringsByWords(
      {required String sentence, required String userAnswer}) {
    List<String> sentenceList = sentence.split(' ');
    List<String> userAnswerList = userAnswer.split(' ');

    List<bool> result = [];

    for (int i = 0; i < sentenceList.length; i++) {
      if (userAnswerList.length <= i) {
        result.add(false);
      } else {
        if (sentenceList[i] == userAnswerList[i]) {
          result.add(true);
        } else {
          result.add(false);
        }
      }
    }

    return result;
  }

  Future<void> startRecording() async {
    try {
      if (await recorder.hasPermission()) {
        // // String filePath = '/Users/khanhnguyenquoc/Desktop/test.wav';
        final Directory tempDir = await getTemporaryDirectory();

        String filePath = '${tempDir.path}/test.wav';

        await recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.wav, // Audio format
            // bitRate: 128000, // Bit rate
            // sampleRate: 44100, // Sampling rate
          ),
          path: filePath,
        );

        setState(() {
          recordingState = RecordingState.recording;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stopRecording() async {
    try {
      audioPath = await recorder.stop();
      setState(() {
        recordingState = RecordingState.finished;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> playAudio() async {
    try {
      await player.stop();
      await player.play(DeviceFileSource(audioPath!));
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserSpeechToText() async {
    try {
      // Source urlSource = UrlSource(audioPath!);
      // await player.play(DeviceFileSource(audioPath!));

      FormData formData = FormData.fromMap({
        "audio":
            await MultipartFile.fromFile(audioPath!, filename: "recording.mp3"),
      });

      final dio = Dio();

      Response response = await dio.post(
        '${globals.atozApi}/speakingQuiz/speech-to-text', // Replace with your API endpoint
        data: formData,
      );

      print(response.data);

      if (response.statusCode == 200) {
        return response.data['userAnswer'];
      } else {
        return '';
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  void onCheckPressed() async {
    if (!hasCheckedAnswer) {
      setState(() {
        isLoading = true;
      });

      userAnswer = await getUserSpeechToText();

      result = compareStringsByWords(
        sentence: formattedString(widget.fullSentence),
        userAnswer: formattedString(userAnswer),
      );

      List<String> splittedSentence = widget.fullSentence.split(' ');

      setState(() {
        speakingSentence = Text.rich(
          TextSpan(
            children: [
              for (int i = 0; i < splittedSentence.length; i++)
                TextSpan(
                  text:
                      i == 0 ? splittedSentence[i] : ' ${splittedSentence[i]}',
                  style: TextStyle(
                    color: result[i] ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
            ],
          ),
          textAlign: TextAlign.center,
        );
        isLoading = false;
        hasCheckedAnswer = true;
      });
    } else {
      if (result.every((element) => element == true)) {
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
          btnCancelText: 'Next',
          btnCancelOnPress: () {
            // Navigator.pop(context);
            widget.handleCheckButton(false);
          },
          dismissOnTouchOutside: false,
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Press \'Start recording\' button and try to speak this sentence out loud.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: speakingSentence,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              AudioButton(
                onCheckPressed: () {
                  if (recordingState == RecordingState.initial) {
                    startRecording();
                  } else if (recordingState == RecordingState.recording) {
                    stopRecording();
                  }
                },
                recordingState: recordingState,
              ),
              Spacer(),
              ReplayButton(
                onCheckPressed: playAudio,
                recordingState: recordingState,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CheckButton(
            onCheckPressed: onCheckPressed,
            recordingState: recordingState,
            isLoading: isLoading,
            hasCheckedAnswer: hasCheckedAnswer,
          ),
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
  const AudioButton({
    super.key,
    required this.onCheckPressed,
    required this.recordingState,
  });

  final void Function() onCheckPressed;
  final RecordingState recordingState;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    MaterialColor color = widget.recordingState == RecordingState.initial
        ? Colors.blue
        : widget.recordingState == RecordingState.recording
            ? Colors.orange
            : Colors.green;
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
          color: color[700],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: 160,
          // height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: color,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Icon(
                      widget.recordingState == RecordingState.finished
                          ? Icons.check
                          : Icons.mic,
                      color: color,
                      size: 80),
                  Text(
                    widget.recordingState == RecordingState.initial
                        ? 'Start recording'
                        : widget.recordingState == RecordingState.recording
                            ? 'Recording...'
                            : 'Recorded',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReplayButton extends StatefulWidget {
  const ReplayButton({
    super.key,
    required this.onCheckPressed,
    required this.recordingState,
  });

  final void Function() onCheckPressed;
  final RecordingState recordingState;

  @override
  State<ReplayButton> createState() => _ReplayButtonState();
}

class _ReplayButtonState extends State<ReplayButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    MaterialColor color = widget.recordingState == RecordingState.finished
        ? Colors.blue
        : Colors.grey;
    return GestureDetector(
      onTap: () {
        if (widget.recordingState == RecordingState.finished) {
          widget.onCheckPressed();
        }
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
          color: color[500],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: 160,
          // height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: color,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Icon(
                    Icons.volume_up_rounded,
                    color: color,
                    size: 80,
                  ),
                  Text(
                    'Replay Audio',
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CheckButton extends StatefulWidget {
  const CheckButton({
    super.key,
    required this.onCheckPressed,
    required this.recordingState,
    required this.isLoading,
    required this.hasCheckedAnswer,
  });

  final void Function() onCheckPressed;
  final RecordingState recordingState;
  final bool isLoading;
  final bool hasCheckedAnswer;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    MaterialColor color = widget.recordingState == RecordingState.finished
        ? Colors.blue
        : Colors.grey;

    return GestureDetector(
      onTap: () {
        if (widget.recordingState == RecordingState.finished) {
          widget.onCheckPressed();
        }
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
          color: color[600],
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: widget.isLoading
                ? CircularProgressIndicator(
                    backgroundColor: color[700],
                    color: Colors.white,
                  )
                : widget.hasCheckedAnswer
                    ? Text(
                        'Next question',
                        style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    : Text(
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
