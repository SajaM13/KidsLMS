import 'package:kids_lms_project/data/models/quiz_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Test {
  final int quiz_id;
  final List<Question> questions;
  int currentQuestionIndex;

  Test({required this.quiz_id, required this.questions, this.currentQuestionIndex = 0});



  static Future<void> saveQuizId(int quizId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quiz_id', quizId);
  }

  factory Test.fromJson(Map<String, dynamic> json) {
    final quizId = json['quiz_id'] as int;
    final questionsData = json['0'] as List<dynamic>;
    final questions = questionsData.map((questionData) => Question.fromJson(questionData)).toList();
    saveQuizId(quizId);
    return Test(quiz_id: quizId, questions: questions);
  }
}