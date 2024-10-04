// To parse this JSON data, do
//
//     final CheckoutModel = CheckoutModelFromJson(jsonString);

import 'dart:convert';

CheckoutModel checkoutModelFromJson(String str) =>
    CheckoutModel.fromJson(json.decode(str));

String checkoutModelToJson(CheckoutModel data) => json.encode(data.toJson());

class CheckoutModel {
  String? userId;
  String? language;
  String? courseId;
  String? paymentId;
  String? message;
  bool? status;

  CheckoutModel(
      {this.userId,
      this.language,
      this.courseId,
      this.paymentId,
      this.message,
      this.status});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
      userId: json["userId"],
      language: json["language"],
      courseId: json["courseId"],
      paymentId: json["paymentId"],
      message: json["message"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "language": language,
        "courseId": courseId,
        "paymentId": '1234',
      };
}
