import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/data/models/quiz_model.dart';
import 'package:kids_lms_project/data/repository/quiz_repository.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/presentation/screen/course_path.dart';
import 'package:kids_lms_project/presentation/screen/login_screen.dart';
import 'package:kids_lms_project/presentation/screen/quiz_answers.dart';
import 'package:shared_preferences/shared_preferences.dart';
class QuizCubit extends Cubit<List<Test>> {

  String url ;


  @override
  List<Question> correctlyAnsweredQuestions = [];
  QuizCubit(this.url,) : super([]);


  Future<void> loadQuestions() async {
    final response = await http.get(Uri.parse(url));
    final jsonList = jsonDecode(response.body) as List<dynamic>;



    final tests = jsonList.map((testData) => Test.fromJson(testData)).toList();
    emit(tests);
  }




  void moveToNextQuestion(BuildContext context, bool isAnswerCorrect) {
    Timer(Duration(milliseconds: 500), () {
      final currentTest = state[0];
      final questions = currentTest.questions;
      final currentQuestion = questions[currentTest.currentQuestionIndex];
      final currentTests = List.from(state);

      if (currentQuestion.points == 0 && isAnswerCorrect) {
        context.read<QuizCubit>().correctlyAnsweredQuestions.add(currentQuestion);
        currentQuestion.points = 10;
      }

      currentTests[0].currentQuestionIndex++;

      if (currentTests[0].currentQuestionIndex >= questions.length) {
        showResult(context);

        return;
      }

      emit(List.from(state));
    });
  }



  void showResult(BuildContext context) async{

    final correctlyAnsweredQuestions = context.read<QuizCubit>().correctlyAnsweredQuestions;
    final totalQuestions = state[0].questions.length;
    final correctAnswers = correctlyAnsweredQuestions.length;
    final incorrectAnswers = totalQuestions - correctAnswers;

    final totalPoints = correctlyAnsweredQuestions.fold<int>(
      0,
          (sum, question) => sum + question.points,
    );

    final prefs = await SharedPreferences.getInstance();
    final quizId = prefs.getInt('quiz_id');
    final token = prefs.getString('token');

    final uri = '$path_BaseUrl/score_quiz';
    final response = await http.post(
      Uri.parse(uri),
      headers: {'Authorization': 'Bearer $token'},
      body: {'quiz_id': quizId.toString(), 'score': totalPoints.toString()},
    );

    if (response.statusCode == 200) {
      print("token='$token'");
      print('quiz_id=$quizId');
      print('score=$totalPoints');
      print('Result submitted to the backend.');
    } else {

      print('Failed to submit result to the backend.');
    }


    //  sendPointsToBackend(totalPoints);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          //backgroundColor: MyAppColors.darkGreen,
          title: Center(child: Text('Quiz Result',style: GoogleFonts.quicksand(),)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Result: $totalPoints / ${totalQuestions*10} ',style: GoogleFonts.quicksand(),),
              SizedBox(height: 10,),
              //Text('Incorrect Answers: $incorrectAnswers'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(MyAppColors.purple),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => course_path(levelId: 1,)),
                            (route) => false,
                      );
                    },
                    child: Text('Exit',style: GoogleFonts.quicksand(),),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(MyAppColors.purple),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(

                          builder: (context) => QuizAnswers(url: url,),
                        ),

                      );
                    },
                    child: Text('the solution',style: GoogleFonts.quicksand(),),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}