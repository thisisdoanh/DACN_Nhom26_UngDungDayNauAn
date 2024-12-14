import 'dart:convert';

class UserInfoResponse {
  int? status;
  String? message;
  UserInfo? data;

  UserInfoResponse({
    this.status,
    this.message,
    this.data,
  });

  factory UserInfoResponse.fromJson(String str) => UserInfoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfoResponse.fromMap(Map<String, dynamic> json) => UserInfoResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : UserInfo.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
      };
}

class UserInfo {
  int? id;
  String? email;
  DateTime? dob;
  String? firstName;
  String? lastName;
  List<Role>? roles;

  UserInfo({
    this.id,
    this.email,
    this.dob,
    this.firstName,
    this.lastName,
    this.roles,
  });

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
        "firstName": firstName,
        "lastName": lastName,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toMap())),
      };
}

class Role {
  String? name;
  String? description;
  List<Permission>? permissions;

  Role({
    this.name,
    this.description,
    this.permissions,
  });

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        name: json["name"],
        description: json["description"],
        permissions: json["permissions"] == null
            ? []
            : List<Permission>.from(json["permissions"]!.map((x) => Permission.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x.toMap())),
      };
}

class Permission {
  String? name;
  String? description;

  Permission({
    this.name,
    this.description,
  });

  factory Permission.fromJson(String str) => Permission.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permission.fromMap(Map<String, dynamic> json) => Permission(
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
      };
}
