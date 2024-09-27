// import 'dart:convert';

// CourseListModel courseListModelFromJson(String str) =>
//     CourseListModel.fromJson(json.decode(str));

// // String courseListModelToJson(CourseListModel data) =>
// //     json.encode(data.toJson());

// class CourseListModel {
//   String message;
//   List<CourseFromList> courses;
//   bool status;

//   CourseListModel({
//     required this.message,
//     required this.courses,
//     required this.status,
//   });

//   factory CourseListModel.fromJson(Map<String, dynamic> json) =>
//       CourseListModel(
//         message: json["message"],
//         courses: List<CourseFromList>.from(
//             json["data"].map((x) => CourseFromList.fromJson(x))),
//         status: json["status"],
//       );

//   // Map<String, dynamic> toJson() => {
//   //       "message": message,
//   //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   //       "status": status,
//   //     };
// }

// class CourseFromList {
//   String id;
//   String previewVideo;
//   String title;
//   String author;
//   String description;
//   String courseType;
//   String price;
//   List<String> language;
//   List<Lesson> lessons;
//   int v;

//   CourseFromList({
//     required this.id,
//     required this.previewVideo,
//     required this.title,
//     required this.author,
//     required this.description,
//     required this.courseType,
//     required this.price,
//     required this.language,
//     required this.lessons,
//     required this.v,
//   });

//   factory CourseFromList.fromJson(Map<String, dynamic> json) => CourseFromList(
//         id: json["_id"],
//         previewVideo: json["previewVideo"],
//         title: json["title"],
//         author: json["author"],
//         description: json["description"],
//         courseType: json["courseType"],
//         price: json["price"],
//         language: List<String>.from(json["language"].map((x) => x)),
//         lessons:
//             List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "previewVideo": previewVideo,
//         "title": title,
//         "author": author,
//         "description": description,
//         "courseType": courseType,
//         "price": price,
//         "language": List<dynamic>.from(language.map((x) => x)),
//         "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
//         "__v": v,
//       };
// }

// class Lesson {
//   String lessonName;
//   String id;
//   List<Chapter> chapters;

//   Lesson({
//     required this.lessonName,
//     required this.id,
//     required this.chapters,
//   });

//   factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
//         lessonName: json["lessonName"],
//         id: json["_id"],
//         chapters: List<Chapter>.from(
//             json["chapters"].map((x) => Chapter.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "lessonName": lessonName,
//         "_id": id,
//         "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
//       };
// }

// class Chapter {
//   String title;
//   String video;
//   String id;
//   List<dynamic> quiz;

//   Chapter({
//     required this.title,
//     required this.video,
//     required this.id,
//     required this.quiz,
//   });

//   factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
//         title: json["title"],
//         video: json["video"],
//         id: json["_id"],
//         quiz: List<dynamic>.from(json["quiz"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "video": video,
//         "_id": id,
//         "quiz": List<dynamic>.from(quiz.map((x) => x)),
//       };
// }

// To parse this JSON data, do
//
//     final CourseListModel = CourseListModelFromJson(jsonString);

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
  List<dynamic> purchasedCourses;

  CourseFromList({
    required this.allCourses,
    required this.purchasedCourses,
  });

  factory CourseFromList.fromJson(Map<String, dynamic> json) => CourseFromList(
        allCourses: List<AllCourse>.from(
            json["allCourses"].map((x) => AllCourse.fromJson(x))),
        purchasedCourses:
            List<dynamic>.from(json["purchasedCourses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "allCourses": List<dynamic>.from(allCourses.map((x) => x.toJson())),
        "purchasedCourses": List<dynamic>.from(purchasedCourses.map((x) => x)),
      };
}

class AllCourse {
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
