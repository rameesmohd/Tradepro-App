import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

Map<String, dynamic> registerModelOtpToJson(RegisterModel data) =>
    data.toOtpJosn();
Map<String, dynamic> registerModelUserDetails(RegisterModel data) =>
    data.toUserAllJson();

class RegisterModel {
  String? message;
  String? jwtToken;
  String? name;
  String? id;
  String? email;
  String? password;
  bool? status;
  String? phoneNumber;
  String? countryCode;
  String? otp;

  RegisterModel(
      {this.message,
      this.jwtToken,
      this.phoneNumber,
      this.otp,
      this.countryCode,
      this.name,
      this.id,
      this.email,
      this.status,
      this.password});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
      message: json["message"],
      jwtToken: json["jwtToken"],
      name: json["name"],
      id: json["id"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      countryCode: json["countryCode"],
      password: json["password"],
      otp: json["otp"],
      status: json['status']);

  Map<String, dynamic> toOtpJosn() => {
        "email": email,
        "phoneNumber": phoneNumber,
      };
  Map<String, dynamic> toUserAllJson() => {
        "email": email,
        "password": password,
        "name": name,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
        "otp": otp
      };
}
