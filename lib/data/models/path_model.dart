// To parse this JSON data, do
//
//     final coursePath = coursePathFromJson(jsonString);

import 'dart:convert';

/*class CoursePath {
  bool status;
  List<Datum> data;
  String message;
  int code;

  CoursePath({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory CoursePath.fromRawJson(String str) =>
      CoursePath.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoursePath.fromJson(Map<String, dynamic> json) => CoursePath(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}*/

class Datum {
  int levelNumber;
  int levelId;
  String isavailable;
  String isquiz;
  List<Name> name;

  Datum({
    required this.levelNumber,
    required this.levelId,
    required this.isavailable,
    required this.isquiz,
    required this.name,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        levelNumber: json["level_number"],
        levelId: json["level_id"],
        isavailable: json["isavailable"],
        isquiz: json["isquiz"],
        name: List<Name>.from(json["name"].map((x) => Name.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level_number": levelNumber,
        "level_id": levelId,
        "isavailable": isavailable,
        "isquiz": isquiz,
        "name": List<dynamic>.from(name.map((x) => x.toJson())),
      };
}

class Name {
  String nickname;
  String name;

  Name({
    required this.nickname,
    required this.name,
  });

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        nickname: json["nickname"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
      };
}
