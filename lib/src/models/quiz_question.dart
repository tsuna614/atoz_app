abstract class QuizQuestion {
  // final String question;

  // const QuizQuestion({
  //   required this.question,
  // });

  String getClassName() {
    return runtimeType.toString();
  }

  List<String> getAnswers();
}

class MultipleChoiceQuestion extends QuizQuestion {
  MultipleChoiceQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.imageAsset,
  });

  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String imageAsset;

  @override
  List<String> getAnswers() {
    // Shuffle the answers
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }

  getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}

class ReorderStringQuestion extends QuizQuestion {
  ReorderStringQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.imageAsset,
  });

  final String question;
  final List<String> answers;
  final List<String> correctAnswer;
  final String imageAsset;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }

  @override
  List<String> getAnswers() {
    return answers;
  }
}

class ConnectStringQuestion extends QuizQuestion {
  ConnectStringQuestion({
    required this.question,
    required this.leftAnswers,
    required this.rightAnswers,
    required this.correctAnswers,
    required this.imageAsset,
  });

  final String question;
  final List<String> leftAnswers;
  final List<String> rightAnswers;
  final List<String> correctAnswers;
  final String imageAsset;

  List<String> getShuffledAnswers(List<String> answers) {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }

  @override
  List<String> getAnswers() {
    return correctAnswers;
  }
}
