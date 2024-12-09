import 'dart:convert';

class UserToken {
  int? status;
  String? message;
  Data? data;

  UserToken({
    this.status,
    this.message,
    this.data,
  });

  factory UserToken.fromJson(String str) => UserToken.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserToken.fromMap(Map<String, dynamic> json) => UserToken(
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
  String? token;
  bool? authenticated;

  Data({
    this.token,
    this.authenticated,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        token: json["token"],
        authenticated: json["authenticated"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "authenticated": authenticated,
      };
}
