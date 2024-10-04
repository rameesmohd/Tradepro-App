import 'dart:convert';

import 'package:hive/hive.dart';

part 'login_model.g.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

Map<String, dynamic> loginModelToJson(LoginModel data) => data.toJson();


@HiveType(typeId:0)
class LoginModel {
  @HiveField(0)
  String? message;
  @HiveField(1)
  String? jwtToken;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? id;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? password;
  @HiveField(6)
  bool? status;

  LoginModel(
      {this.message,
      this.jwtToken,
      this.name,
      this.id,
      this.email,
      this.status,
      this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
      message: json["message"],
      jwtToken: json["jwtToken"],
      name: json["name"],
      id: json["id"],
      status: json['status']);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
