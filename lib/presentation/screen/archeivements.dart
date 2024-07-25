import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/colors.dart';
import 'package:kids_lms_project/constants/strings.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GameResult {
  final int levelId;
  final String studentName;
  final int firstGame;
  final int secondGame;
  final int thirdGame;

  GameResult({
    required this.levelId,
    required this.studentName,
    required this.firstGame,
    required this.secondGame,
    required this.thirdGame,
  });
}

class QuizResult {
  final int levelId;
  final String studentName;
  final int score;

  QuizResult({
    required this.levelId,
    required this.studentName,
    required this.score,
  });
}

class AchievementsScreen extends StatefulWidget {
  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  List<GameResult> gameResults = [];
  List<QuizResult> quizResults = [];
  bool isLoading = true;
  String token = '';

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  Future<void> fetchToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('$path_BaseUrl/archeivement'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> gameResultsData = jsonData['game_result'];
      final List<dynamic> quizResultsData = jsonData['quize_result'];
      setState(() {
        gameResults = gameResultsData.map((data) => GameResult(
          levelId: data['level_id'],
          studentName: data['name_student'],
          firstGame: data['first_game'] ?? 0,
          secondGame: data['second_game'] ?? 0,
          thirdGame: data['third_game'] ?? 0,
        )).toList();

        quizResults = quizResultsData.map((data) => QuizResult(
          levelId: data['level_id'],
          studentName: data['name_student'],
          score: data['score'],
        )).toList();

      }

      );
      print('name_student=$gameResultsData');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(MyAppColors.purple),
          ),
        )
            : gameResults.isEmpty && quizResults.isEmpty
            ? Center(
          child: Text(
            'No results',
            style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.bold, color: MyAppColors.magenta),
          ),
        )
            : ListView.builder(
          itemCount: gameResults.length + quizResults.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < gameResults.length) {
              var gameResult = gameResults[index];
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF89d3d6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Student Name: ${gameResult.studentName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('GameResults:', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 18)),
                    SizedBox(height: 5),
                    Text('Level : ${gameResult.levelId}',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                    Text('First Game: ${gameResult.firstGame}',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                    Text('Second Game: ${gameResult.secondGame}',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                    Text('Third Game: ${gameResult.thirdGame}',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            } else {
              var quizResult = quizResults[index - gameResults.length];
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF89d3d6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Student Name: ${quizResult.studentName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Quiz Result:', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold,fontSize: 18)),
                    SizedBox(height: 5),
                    Text('Level : ${quizResult.levelId}',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                    Text('Score: ${quizResult.score}',style: GoogleFonts.quicksand(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}