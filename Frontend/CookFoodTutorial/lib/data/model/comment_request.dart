class CommentRequest {
  String? userId;
  String? recipeId;
  String? commentIndex;
  String? comment;
  String? rating;
  bool isUpdate;

  CommentRequest({
    this.userId,
    this.recipeId,
    this.commentIndex,
    this.comment,
    this.rating,
    this.isUpdate = false,
  });

  factory CommentRequest.fromJson(Map<String, dynamic> json) => CommentRequest(
        userId: json["userId"],
        recipeId: json["recipeId"],
        commentIndex: json["commentIndex"],
        comment: json["comment"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "recipeId": recipeId,
        "commentIndex": commentIndex,
        "comment": comment,
        "rating": rating,
      };
}
