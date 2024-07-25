import 'dart:convert';

class DragAndDrop {
  List<Index> index1;
  List<Index> index2;

  DragAndDrop({
    required this.index1,
    required this.index2,
  });

  factory DragAndDrop.fromRawJson(String str) =>
      DragAndDrop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DragAndDrop.fromJson(Map<String, dynamic> json) => DragAndDrop(
        index1: List<Index>.from(json["index1"].map((x) => Index.fromJson(x))),
        index2: List<Index>.from(json["index2"].map((x) => Index.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "index1": List<dynamic>.from(index1.map((x) => x.toJson())),
        "index2": List<dynamic>.from(index2.map((x) => x.toJson())),
      };
}

class Index {
  int levelId;
  int id;
  String name;
  String value1;
  String value2;

  Index({
    required this.levelId,
    required this.id,
    required this.name,
    required this.value1,
    required this.value2,
  });

  factory Index.fromRawJson(String str) => Index.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Index.fromJson(Map<String, dynamic> json) => Index(
        levelId: json["level_id"],
        id: json["id"],
        name: json["name"],
        value1: json["value1"],
        value2: json["value2"],
      );

  Map<String, dynamic> toJson() => {
        "level_id": levelId,
        "id": id,
        "name": name,
        "value1": value1,
        "value2": value2,
      };
}
