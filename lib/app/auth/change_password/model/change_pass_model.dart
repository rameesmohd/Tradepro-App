import 'dart:convert';

ChangePassModel changePassModelFromJson(String str) =>
    ChangePassModel.fromJson(json.decode(str));

String changePassModelToJson(ChangePassModel data) =>
    json.encode(data.toJson());

class ChangePassModel {
  String? message;
  bool? status;

  ChangePassModel({
    required this.message,
    required this.status,
  });

  factory ChangePassModel.fromJson(Map<String, dynamic> json) =>
      ChangePassModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
