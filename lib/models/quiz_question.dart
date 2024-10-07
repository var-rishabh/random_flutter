class QuizQuestion {
  const QuizQuestion(this.question, this.options);

  final String question;
  final List<String> options;

  List<String> get shuffledAnswers {
    final shuffledList = List.of(options);
    shuffledList.shuffle();

    return shuffledList;
  }
}
