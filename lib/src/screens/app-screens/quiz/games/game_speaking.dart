import 'dart:io';

import 'package:dio/dio.dart';
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
  RecordingState recordingState = RecordingState.initial;
  AudioRecorder recorder = AudioRecorder();
  String? audioPath;
  String userAnswer = '';

  late Widget speakingSentence;

  @override
  void initState() {
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
    super.dispose();
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
    userAnswer = await getUserSpeechToText();

    // print(userAnswer);
    // print(widget.fullSentence);

    List<bool> result = compareStringsByWords(
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
                text: i == 0 ? splittedSentence[i] : ' ${splittedSentence[i]}',
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
    });

    // String answer = widget.fullSentence;
    // // remove the last period from the answer if the user didn't type it
    // if (widget.fullSentence.endsWith('.') &&
    //     !textController.text.endsWith('.')) {
    //   answer = widget.fullSentence.substring(
    //     0,
    //     widget.fullSentence.length - 1,
    //   );
    // }
    // if (textController.text.trim().toLowerCase() ==
    //     answer.trim().toLowerCase()) {
    //   AwesomeDialog(
    //     context: context,
    //     dialogType: DialogType.success,
    //     animType: AnimType.rightSlide,
    //     title: 'Correct',
    //     btnOkText: 'Next',
    //     btnOkOnPress: () {
    //       // Navigator.pop(context);
    //       widget.handleCheckButton(true);
    //     },
    //     dismissOnTouchOutside: false,
    //   ).show();
    // } else {
    //   AwesomeDialog(
    //     context: context,
    //     dialogType: DialogType.error,
    //     animType: AnimType.rightSlide,
    //     title: 'Wrong',
    //     btnCancelText: 'Next',
    //     btnCancelOnPress: () {
    //       // Navigator.pop(context);
    //       widget.handleCheckButton(false);
    //     },
    //     dismissOnTouchOutside: false,
    //   ).show();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Text(
              'Press Start recording button and try to speak this sentence out loud.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 100,
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
              child: Center(
                child: speakingSentence,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
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
          width: 180,
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
            // child: CircularProgressIndicator(
            //   backgroundColor: Colors.blue[700],
            //   color: Colors.white,
            // ),
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
