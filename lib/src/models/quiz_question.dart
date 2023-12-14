class QuizQuestion {
  const QuizQuestion(
      this.question, this.answers, this.correctAnswer, this.imageAsset);

  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String imageAsset;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
