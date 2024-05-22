import 'package:atoz_app/src/models/quiz_question.dart';

// this class store each chapter's name and list of QuizQuestion for each stages
class Chapter {
  final String chapterName;
  final List<Stage> stages;

  Chapter({
    required this.chapterName,
    required this.stages,
  });
}

class Stage {
  final List<QuizQuestion> questions;
  final int stageIndex;

  Stage({
    required this.questions,
    required this.stageIndex,
  });
}

// this class store each user's progression in each stage
class StageDetails {
  final int star;
  final int clearTime;

  StageDetails({
    this.star = 0,
    this.clearTime = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'star': star,
      'clearTime': clearTime,
    };
  }
}
