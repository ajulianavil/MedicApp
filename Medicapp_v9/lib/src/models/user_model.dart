// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.uid,
    this.name,
    this.lastName,
    this.address,
    this.phone,
    this.gender,
    this.bornDate,
    this.email,
    this.rol,
  });

  String uid;
  String name;
  String lastName;
  String address;
  String phone;
  String gender;
  String bornDate;
  String email;
  String rol;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        lastName: json["lastName"],
        address: json["address"],
        phone: json["phone"],
        gender: json["gender"],
        bornDate: json["bornDate"],
        email: json["email"],
        rol: json["rol"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "lastName": lastName,
        "address": address,
        "phone": phone,
        "gender": gender,
        "bornDate": bornDate,
        "email": email,
        "rol": rol,
      };
}
