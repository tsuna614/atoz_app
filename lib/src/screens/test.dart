import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/questions.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class TestWidget extends ConsumerWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsProvider);
    var userEmail;

    void getRequest() async {
      Response response;
      response = await dio.get("http://localhost:3000/v1/user/getAllUsers");
      print(response.data.toString());
      userEmail = response.data[0]["email"].toString();
    }

    getRequest();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(userEmail.toString()),
            // Expanded(child: Container()),
            // ElevatedButton(onPressed: () {}, child: const Text('Continue'))
          ],
        ),
      ),
    );
  }
}
