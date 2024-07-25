import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:kids_lms_project/constants/strings.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SendScoreRepository {
  Future<dynamic> SendGamescoretoAPI(
      int gameScore, int levelID, int GameID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('$path_BaseUrl/score_game/$levelID/$GameID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'score_game': gameScore,
      }),
    );

    if (response.statusCode == 200) {
      print("satuscode is :+${response.statusCode}");
      print("resp is :+${response.body}");
      //-----
      //  var data = jsonDecode(response.body);
      //   token = data['token'];
      //-----
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // return SendScore.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to send score.');
    }
  }
}
