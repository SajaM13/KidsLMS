
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kids_lms_project/constants/strings.dart';
import 'package:kids_lms_project/data/models/drag_and_drop_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


// ignore: camel_case_types
class DragNDropRepository {
  // ignore: non_constant_identifier_names
  int LevelID;
  // ignore: non_constant_identifier_names
  int GameID;
  DragNDropRepository({
    // ignore: non_constant_identifier_names
    required this.LevelID,

    // ignore: non_constant_identifier_names
    required this.GameID,
  });
  Future<List<DragAndDrop>> getLevels() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
        '$path_BaseUrl/get_game/$LevelID/$GameID',
      ),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("response.statusCode--:");
      print(response.statusCode);
      print("response.body--:");
      print(response.body);
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => DragAndDrop.fromJson(e)).toList();
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
