import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_lms_project/business_logic/cubit-nottttused/quiz_cubit.dart';

import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/data/repository/quiz_repository.dart';
import 'package:kids_lms_project/presentation/widgets/another_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizAnswers extends StatefulWidget {

  final String url;




  QuizAnswers({this.url = '',});



  @override
  State<QuizAnswers> createState() => _QuizAnswersState();
}

class _QuizAnswersState extends State<QuizAnswers> {
  List<Map<String, int>> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedAnswers();
  }

  void _loadSelectedAnswers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('selectedAnswers');
    if (jsonString != null) {
      setState(() {
        selectedAnswers = List<Map<String, int>>.from(jsonDecode(jsonString).map((x) => Map<String, int>.from(x)));
      });
      print('البيانات المحملة: $selectedAnswers');
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => QuizCubit(widget.url)..loadQuestions(),
      child: BlocBuilder<QuizCubit, List<Test>>(
        builder: (context, state) {
          if (state.isNotEmpty) {
            final currentTest = state.first;
            final questions = currentTest.questions;


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
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {

                      final currentQuestion = questions[index];


                      return Column(
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
                                child: Text('Question :  ${currentQuestion.questions}',style: GoogleFonts.quicksand(),),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: currentQuestion.answers.map((answer) {
                              final isAnswerCorrect = answer.id == currentQuestion.correctAnswerIndex;
                              final isSelected = selectedAnswers.isNotEmpty && selectedAnswers[index]['selectedAnswer'] == answer.id;


                              return Column(
                                children: [
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(20.0),
                                        color:
                                             isAnswerCorrect ? MyAppColors.green
                                            : MyAppColors.lightG,
                                      ),
                                      padding: EdgeInsets.all(10.0),
                                      child: ListTile(
                                        title: Text('${answer.id}  -   ${answer.option}',style: GoogleFonts.quicksand(),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 40.0),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: MyAppColors.lightBlue,
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.purple),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}