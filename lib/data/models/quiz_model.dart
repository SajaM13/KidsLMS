class Question {
  final int id;
  final String questions;
  final List<Answer> answers;
  int correctAnswerIndex;
  List<Map<String, int>> selectedAnswers;
  int points;

  Question({
    required this.id,
    required this.questions,
    required this.answers,
    required this.correctAnswerIndex,
    List<Map<String, int>>? selectedAnswers,
    this.points = 0,
  }): selectedAnswers = selectedAnswers ?? [];

  factory Question.fromJson(Map<String, dynamic> json) {
    final answersData = json['answers'] as List<dynamic>;
    final answers = answersData.map((answerData) => Answer.fromJson(answerData)).toList();
    final id = json['id'] as int;

    return Question(

      id:id,
      questions: json['questions'],
      answers: answers,
      correctAnswerIndex: int.parse(json['correctAnswerIndex']),
    );
  }
}

class Answer {
  final int id;
  final String option;

  Answer({required this.id, required this.option,});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(id: json['id'], option: json['option']);
  }
}