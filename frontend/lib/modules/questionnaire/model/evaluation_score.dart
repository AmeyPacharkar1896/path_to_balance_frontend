class EvaluationScore {
  final String question;
  final int answer;

  EvaluationScore({required this.question, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "answer": answer,
    };
  }
}
