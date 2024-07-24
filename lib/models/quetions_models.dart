class QuestionsModels {
  final String id;
  final String question;
  final String answer;

  QuestionsModels({required this.id, required this.question, required this.answer});

  factory QuestionsModels.fromJson(Map<String, dynamic> json) {
    return QuestionsModels(
      id: json['id'] ?? '',
      question: json['question'] ?? 'No question provided',
      answer: json['answer'] ?? 'No answer provided',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }
}
