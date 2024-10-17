// To parse this JSON data, do
//
//     final DashboardModel = DashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  String message;
  DashboardDataModel? data;
  bool status;

  DashboardModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        message: json["message"],
        data: json["data"] != null
            ? DashboardDataModel.fromJson(json["data"])
            : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        // "data": data.toJson(),
        "status": status,
      };
}

class DashboardDataModel {
  String id;
  String userId;
  int totalIncome;
  List<ActiveUser> totalTeamMembers;
  List<ActiveUser> activeUsers;
  List<dynamic> inActiveUsers;
  List<DataLevel> levels;
  int v;

  DashboardDataModel({
    required this.id,
    required this.userId,
    required this.totalIncome,
    required this.totalTeamMembers,
    required this.activeUsers,
    required this.inActiveUsers,
    required this.levels,
    required this.v,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
        id: json["_id"],
        userId: json["userId"],
        totalIncome: json["totalIncome"],
        totalTeamMembers: List<ActiveUser>.from(
            json["totalTeamMembers"].map((x) => ActiveUser.fromJson(x))),
        activeUsers: List<ActiveUser>.from(
            json["activeUsers"].map((x) => ActiveUser.fromJson(x))),
        inActiveUsers: List<dynamic>.from(json["inActiveUsers"].map((x) => x)),
        levels: List<DataLevel>.from(
            json["levels"].map((x) => DataLevel.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "totalIncome": totalIncome,
        "totalTeamMembers":
            List<dynamic>.from(totalTeamMembers.map((x) => x.toJson())),
        "activeUsers": List<dynamic>.from(activeUsers.map((x) => x.toJson())),
        "inActiveUsers": List<dynamic>.from(inActiveUsers.map((x) => x)),
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
        "__v": v,
      };
}

class ActiveUser {
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
  String referralCode;
  String referredBy;
  List<ActiveUserLevel> levels;
  int v;

  ActiveUser({
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
    required this.referralCode,
    required this.referredBy,
    required this.levels,
    required this.v,
  });

  factory ActiveUser.fromJson(Map<String, dynamic> json) => ActiveUser(
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
        referralCode: json["referralCode"],
        referredBy: json["referredBy"],
        levels: List<ActiveUserLevel>.from(
            json["levels"].map((x) => ActiveUserLevel.fromJson(x))),
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
        "referralCode": referralCode,
        "referredBy": referredBy,
        "levels": List<dynamic>.from(levels.map((x) => x.toJson())),
        "__v": v,
      };
}

class ActiveUserLevel {
  String levelName;
  String userId;
  String id;

  ActiveUserLevel({
    required this.levelName,
    required this.userId,
    required this.id,
  });

  factory ActiveUserLevel.fromJson(Map<String, dynamic> json) =>
      ActiveUserLevel(
        levelName: json["levelName"],
        userId: json["userId"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "levelName": levelName,
        "userId": userId,
        "_id": id,
      };
}

class DataLevel {
  String levelName;
  bool visibility;
  int levelIncome;
  List<String> totalReferrals;
  String id;

  DataLevel({
    required this.levelName,
    required this.visibility,
    required this.levelIncome,
    required this.totalReferrals,
    required this.id,
  });

  factory DataLevel.fromJson(Map<String, dynamic> json) => DataLevel(
        levelName: json["levelName"],
        visibility: json["visibility"],
        levelIncome: json["levelIncome"],
        totalReferrals: List<String>.from(json["totalReferrals"].map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "levelName": levelName,
        "visibility": visibility,
        "levelIncome": levelIncome,
        "totalReferrals": List<dynamic>.from(totalReferrals.map((x) => x)),
        "_id": id,
      };
}
