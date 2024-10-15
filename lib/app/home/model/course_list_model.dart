// import 'dart:convert';
// import 'dart:developer';

// CourseListModel? courseListModelFromJson(dynamic str) {
//   log('Input: $str');
//   try {
//     dynamic decodedJson;
//     if (str is String) {
//       log('Decoding string to JSON...');
//       decodedJson = json.decode(str);
//     } else if (str is Map<String, dynamic>) {
//       log('Input is already a JSON map');
//       decodedJson = str;
//     } else {
//       log('Invalid input type');
//       return null;
//     }

//     log('Decoded JSON: $decodedJson');

//     // Now try to parse it into the model
//     return CourseListModel.fromJson(decodedJson);
//   } catch (e, stackTrace) {
//     log('Error during parsing: $e');
//     log('Stack trace: $stackTrace');
//     return null;
//   }
// }

// // String? courseListModelToJson(CourseListModel? data) =>
// //     json.encode(data?.toJson());

// class CourseListModel {
//   String? message;
//   CourseFromList? courses;
//   bool? status;

//   CourseListModel({
//     this.message,
//     this.courses,
//     this.status,
//   });

//   factory CourseListModel.fromJson(Map<String, dynamic> json) =>
//       CourseListModel(
//         message: json["message"],
//         courses:
//             json["data"] != null ? CourseFromList.fromJson(json["data"]) : null,
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": courses?.toJson(),
//         "status": status,
//       };
// }

// class CourseFromList {
//   List<AllCourse?>? allCourses;
//   List<PurchasedCourse?>? purchasedCourses;

//   CourseFromList({
//     this.allCourses,
//     this.purchasedCourses,
//   });

//   factory CourseFromList.fromJson(Map<String, dynamic> json) => CourseFromList(
//         allCourses: json["allCourses"] != null
//             ? List<AllCourse>.from(
//                 json["allCourses"].map((x) => AllCourse.fromJson(x)))
//             : null,
//         purchasedCourses: json["purchasedCourses"] != null
//             ? List<PurchasedCourse>.from(json["purchasedCourses"]
//                 .map((x) => PurchasedCourse.fromJson(x)))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "allCourses": allCourses != null
//             ? List<dynamic>.from(allCourses!.map((x) => x?.toJson() ?? {}))
//             : null,
//         "purchasedCourses": purchasedCourses != null
//             ? List<dynamic>.from(
//                 purchasedCourses!.map((x) => x?.toJson() ?? {}))
//             : null,
//       };
// }

// class AllCourse {
//   String? id;
//   String? previewVideo;
//   String? title;
//   String? author;
//   String? description;
//   String? courseType;
//   String? price;
//   String? publishedYear;
//   String? courseDuration;
//   List<String?>? language;
//   List<String?>? lessons;
//   int? v;
//   List<dynamic>? wishlistUser;

//   AllCourse({
//     this.id,
//     this.previewVideo,
//     this.title,
//     this.author,
//     this.description,
//     this.courseType,
//     this.price,
//     this.publishedYear,
//     this.courseDuration,
//     this.language,
//     this.lessons,
//     this.v,
//     this.wishlistUser,
//   });

//   factory AllCourse.fromJson(Map<String, dynamic> json) => AllCourse(
//         id: json["_id"],
//         previewVideo: json["previewVideo"],
//         title: json["title"],
//         author: json["author"],
//         description: json["description"],
//         courseType: json["courseType"],
//         price: json["price"],
//         publishedYear: json["publishedYear"],
//         courseDuration: json["courseDuration"],
//         language: json["language"] != null
//             ? List<String>.from(json["language"].map((x) => x))
//             : null,
//         lessons: json["lessons"] != null
//             ? List<String>.from(json["lessons"].map((x) => x))
//             : null,
//         v: json["__v"],
//         wishlistUser: json["wishlist_User"] != null
//             ? List<dynamic>.from(json["wishlist_User"].map((x) => x))
//             : null,
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "previewVideo": previewVideo,
//         "title": title,
//         "author": author,
//         "description": description,
//         "courseType": courseType,
//         "price": price,
//         "publishedYear": publishedYear,
//         "courseDuration": courseDuration,
//         "language": language != null
//             ? List<dynamic>.from(language!.map((x) => x))
//             : null,
//         "lessons":
//             lessons != null ? List<dynamic>.from(lessons!.map((x) => x)) : null,
//         "__v": v,
//         "wishlist_User": wishlistUser != null
//             ? List<dynamic>.from(wishlistUser!.map((x) => x))
//             : null,
//       };
// }

// class PurchasedCourse {
//   String? id;
//   String? userId;
//   String? language;
//   PurchasedCourseDetailModel? courseModel;
//   List<dynamic>? isPlayedChapters;
//   List<dynamic>? isPlayedQuiz;
//   String? paymentId;
//   String? purchasedAt;
//   int? v;

//   PurchasedCourse({
//     this.id,
//     this.userId,
//     this.language,
//     this.courseModel,
//     this.isPlayedChapters,
//     this.isPlayedQuiz,
//     this.paymentId,
//     this.purchasedAt,
//     this.v,
//   });

//   factory PurchasedCourse.fromJson(Map<String, dynamic> json) =>
//       PurchasedCourse(
//         id: json["_id"],
//         userId: json["userId"],
//         language: json["language"],
//         courseModel: json["courseId"] != null
//             ? PurchasedCourseDetailModel.fromJson(json["courseId"])
//             : null,
//         isPlayedChapters: json["isPlayedChapters"] != null
//             ? List<dynamic>.from(json["isPlayedChapters"].map((x) => x))
//             : null,
//         isPlayedQuiz: json["isPlayedQuiz"] != null
//             ? List<dynamic>.from(json["isPlayedQuiz"].map((x) => x))
//             : null,
//         paymentId: json["paymentId"],
//         purchasedAt: json["purchasedAt"],
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "language": language,
//         "courseId": courseModel?.toJson(),
//         "isPlayedChapters": isPlayedChapters != null
//             ? List<dynamic>.from(isPlayedChapters!.map((x) => x))
//             : null,
//         "isPlayedQuiz": isPlayedQuiz != null
//             ? List<dynamic>.from(isPlayedQuiz!.map((x) => x))
//             : null,
//         "paymentId": paymentId,
//         "purchasedAt": purchasedAt,
//         "__v": v,
//       };
// }

// class PurchasedCourseDetailModel {
//   String? id;
//   String? previewVideo;
//   String? title;
//   String? author;
//   String? description;
//   String? courseType;
//   String? price;
//   String? publishedYear;
//   String? courseDuration;
//   List<String?>? language;
//   List<String?>? lessons;
//   int? v;

//   PurchasedCourseDetailModel({
//     this.id,
//     this.previewVideo,
//     this.title,
//     this.author,
//     this.description,
//     this.courseType,
//     this.price,
//     this.publishedYear,
//     this.courseDuration,
//     this.language,
//     this.lessons,
//     this.v,
//   });

//   factory PurchasedCourseDetailModel.fromJson(Map<String, dynamic> json) =>
//       PurchasedCourseDetailModel(
//         id: json["_id"],
//         previewVideo: json["previewVideo"],
//         title: json["title"],
//         author: json["author"],
//         description: json["description"],
//         courseType: json["courseType"],
//         price: json["price"],
//         publishedYear: json["publishedYear"],
//         courseDuration: json["courseDuration"],
//         language: json["language"] != null
//             ? List<String>.from(json["language"].map((x) => x))
//             : null,
//         lessons: json["lessons"] != null
//             ? List<String>.from(json["lessons"].map((x) => x))
//             : null,
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
//         "publishedYear": publishedYear,
//         "courseDuration": courseDuration,
//         "language": language != null
//             ? List<dynamic>.from(language!.map((x) => x))
//             : null,
//         "lessons":
//             lessons != null ? List<dynamic>.from(lessons!.map((x) => x)) : null,
//         "__v": v,
//       };
// }

// To parse this JSON data, do
//
//     final CourseListModel = CourseListModelFromJson(jsonString);

import 'dart:convert';

CourseListModel courseListModelFromJson(String str) =>
    CourseListModel.fromJson(json.decode(str));

String courseListModelToJson(CourseListModel data) =>
    json.encode(data.toJson());

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
  List<dynamic> wishlistUser;

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
    required this.wishlistUser,
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
        wishlistUser: List<dynamic>.from(json["wishlist_User"].map((x) => x)),
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

class PurchasedCourse {
  String id;
  String userId;
  String language;
  PurchasedCourseDetailModel courseModel;
  List<String> isPlayedChapters;
  List<dynamic> isPlayedQuiz;
  String paymentId;
  String purchasedAt;
  int v;
  int totalChapters;
  int totalQuiz;

  PurchasedCourse({
    required this.id,
    required this.userId,
    required this.language,
    required this.courseModel,
    required this.isPlayedChapters,
    required this.isPlayedQuiz,
    required this.paymentId,
    required this.purchasedAt,
    required this.v,
    required this.totalChapters,
    required this.totalQuiz,
  });

  factory PurchasedCourse.fromJson(Map<String, dynamic> json) =>
      PurchasedCourse(
        id: json["_id"],
        userId: json["userId"],
        language: json["language"],
        courseModel: PurchasedCourseDetailModel.fromJson(json["courseId"]),
        isPlayedChapters:
            List<String>.from(json["isPlayedChapters"].map((x) => x)),
        isPlayedQuiz: List<dynamic>.from(json["isPlayedQuiz"].map((x) => x)),
        paymentId: json["paymentId"],
        purchasedAt: json["purchasedAt"],
        v: json["__v"],
        totalChapters: json["totalChapters"],
        totalQuiz: json["totalQuiz"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "language": language,
        "courseId": courseModel.toJson(),
        "isPlayedChapters": List<dynamic>.from(isPlayedChapters.map((x) => x)),
        "isPlayedQuiz": List<dynamic>.from(isPlayedQuiz.map((x) => x)),
        "paymentId": paymentId,
        "purchasedAt": purchasedAt,
        "__v": v,
        "totalChapters": totalChapters,
        "totalQuiz": totalQuiz,
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
  List<Lesson> lessons;
  int v;
  List<dynamic> wishlistUser;

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
    required this.wishlistUser,
  });

  factory PurchasedCourseDetailModel.fromJson(Map<String, dynamic> json) => PurchasedCourseDetailModel(
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
        lessons:
            List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
        v: json["__v"],
        wishlistUser: List<dynamic>.from(json["wishlist_User"].map((x) => x)),
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
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
        "__v": v,
        "wishlist_User": List<dynamic>.from(wishlistUser.map((x) => x)),
      };
}

class Lesson {
  String id;
  String courseId;
  String lessonLanguage;
  String lessonName;
  List<Chapter> chapters;
  List<Quiz> quiz;
  int v;

  Lesson({
    required this.id,
    required this.courseId,
    required this.lessonLanguage,
    required this.lessonName,
    required this.chapters,
    required this.quiz,
    required this.v,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["_id"],
        courseId: json["courseId"],
        lessonLanguage: json["lessonLanguage"],
        lessonName: json["lessonName"],
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
        quiz: List<Quiz>.from(json["quiz"].map((x) => Quiz.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courseId": courseId,
        "lessonLanguage": lessonLanguage,
        "lessonName": lessonName,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "quiz": List<dynamic>.from(quiz.map((x) => x.toJson())),
        "__v": v,
      };
}

class Chapter {
  String id;
  String lessonId;
  String title;
  String video;
  int v;

  Chapter({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.video,
    required this.v,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["_id"],
        lessonId: json["lessonId"],
        title: json["title"],
        video: json["video"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lessonId": lessonId,
        "title": title,
        "video": video,
        "__v": v,
      };
}

class Quiz {
  String question;
  List<String> options;
  String answer;
  String id;

  Quiz({
    required this.question,
    required this.options,
    required this.answer,
    required this.id,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        question: json["question"],
        options: List<String>.from(json["options"].map((x) => x)),
        answer: json["answer"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x)),
        "answer": answer,
        "_id": id,
      };
}
