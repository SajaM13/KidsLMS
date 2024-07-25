import 'dart:convert';

class TOP3Data {
  List<Top> top1;
  List<Top> top2;
  List<Top> top3;

  TOP3Data({
    required this.top1,
    required this.top2,
    required this.top3,
  });

  factory TOP3Data.fromRawJson(String str) =>
      TOP3Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TOP3Data.fromJson(Map<String, dynamic> json) => TOP3Data(
        top1: List<Top>.from(json["top 1"].map((x) => Top.fromJson(x))),
        top2: List<Top>.from(json["top 2"].map((x) => Top.fromJson(x))),
        top3: List<Top>.from(json["top 3"].map((x) => Top.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "top 1": List<dynamic>.from(top1.map((x) => x.toJson())),
        "top 2": List<dynamic>.from(top2.map((x) => x.toJson())),
        "top 3": List<dynamic>.from(top3.map((x) => x.toJson())),
      };
}

class Top {
  String nickname;
  String name;
  String photo;
  String totalScores;

  Top({
    required this.nickname,
    required this.name,
    required this.photo,
    required this.totalScores,
  });

  factory Top.fromRawJson(String str) => Top.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Top.fromJson(Map<String, dynamic> json) => Top(
        nickname: json["nickname"],
        name: json["name"],
        photo: json["photo"],
        totalScores: json["total_scores"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "name": name,
        "photo": photo,
        "total_scores": totalScores,
      };
}
