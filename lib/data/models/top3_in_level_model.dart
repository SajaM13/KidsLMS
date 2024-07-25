import 'dart:convert';

class TOP3LevelData {
  List<TopThree> topThree95;
  List<TopThree> topThree80;
  List<TopThree> topThree60;

  TOP3LevelData({
    required this.topThree95,
    required this.topThree80,
    required this.topThree60,
  });

  factory TOP3LevelData.fromRawJson(String str) =>
      TOP3LevelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TOP3LevelData.fromJson(Map<String, dynamic> json) => TOP3LevelData(
        topThree95: List<TopThree>.from(
            json["top three_>=95"].map((x) => TopThree.fromJson(x))),
        topThree80: List<TopThree>.from(
            json["top three_>=80"].map((x) => TopThree.fromJson(x))),
        topThree60: List<TopThree>.from(
            json["top three_>=60"].map((x) => TopThree.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "top three_>=95": List<dynamic>.from(topThree95.map((x) => x.toJson())),
        "top three_>=80": List<dynamic>.from(topThree80.map((x) => x.toJson())),
        "top three_>=60": List<dynamic>.from(topThree60.map((x) => x.toJson())),
      };
}

class TopThree {
  String nickname;
  String name;
  String photo;

  TopThree({
    required this.nickname,
    required this.name,
    required this.photo,
  });

  factory TopThree.fromRawJson(String str) =>
      TopThree.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopThree.fromJson(Map<String, dynamic> json) => TopThree(
        nickname: json["nickname"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
        "photo": photo,
      };
}
