import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailReadingQuestion extends StatefulWidget {
  const DetailReadingQuestion({super.key, required this.questionId});

  final String questionId;

  @override
  State<DetailReadingQuestion> createState() => _DetailReadingQuestionState();
}

class _DetailReadingQuestionState extends State<DetailReadingQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
