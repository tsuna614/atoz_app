import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';

final dio = Dio();

class AddListeningQuestionScreen extends StatefulWidget {
  const AddListeningQuestionScreen({super.key});

  @override
  State<AddListeningQuestionScreen> createState() =>
      _AddListeningQuestionScreenState();
}

class _AddListeningQuestionScreenState
    extends State<AddListeningQuestionScreen> {
  final _title = TextEditingController();

  bool isMoreThen50Characters = false;
  bool containsPunctuation = false;

  String? _radioValue = '';

  void checkValidation() {
    if (_title.text.trim().length > 50) {
      setState(() {
        isMoreThen50Characters = true;
      });
    } else {
      setState(() {
        isMoreThen50Characters = false;
      });
    }

    if (_title.text.contains(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'))) {
      setState(() {
        containsPunctuation = true;
      });
    } else {
      setState(() {
        containsPunctuation = false;
      });
    }
  }

  void onCreatePressed(BuildContext context) async {
    if (_title.text.trim().isEmpty ||
        isMoreThen50Characters ||
        containsPunctuation) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all necessary fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    await dio.post(
      '${global.atozApi}/listeningQuiz/generateQuiz',
      data: {
        'content': _title.text,
        'voice': _radioValue,
      },
    );
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Question generated successfully'),
        ),
      );
    }
  }

  @override
  void initState() {
    _radioValue = "alloy";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Listening Question'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _title,
                        decoration: InputDecoration(
                          labelText: 'Topic',
                          hintText: 'Enter your topic',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) {
                          checkValidation();
                        },
                      ),
                      _buildRadioCheckBox(),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: _title.text.trim().isEmpty
                                ? Colors.red
                                : Colors.green,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Is not empty',
                            style: TextStyle(
                              fontSize: 16,
                              color: _title.text.trim().isEmpty
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: isMoreThen50Characters
                                ? Colors.red
                                : Colors.green,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Less than 50 characters',
                            style: TextStyle(
                              fontSize: 16,
                              color: isMoreThen50Characters
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color:
                                containsPunctuation ? Colors.red : Colors.green,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Does not contain punctuation except (. , \' ")',
                            style: TextStyle(
                              fontSize: 16,
                              color: containsPunctuation
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CheckButton(
                        onCheckPressed: () {
                          onCreatePressed(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioCheckBox() {
    return Column(
      children: [
        Row(
          children: [
            Radio<String>(
              value: "alloy",
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value;
                });
              },
            ),
            Text("Male", style: TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: "nova",
              groupValue: _radioValue,
              onChanged: (value) {
                setState(() {
                  _radioValue = value;
                });
              },
            ),
            Text("Female", style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCheckPressed();
        setState(() {
          _isLoading = true;
        });
      },
      onTapDown: (_) {
        setState(() {
          _padding = 0;
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
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Generate Question',
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
