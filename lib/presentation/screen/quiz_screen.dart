

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/business_logic/cubit-nottttused/quiz_cubit.dart';

import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/data/repository/quiz_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class QuizScreen extends StatefulWidget {


  final int quizId;



  QuizScreen({required  this.quizId});




  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  int? selectedAnswerIndex;
  bool isQuestionSelected = false;
  late int mainLevel=0;
  bool isLoading = true;
  List<Map<String, int>> selectedAnswers = [];
   SharedPreferences? _preferences;

  @override
  void initState() {
    super.initState();
    _initPreferences();
    _loadMainLevel();

  }
  Future<void> _loadMainLevel() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    mainLevel = prefs.getInt('main_level') ?? 0;
    setState(() {
      isLoading = false;
    });

  }
  void _loadSelectedAnswers() {
    final jsonString = _preferences?.getString('selectedAnswers');
    if (jsonString != null) {
      selectedAnswers = List<Map<String, int>>.from(
        jsonDecode(jsonString).map((x) => Map<String, int>.from(x)),
      );
    }
  }

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadSelectedAnswers();
  }
  void _saveSelectedAnswers() {
    final jsonString = jsonEncode(selectedAnswers);
    _preferences?.setString('selectedAnswers', jsonString);
    print('تم تخزين البيانات بنجاح: $selectedAnswers');
  }

  @override
  Widget build(BuildContext context) {


    final int adjustedQuizId = widget.quizId;
    // (mainLevel == 1 && widget.quizId == 6) ? 6
    //     :(mainLevel == 1 && widget.quizId == 12) ? 12
    //     :(mainLevel == 2 && widget.quizId == 6) ? 18
    //     :(mainLevel == 2 && widget.quizId == 12) ? 24
    //     :(mainLevel == 3 && widget.quizId == 6) ? 30
    //     :(mainLevel == 3 && widget.quizId == 12) ? 36


    Future<void> loadquizId() async{
      int quiz_id=0;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await  prefs.setInt('adjustedQuizId', adjustedQuizId);

    }

    final String url = '$path_BaseUrl/show_info_level/$adjustedQuizId';

    if (isLoading) {
      loadquizId();
      return Scaffold(
        backgroundColor: MyAppColors.lightBlue,
        body: Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.purple),
        )),
      );
    }




    void _sendAnswersToBackend(int quizId, List<Map<String, int>> selectedAnswers) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final quizId = prefs.getInt('quiz_id');

      try {
        print('Sending answers to backend:');
        print('Quiz ID: $quizId');
        print('Selected Answers: $selectedAnswers');

        var response = await http.post(
          Uri.parse('$path_BaseUrl/store_student_answers'),
          headers: {'Authorization': 'Bearer $token'},
          body: jsonEncode({
            'quiz_id': quizId,
            'answer': selectedAnswers,
          }),
        );

        if (response.statusCode == 200) {
          print('Answer submitted to the backend.');
        } else {
          print(response.statusCode);
          print('Failed to submit answer to the backend.');
        }
      } catch (e) {
        // Handle the error here
      }
    }

    return BlocProvider(
      create: (context) => QuizCubit(url)..loadQuestions(),
      child: BlocBuilder<QuizCubit, List<Test>>(
        builder: (context, state) {

          if (state.isNotEmpty) {
            final currentTest = state.first;
            final questions = currentTest.questions;
            final currentQuestion = questions[currentTest.currentQuestionIndex];
            return Scaffold(
              backgroundColor: MyAppColors.lightBlue,
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: MyAppColors.gray,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: 1.8,
                        child: Center(
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xFF89d3d6),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: Text('Question :  ${currentQuestion.questions}',style: GoogleFonts.quicksand(fontWeight: FontWeight.w500),),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Transform.scale(
                        scale: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: currentQuestion.answers.map((answer) {

                            final isAnswerSelected = currentQuestion.selectedAnswers.contains(answer.id);
                            final answerColor = isAnswerSelected ? Colors.blue : (isQuestionSelected ? Colors.grey.shade100 : Colors.white);
                            final textColor = isAnswerSelected ? Colors.white : Colors.black;

                            return Column(
                              children: [
                                Center(
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20.0),
                                        color: MyAppColors.lightG,
                                      ),
                                      padding: EdgeInsets.all(10.0),
                                      child: ListTile(
                                        title: Text('${answer.id}  -   ${answer.option}',style: GoogleFonts.quicksand(),),
                                        onTap: () {
                                          setState(() {
                                            selectedAnswerIndex = answer.id;
                                            isQuestionSelected = false;
                                            if (!isAnswerSelected) {
                                              currentQuestion.selectedAnswers.add({
                                                'question_number': currentQuestion.id,
                                                'answer': answer.id,
                                              });
                                            } else {
                                              currentQuestion.selectedAnswers.removeWhere((answerMap) =>
                                              answerMap['question_number'] == currentQuestion.id);
                                            }
                                          });

                                          final isAnswerCorrect = answer.id == currentQuestion.correctAnswerIndex;
                                          context.read<QuizCubit>().moveToNextQuestion(context, isAnswerCorrect);

                                          _sendAnswersToBackend(widget.quizId, currentQuestion.selectedAnswers);
                                        },

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: MyAppColors.lightBlue,
             // appBar: AppBar(title: Text('Quiz')),
              body: Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.purple),
              )),
            );
          }
        },
      ),
    );
  }
}