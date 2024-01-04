import 'package:atoz_app/src/screens/app-screens/practice-screens/admin-practice-screen/add_reading_question_screen.dart';
import 'package:atoz_app/src/screens/app-screens/practice-screens/admin-practice-screen/detail_reading_question.dart';
import 'package:atoz_app/src/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';

final dio = Dio();

class ViewReadingScreen extends StatefulWidget {
  const ViewReadingScreen({super.key});

  @override
  State<ViewReadingScreen> createState() => _ViewReadingScreenState();
}

class _ViewReadingScreenState extends State<ViewReadingScreen> {
  List<String> readingTitle = [];
  List<String> readingId = [];

  void initQuestionList() async {
    readingTitle.clear();
    readingId.clear();
    Response response =
        await dio.get('${global.atozApi}/readingQuiz/getAllQuizzes');
    for (int i = 0; i < response.data.length; i++) {
      setState(() {
        readingTitle.add(response.data[i]['title'].toString());
        readingId.add(response.data[i]['_id'].toString());
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
      body: readingTitle.isEmpty
          ? Center(
              child: Text('No Reading Question Found'),
            )
          : ListView.builder(
              itemCount: readingTitle.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(readingTitle[index]),
                    subtitle: Text(readingId[index]),
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailReadingQuestion(
                      //       questionId: readingId[index],
                      //     ),
                      //   ),
                      // );
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
                                            '${global.atozApi}/readingQuiz/deleteQuizById/${readingId[index]}');
                                        setState(() {
                                          readingTitle.removeAt(index);
                                          readingId.removeAt(index);
                                        });
                                        Navigator.pop(context);
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
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => AddReadingQuestionScreen(),
                ),
              )
              .then((value) => {
                    setState(() {
                      initQuestionList();
                    })
                  });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
