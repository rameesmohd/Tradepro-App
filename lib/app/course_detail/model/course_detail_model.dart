import 'dart:convert';

CourseDetailModel courseDetailModelFromJson(String str) =>
    CourseDetailModel.fromJson(json.decode(str));

String courseDetailModelToJson(CourseDetailModel data) =>
    json.encode(data.toJson());

class CourseDetailModel {
  String message;
  CourseDetail courseDetail;
  bool status;

  CourseDetailModel({
    required this.message,
    required this.courseDetail,
    required this.status,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailModel(
        message: json["message"],
        courseDetail: CourseDetail.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": courseDetail.toJson(),
        "status": status,
      };
}

class CourseDetail {
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
  int numberOfVideos;
  int rating;
  double starRating;
  dynamic quizCount;

  CourseDetail({
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
    required this.numberOfVideos,
    required this.quizCount,
    required this.rating,
    required this.starRating,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) => CourseDetail(
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
        numberOfVideos: json["numberOfVideos"],
        quizCount: json["quizCount"],
        rating: json["rating"],
        starRating: double.parse(json["starRating"].toString()),
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
        "numberOfVideos": numberOfVideos,
        "quizCount": quizCount,
      };
}

class Lesson {
  String? id;
  String? courseId;
  String? lessonLanguage;
  String? lessonName;
  List<Chapter>? chapters;
  List<Quiz>? quiz;
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
        chapters: json["chapters"] != null
            ? List<Chapter>.from(
                json["chapters"].map((x) => Chapter.fromJson(x)))
            : null,
        quiz: json["quiz"] != null
            ? List<Quiz>.from(json["quiz"].map((x) => Quiz.fromJson(x)))
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "courseId": courseId,
        "lessonLanguage": lessonLanguage,
        "lessonName": lessonName,
        "chapters": chapters != null
            ? List<dynamic>.from(chapters!.map((x) => x.toJson()))
            : null,
        "quiz": quiz != null
            ? List<dynamic>.from(quiz!.map((x) => x.toJson()))
            : null,
        "__v": v,
      };
}

class Chapter {
  String id;
  String lessonId;
  String title;
  String video;
  int v;
  bool isPlayed;

  Chapter({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.video,
    required this.v,
    required this.isPlayed,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["_id"],
        lessonId: json["lessonId"],
        title: json["title"],
        video: json["video"],
        v: json["__v"],
        isPlayed: json["isPlayed"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lessonId": lessonId,
        "title": title,
        "video": video,
        "__v": v,
        "isPlayed": isPlayed,
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
