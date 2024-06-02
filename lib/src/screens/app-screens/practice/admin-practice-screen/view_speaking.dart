import 'package:atoz_app/src/screens/app-screens/practice/admin-practice-screen/add_speaking_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:atoz_app/src/data/global_data.dart' as global;
import 'package:dio/dio.dart';

final dio = Dio();

class ViewSpeakingScreen extends StatefulWidget {
  const ViewSpeakingScreen({super.key});

  @override
  State<ViewSpeakingScreen> createState() => _ViewSpeakingScreenState();
}

class _ViewSpeakingScreenState extends State<ViewSpeakingScreen> {
  List<String> readingTitle = [];
  List<String> readingId = [];

  void initQuestionList() async {
    readingTitle.clear();
    readingId.clear();
    Response response =
        await dio.get('${global.atozApi}/speakingQuiz/getAllQuizzes');
    for (int i = 0; i < response.data.length; i++) {
      setState(() {
        readingTitle.add(response.data[i]['sentence'].toString());
        readingId.add(response.data[i]['_id'].toString());
      });
    }
  }

  void deleteQuestion(int index) {
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
      },
    );
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
        title: Text('List of Reading Questions',
            style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
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
                      onPressed: () {
                        deleteQuestion(index);
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
                  builder: (context) => AddSpeakingQuestionScreen(),
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
}
