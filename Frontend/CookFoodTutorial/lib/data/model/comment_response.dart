import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CommentResponse {
  int? status;
  String? message;
  List<CommentModel>? data;

  CommentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        status: json["status"],
        message: json["message"],
        data: List<CommentModel>.from(
            json["data"].map((x) => CommentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data?.map((x) => x.toJson()) ?? []),
      };
}

class CommentModel {
  User? user;
  int? recipeId;
  String? commentIndex;
  String? comment;
  int? rating;
  RxBool isMe = false.obs;

  CommentModel({
    this.user,
    this.recipeId,
    this.commentIndex,
    this.comment,
    this.rating,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        user: User.fromJson(json["user"]),
        recipeId: json["recipeId"],
        commentIndex: json["commentIndex"],
        comment: json["comment"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "recipeId": recipeId,
        "commentIndex": commentIndex,
        "comment": comment,
        "rating": rating,
      };
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}
