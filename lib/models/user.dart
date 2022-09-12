// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  String name;
  String email;
  bool isOnline;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? uid;

  User({
    required this.name,
    required this.email,
    required this.isOnline,
    this.createdAt,
    this.updatedAt,
    this.uid,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        isOnline: json["isOnline"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "isOnline": isOnline,
        "uid": uid,
      };
}
