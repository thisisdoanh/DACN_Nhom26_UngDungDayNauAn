import 'dart:convert';

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

  factory RecipeResponse.fromMap(Map<String, dynamic> json) => RecipeResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

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

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        lastElementId: json["lastElementId"],
        items: json["items"] == null ? [] : List<RecipeModel>.from(json["items"]!.map((x) => RecipeModel.fromMap(x))),
      );

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
  Category? category;
  User? user;
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
        category: json["category"] == null ? null : Category.fromMap(json["category"]),
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        image: json["image"],
        imageUrl: json["imageUrl"],
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
      };
}

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
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
