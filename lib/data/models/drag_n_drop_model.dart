import 'dart:convert';

class DragNDropData {
  bool status;
  List<DragNDrop> data;
  String message;
  int code;

  DragNDropData({
    required this.status,
    required this.data,
    required this.message,
    required this.code,
  });

  factory DragNDropData.fromRawJson(String str) =>
      DragNDropData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DragNDropData.fromJson(Map<String, dynamic> json) => DragNDropData(
        status: json["status"],
        data: List<DragNDrop>.from(
            json["data"].map((x) => DragNDrop.fromJson(x))),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "code": code,
      };
}

class DragNDrop {
  List<Index> index1;
  List<Index> index1Copy;
  List<Index> index2;
  List<Index> index2Copy;

  DragNDrop({
    required this.index1,
    required this.index1Copy,
    required this.index2,
    required this.index2Copy,
  });

  factory DragNDrop.fromRawJson(String str) =>
      DragNDrop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DragNDrop.fromJson(Map<String, dynamic> json) => DragNDrop(
        index1: List<Index>.from(json["index1"].map((x) => Index.fromJson(x))),
        index1Copy:
            List<Index>.from(json["index1_copy"].map((x) => Index.fromJson(x))),
        index2: List<Index>.from(json["index2"].map((x) => Index.fromJson(x))),
        index2Copy:
            List<Index>.from(json["index2_copy"].map((x) => Index.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "index1": List<dynamic>.from(index1.map((x) => x.toJson())),
        "index1_copy": List<dynamic>.from(index1Copy.map((x) => x.toJson())),
        "index2": List<dynamic>.from(index2.map((x) => x.toJson())),
        "index2_copy": List<dynamic>.from(index2Copy.map((x) => x.toJson())),
      };
}

class Index {
  String name;
  String value1;
  String value2;
  String type;
  int scoreGame;

  Index({
    required this.name,
    required this.value1,
    required this.value2,
    required this.type,
    required this.scoreGame,
  });

  factory Index.fromRawJson(String str) => Index.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Index.fromJson(Map<String, dynamic> json) => Index(
        name: json["name"],
        value1: json["value1"],
        value2: json["value2"],
        type: json["type"],
        scoreGame: json["score_game"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value1": value1,
        "value2": value2,
        "type": type,
        "score_game": scoreGame,
      };
}
