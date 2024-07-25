import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/data/models/pdf_lessons_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PDFLessonsRepository {
  int LevelID;
  PDFLessonsRepository({
    required this.LevelID,
  });
  Future<List<PDFData>> getlessons() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(
        '$path_BaseUrl/show_info_level/$LevelID',
      ),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print("response.statusCode--:");
      print(response.statusCode);
      print("response.body--:");
      print(response.body);
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final List result = jsonDecode(response.body)["data"];
      return result.map((e) => PDFData.fromJson(e)).toList();
    } else {
      print("response.statusCode--:");
      print(response.statusCode);
      print("response.body--:errrrrrrrrrooooor");
      print(response.body);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data').toString();
    }
  }
}
