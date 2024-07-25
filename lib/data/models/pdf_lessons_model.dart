import 'dart:convert';

class PdfModel {
  List<PDFData> data;

  PdfModel({
    required this.data,
  });

  factory PdfModel.fromRawJson(String str) =>
      PdfModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PdfModel.fromJson(Map<String, dynamic> json) => PdfModel(
        data: List<PDFData>.from(json["data"].map((x) => PDFData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PDFData {
  int id;
  String description;
  String name;
  String fileName;
  String path;

  PDFData({
    required this.id,
    required this.description,
    required this.name,
    required this.fileName,
    required this.path,
  });

  factory PDFData.fromRawJson(String str) => PDFData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PDFData.fromJson(Map<String, dynamic> json) => PDFData(
        id: json["id"],
        description: json["description"],
        name: json["name"],
        fileName: json["file_name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "name": name,
        "file_name": fileName,
        "path": path,
      };
}
