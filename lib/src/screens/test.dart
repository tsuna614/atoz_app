import 'package:flutter/material.dart';
import 'package:atoz_app/src/data/questions.dart';
import 'package:atoz_app/src/providers/question_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestWidget extends ConsumerWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(mealsProvider);

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Text(questions[0].question),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 150),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      childAspectRatio: 6 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  children: [
                    for (final answer in questions[0].answers)
                      ElevatedButton(onPressed: () {}, child: Text(answer))
                  ],
                ),
              ),
            ),
            // Expanded(child: Container()),
            // ElevatedButton(onPressed: () {}, child: const Text('Continue'))
          ],
        ),
      ),
    );
  }
}
