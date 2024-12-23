import 'dart:convert';

import 'category_response_model.dart';

class RecipeResponse {
  int? status;
  String? message;
  Data? data;

  RecipeResponse({
    this.status,
    this.message,
    this.data,
  });

  factory RecipeResponse.fromJson(String str) => RecipeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeResponse.fromMap(Map<String, dynamic> json) {
    Map<String, dynamic> dataMap = {};
    if (json["data"] is! Map) {
      dataMap = {
        "items": json["data"],
      };
    } else {
      dataMap = json["data"];
    }

    return RecipeResponse(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromMap(dataMap),
    );
  }

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  int? lastElementId;
  List<RecipeModel>? items;

  Data({
    this.lastElementId,
    this.items,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) {
    if (json is List) {
      return Data(
        lastElementId: null,
        items: List<RecipeModel>.from((json as List).map((x) => RecipeModel.fromMap(x))),
      );
    }

    return Data(
      lastElementId: json["lastElementId"],
      items: json["items"] == null ? [] : List<RecipeModel>.from(json["items"]!.map((x) => RecipeModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "lastElementId": lastElementId,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class RecipeModel {
  int? id;
  String? recipeName;
  String? prepTime;
  String? cookTime;
  List<Ingredient>? ingredients;
  List<Instruction>? instructions;
  CategoryModel? category;
  User? user;
  double? rating;
  String? image;
  String? imageUrl;

  RecipeModel({
    this.id,
    this.recipeName,
    this.prepTime,
    this.cookTime,
    this.ingredients,
    this.instructions,
    this.category,
    this.user,
    this.image,
    this.imageUrl,
    this.rating,
  });

  factory RecipeModel.fromJson(String str) => RecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromMap(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        recipeName: json["recipeName"],
        prepTime: json["prepTime"],
        cookTime: json["cookTime"],
        ingredients: json["ingredients"] == null
            ? []
            : List<Ingredient>.from(json["ingredients"]!.map((x) => Ingredient.fromMap(x))),
        instructions: json["instructions"] == null
            ? []
            : List<Instruction>.from(json["instructions"]!.map((x) => Instruction.fromMap(x))),
        category: json["category"] == null ? null : CategoryModel.fromMap(json["category"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        image: json["image"],
        imageUrl: json["imageUrl"],
        rating: json["rating"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "recipeName": recipeName,
        "prepTime": prepTime,
        "cookTime": cookTime,
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x.toMap())),
        "instructions": instructions == null ? [] : List<dynamic>.from(instructions!.map((x) => x.toMap())),
        "category": category?.toMap(),
        "user": user?.toMap(),
        "image": image,
        "imageUrl": imageUrl,
        "rating": rating,
      };

        @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Ingredient {
  int? id;
  String? name;
  String? amount;

  Ingredient({
    this.id,
    this.name,
    this.amount,
  });

  factory Ingredient.fromJson(String str) => Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "amount": amount,
      };
}

class Instruction {
  int? id;
  String? description;

  Instruction({
    this.id,
    this.description,
  });

  factory Instruction.fromJson(String str) => Instruction.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Instruction.fromMap(Map<String, dynamic> json) => Instruction(
        id: json["id"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
      };
}

class User {
  String? firstName;
  String? lastName;

  User({
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
      };
}
