import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:kids_lms_project/data/models/drag_n_drop_model.dart';
import 'package:kids_lms_project/presentation/screen/drag_n_drop_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/strings.dart';
import '../models/path_model.dart';

class DragGameRepository {
  int LevelID_;
  int GameID_;
  DragGameRepository({
    required this.LevelID_,
    required this.GameID_,

  });
  Future<List<DragNDrop>> getDragGame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

  int mainLevel = prefs.getInt('main_level') ?? 0;

    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(
        '$path_BaseUrl/get_game/$LevelID_/$GameID_/$mainLevel',
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
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => DragNDrop.fromJson(e)).toList();
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

  /* Future<Datum> getLevels() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // token = prefs.getString('token')!;
    // print(token);
    Response response = await get(
      Uri.parse(userUrl),
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print("tokennnnn:" + token);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      print("statttttte:" + response.statusCode.toString());
      print("ressssssssss:" + response.body.toString());
      return Datum.fromJson(response.body as Map<String, dynamic>);
      //  result.map((e) => Datum.fromJson(e));
    } else {
      print("errrrrrror:" + response.body.toString());
      throw Exception(response.reasonPhrase).toString();
    }
  }*/
}
