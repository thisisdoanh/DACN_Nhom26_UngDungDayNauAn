import 'dart:convert';

class CategoryResponse {
  int? status;
  String? message;
  List<CategoryModel>? data;

  CategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CategoryResponse.fromJson(String str) => CategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponse.fromMap(Map<String, dynamic> json) => CategoryResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<CategoryModel>.from(json["data"]!.map((x) => CategoryModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class CategoryModel {
  int? id;
  String? name;

  CategoryModel({
    this.id,
    this.name,
  });

  factory CategoryModel.fromJson(String str) => CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"].toString().trim(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
