class Flashcard {
  final String id;
  final String question;
  final String answer;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory Flashcard.fromMap(Map map) {
    return Flashcard(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}
