// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String id;
  String username;
  String password;
  String address;
  String email;
  String firstname;
  String lastname;
  String phone;
  String gender;

  Users({
    this.id,
    this.username,
    this.password,
    this.address,
    this.email,
    this.firstname,
    this.lastname,
    this.phone,
    this.gender,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    address: json["address"],
    email: json["email"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    phone: json["phone"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "address": address,
    "email": email,
    "firstname": firstname,
    "lastname": lastname,
    "phone": phone,
    "gender": gender,
  };
}