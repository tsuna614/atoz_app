import 'package:atoz_app/src/models/quiz_question.dart';
import 'package:atoz_app/src/screens/app-screens/practice/admin-practice-screen/add_reading_question_screen.dart';
import 'package:atoz_app/src/screens/app-screens/quiz/games/game_listening_1.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';

final dio = Dio();

class ViewListeningScreen extends StatefulWidget {
  const ViewListeningScreen({super.key});

  @override
  State<ViewListeningScreen> createState() => _ViewListeningScreenState();
}

class _ViewListeningScreenState extends State<ViewListeningScreen> {
  List<ListeningQuestion> listeningQuestions = [];
  List<String> listeningId = [];

  void initQuestionList() async {
    listeningQuestions.clear();
    listeningId.clear();
    Response response =
        await dio.get('${global.atozApi}/listeningQuiz/getAllQuizzes');
    for (int i = 0; i < response.data.length; i++) {
      setState(() {
        listeningQuestions.add(
          ListeningQuestion(
              fullSentence: response.data[i]['fullSentence'].toString(),
              answers: response.data[i]['fullSentence'].toString().split(' '),
              audioPublicId: response.data[i]['publicId'].toString(),
              quizType: 1),
        );
        listeningId.add(response.data[i]['_id'].toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Listening Questions',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: listeningQuestions.isEmpty
          ? Center(
              child: Text('No Listening Question Found'),
            )
          : _buildListeningQuestionList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => AddReadingQuestionScreen(),
                ),
              )
              .then((value) => {
                    Future.delayed(Duration(seconds: 1), () {
                      initQuestionList();
                    })
                  });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListeningQuestionList() {
    return ListView.builder(
      itemCount: listeningQuestions.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(listeningQuestions[index].fullSentence),
            subtitle: Text(listeningId[index]),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    body: ListeningTest(
                        fullSentence: listeningQuestions[index].fullSentence,
                        answers: listeningQuestions[index].answers,
                        audioPublicId: listeningQuestions[index].audioPublicId,
                        handleCheckButton: (e) {}),
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete this quiz?'),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await dio.delete(
                                    '${global.atozApi}/listeningQuiz/deleteQuizById/${listeningId[index]}');
                                setState(() {
                                  listeningQuestions.removeAt(index);
                                  listeningId.removeAt(index);
                                });
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Yes')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No')),
                        ],
                      );
                    });
              },
            ),
          ),
        );
      },
    );
  }
}

class ViewListeningQuestionDetail extends StatelessWidget {
  final ListeningQuestion listeningQuestion;
  const ViewListeningQuestionDetail(
      {super.key, required this.listeningQuestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Question Detail'),
      ),
      body: Column(
        children: [
          Text(listeningQuestion.fullSentence),
          Text(listeningQuestion.audioPublicId),
          Text(listeningQuestion.answers.toString()),
        ],
      ),
    );
  }
}
