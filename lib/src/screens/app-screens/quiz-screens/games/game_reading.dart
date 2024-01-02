import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ReadingGame extends StatefulWidget {
  const ReadingGame({super.key});

  @override
  State<ReadingGame> createState() => _ReadingGameState();
}

class _ReadingGameState extends State<ReadingGame> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Reading Game',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Placeholder(
            fallbackHeight: 200,
            fallbackWidth: 200,
          ),
          Text(
            'This is a reading game',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}
