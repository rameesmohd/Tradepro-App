// To parse this JSON data, do
//
//     final WishListModel = WishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  String message;
  List<WishListCourses> courses;

  WishListModel({
    required this.message,
    required this.courses,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        message: json["message"],
        courses: List<WishListCourses>.from(
            json["data"].map((x) => WishListCourses.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(courses.map((x) => x.toJson())),
      };
}

class WishListCourses {
  String id;
  WishListCourse course;
  String language;
  String userId;
  int v;

  WishListCourses({
    required this.id,
    required this.course,
    required this.language,
    required this.userId,
    required this.v,
  });

  factory WishListCourses.fromJson(Map<String, dynamic> json) =>
      WishListCourses(
        id: json["_id"],
        course: WishListCourse.fromJson(json["courseId"]),
        language: json["language"],
        userId: json["userId"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courseId": course.toJson(),
        "language": language,
        "userId": userId,
        "__v": v,
      };
}

class WishListCourse {
  String id;
  String previewVideo;
  String title;
  String author;
  String description;
  String courseType;
  String price;
  String publishedYear;
  String courseDuration;
  List<String> language;
  List<String> lessons;
  int v;
  List<String> wishlistUser;

  WishListCourse({
    required this.id,
    required this.previewVideo,
    required this.title,
    required this.author,
    required this.description,
    required this.courseType,
    required this.price,
    required this.publishedYear,
    required this.courseDuration,
    required this.language,
    required this.lessons,
    required this.v,
    required this.wishlistUser,
  });

  factory WishListCourse.fromJson(Map<String, dynamic> json) => WishListCourse(
        id: json["_id"],
        previewVideo: json["previewVideo"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        courseType: json["courseType"],
        price: json["price"],
        publishedYear: json["publishedYear"],
        courseDuration: json["courseDuration"],
        language: List<String>.from(json["language"].map((x) => x)),
        lessons: List<String>.from(json["lessons"].map((x) => x)),
        v: json["__v"],
        wishlistUser: List<String>.from(json["wishlist_User"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "previewVideo": previewVideo,
        "title": title,
        "author": author,
        "description": description,
        "courseType": courseType,
        "price": price,
        "publishedYear": publishedYear,
        "courseDuration": courseDuration,
        "language": List<dynamic>.from(language.map((x) => x)),
        "lessons": List<dynamic>.from(lessons.map((x) => x)),
        "__v": v,
        "wishlist_User": List<dynamic>.from(wishlistUser.map((x) => x)),
      };
}
