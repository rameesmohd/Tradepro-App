import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

Map<String, dynamic> loginModelToJson(LoginModel data) => data.toJson();

class LoginModel {
  String? message;
  String? jwtToken;
  String? name;
  String? id;
  String? email;
  String? password;
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
