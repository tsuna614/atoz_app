import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';

final dio = Dio();

class AddReadingQuestionScreen extends StatefulWidget {
  const AddReadingQuestionScreen({super.key});

  @override
  State<AddReadingQuestionScreen> createState() =>
      _AddReadingQuestionScreenState();
}

class _AddReadingQuestionScreenState extends State<AddReadingQuestionScreen> {
  final _title = TextEditingController();
  final _language = TextEditingController();
  final _difficulty = TextEditingController();
  final List<String> _paragraphs = [];
  int numberOfParagraphs = 0;
  final List<ReadingMultipleChoiceQuestion> _question = [];
  final List<String> allQuestionIds = [];
  int numberOfQuestions = 0;

  void onCreatePressed(BuildContext context) async {
    if (_title.text.isEmpty ||
        _language.text.isEmpty ||
        _difficulty.text.isEmpty ||
        _paragraphs.isEmpty ||
        _question.isEmpty) {
      return;
    }
    for (int i = 0; i < _question.length; i++) {
      Response response = await dio.post(
        '${global.atozApi}/readingMultipleChoice/addQuiz',
        data: {
          'question': _question[i].question,
          'answers': _question[i].answers,
          'correctAnswer': _question[i].correctAnswer,
        },
      );
      allQuestionIds.add(response.data['_id'].toString());
    }
    Response response = await dio.post(
      '${global.atozApi}/readingQuiz/addQuiz',
      data: {
        'title': _title.text,
        'paragraphsList': _paragraphs,
        'questionsList': allQuestionIds,
        'language': _language.text,
        'difficulty': _difficulty.text,
      },
    );
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _title.dispose();
    _language.dispose();
    _difficulty.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Reading Question'),
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
                            labelText: 'Title',
                            hintText: 'Enter title',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _language,
                          decoration: InputDecoration(
                            labelText: 'Language',
                            hintText: 'Enter language',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _difficulty,
                          decoration: InputDecoration(
                            labelText: 'Difficulty',
                            hintText: 'Enter difficulty (1 - 4)',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        // SizedBox(
                        //   height: 16,
                        // ),
                        // SizedBox(
                        //   height: 300,
                        //   child: TextField(
                        //     textAlignVertical: TextAlignVertical.top,
                        //     controller: _paragraph,
                        //     decoration: InputDecoration(
                        //       alignLabelWithHint: true,
                        //       labelText: 'Paragraph',
                        //       hintText: 'Enter paragraph',
                        //       border: OutlineInputBorder(),
                        //     ),
                        //     expands: true,
                        //     maxLines: null,
                        //   ),
                        // ),
                        buildParagraphs(),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              numberOfParagraphs++;
                              _paragraphs.add('');
                            });
                          },
                          child: Text('Add Paragraph'),
                        ),
                        buildQuestion(),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              numberOfQuestions++;
                              _question.add(ReadingMultipleChoiceQuestion(
                                  question: '',
                                  answers: ['', '', '', ''],
                                  correctAnswer: ''));
                            });
                          },
                          child: Text('Add Question'),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: Size.fromHeight(40)),
                          onPressed: () {
                            onCreatePressed(
                              context,
                            );
                          },
                          child: Text('Create'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildParagraphs() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: numberOfParagraphs,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 16,
            ),
            SizedBox(
              // height: 300,
              child: TextField(
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Paragraph',
                  hintText: 'Enter paragraph',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _paragraphs[index] = value;
                  });
                },
                // expands: true,
                // maxLines: null,
                minLines: 1,
                maxLines: 100,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildQuestion() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: numberOfQuestions,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Question',
                hintText: 'Enter question',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _question[index].question = value;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Correct Answer',
                hintText: 'Enter correct answer',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _question[index].correctAnswer = value;
                  _question[index].answers[0] = value;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Wrong Answer 1',
                hintText: 'Enter wrong answer 1',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _question[index].answers[1] = value;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Wrong Answer 2',
                hintText: 'Enter wrong answer 2',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _question[index].answers[2] = value;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Wrong Answer 3',
                hintText: 'Enter wrong answer 3',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _question[index].answers[3] = value;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
