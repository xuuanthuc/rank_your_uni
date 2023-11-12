
class QuestionCategories {
  final String? title;
  final List<Questions>? questions;

  const QuestionCategories({
    required this.title,
    required this.questions,
  });

  factory QuestionCategories.fromJson(Map<String, dynamic> json) {
    final title = json['title'];
    final questions = <Questions>[];

    if (json['questions'] != null) {
      json['questions'].forEach((v) {
        questions.add(Questions.fromJson(v));
      });
    }
    return QuestionCategories(
      title: title,
      questions: questions,
    );
  }
}

class Questions {
  final String question;
  final String answer;

  const Questions({
    required this.answer,
    required this.question,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      answer: json['answer'],
      question: json['question'],
    );
  }
}