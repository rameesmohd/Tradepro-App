import 'dart:convert';

CourseListModel courseListModelFromJson(String str) =>
    CourseListModel.fromJson(json.decode(str));

// String courseListModelToJson(CourseListModel data) =>
//     json.encode(data.toJson());

class CourseListModel {
  String message;
  CourseFromList courses;
  bool status;

  CourseListModel({
    required this.message,
    required this.courses,
    required this.status,
  });

  factory CourseListModel.fromJson(Map<String, dynamic> json) =>
      CourseListModel(
        message: json["message"],
        courses: CourseFromList.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": courses.toJson(),
        "status": status,
      };
}

class CourseFromList {
  List<AllCourse> allCourses;
  List<PurchasedCourse> purchasedCourses;

  CourseFromList({
    required this.allCourses,
    required this.purchasedCourses,
  });

  factory CourseFromList.fromJson(Map<String, dynamic> json) => CourseFromList(
        allCourses: List<AllCourse>.from(
            json["allCourses"].map((x) => AllCourse.fromJson(x))),
        purchasedCourses: List<PurchasedCourse>.from(
            json["purchasedCourses"].map((x) => PurchasedCourse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "allCourses": List<dynamic>.from(allCourses.map((x) => x.toJson())),
        "purchasedCourses":
            List<dynamic>.from(purchasedCourses.map((x) => x.toJson())),
      };
}

class AllCourse {
  String? id;
  String? previewVideo;
  String? title;
  String? author;
  String? description;
  String? courseType;
  String? price;
  String? publishedYear;
  String? courseDuration;
  List<String>? language;
  List<String>? lessons;
  int? v;

  AllCourse({
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
  });

  factory AllCourse.fromJson(Map<String, dynamic> json) => AllCourse(
        id: json["_id"],
        previewVideo: json["previewVideo"],
        title: json["title"],
        author: json["author"],
        description: json["description"],
        courseType: json["courseType"],
        price: json["price"],
        publishedYear: json["publishedYear"],
        courseDuration: json["courseDuration"],
        language: json["language"] != null
            ? List<String>.from(json["language"].map((x) => x))
            : null,
        lessons: json["lessons"] != null
            ? List<String>.from(json["lessons"].map((x) => x))
            : null,
        v: json["__v"],
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
        // "language": List<dynamic>.from(language.map((x) => x)),
        // "lessons": List<dynamic>.from(lessons.map((x) => x)),
        "__v": v,
      };
}

class PurchasedCourse {
  String id;
  String userId;
  String language;  // Changed from List<String> to String
  PurchasedCourseDetailModel courseModel;
  List<dynamic> isPlayedChapters;
  List<dynamic> isPlayedQuiz;
  String paymentId;
  String purchasedAt;
  int v;

  PurchasedCourse({
    required this.id,
    required this.userId,
    required this.language,  // Changed from List<String> to String
    required this.courseModel,
    required this.isPlayedChapters,
    required this.isPlayedQuiz,
    required this.paymentId,
    required this.purchasedAt,
    required this.v,
  });

  factory PurchasedCourse.fromJson(Map<String, dynamic> json) =>
      PurchasedCourse(
        id: json["_id"],
        userId: json["userId"],
        language: json["language"],  // Keep it as String
        courseModel: PurchasedCourseDetailModel.fromJson(json["courseId"]),
        isPlayedChapters:
            List<dynamic>.from(json["isPlayedChapters"].map((x) => x)),
        isPlayedQuiz: List<dynamic>.from(json["isPlayedQuiz"].map((x) => x)),
        paymentId: json["paymentId"],
        purchasedAt: json["purchasedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "language": language,  // Keep it as String
        "courseId": courseModel.toJson(),
        "isPlayedChapters": List<dynamic>.from(isPlayedChapters.map((x) => x)),
        "isPlayedQuiz": List<dynamic>.from(isPlayedQuiz.map((x) => x)),
        "paymentId": paymentId,
        "purchasedAt": purchasedAt,
        "__v": v,
      };
}

class PurchasedCourseDetailModel {
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

  PurchasedCourseDetailModel({
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
  });

  factory PurchasedCourseDetailModel.fromJson(Map<String, dynamic> json) =>
      PurchasedCourseDetailModel(
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
      };
}
