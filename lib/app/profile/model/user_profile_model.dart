import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  String message;
  UserModel user;
  bool status;

  UserProfileModel({
    required this.message,
    required this.user,
    required this.status,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        message: json["message"],
        user: UserModel.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": user.toJson(),
        "status": status,
      };
}

class UserModel {
  String id;
  String name;
  String email;
  String countryCode;
  String phoneNumber;
  String password;
  bool isNotification;
  String profileImage;
  String status;
  bool isAdmin;
  int v;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phoneNumber,
    required this.password,
    required this.isNotification,
    required this.profileImage,
    required this.status,
    required this.isAdmin,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        countryCode: json["countryCode"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        isNotification: json["isNotification"],
        profileImage: json["profileImage"],
        status: json["status"],
        isAdmin: json["isAdmin"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "countryCode": countryCode,
        "phoneNumber": phoneNumber,
        "password": password,
        "isNotification": isNotification,
        "profileImage": profileImage,
        "status": status,
        "isAdmin": isAdmin,
        "__v": v,
      };
}
