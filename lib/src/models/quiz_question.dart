abstract class QuizQuestion {}

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
}

class WordsDistributionQuestion extends QuizQuestion {
  WordsDistributionQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswers1,
    required this.correctAnswers2,
  });

  final String question;
  final List<String> answers;
  final List<String> correctAnswers1;
  final List<String> correctAnswers2;

  List<String> getShuffledAnswers(List<String> answers) {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}

class TranslateQuestion extends QuizQuestion {
  TranslateQuestion({
    required this.question,
    required this.word,
    required this.correctAnswer,
    required this.imageAsset,
  });

  final String question;
  final String word;
  final String correctAnswer;
  final String imageAsset;
}

class DropDownQuestion extends QuizQuestion {
  DropDownQuestion({
    required this.question,
    required this.sentencesList,
  });

  final String question;
  final List<DropDownQuestionChild> sentencesList;
}

class DropDownQuestionChild {
  DropDownQuestionChild({
    required this.sentence1,
    required this.sentence2,
    required this.answers,
    required this.correctAnswer,
  });

  final String sentence1;
  final String sentence2;
  final List<String> answers;
  final String correctAnswer;
}
