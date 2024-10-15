import 'package:equatable/equatable.dart';

import '../model/course_detail_model.dart';

abstract class CourseDetailState extends Equatable {
  const CourseDetailState();
  @override
  List<Object> get props => [];
}

class CourseDetailStateInitial extends CourseDetailState {}

class CourseDetailLoadingState extends CourseDetailState {
  final CourseDetailModel? courseDetail;
  final String? chapterId;
  final List? playableVideos;

  const CourseDetailLoadingState(this.playableVideos,
      {required this.chapterId, required this.courseDetail});
}

// class ChapterUnloackLoadingState extends CourseDetailState {
//   final CourseDetailModel? courseDetail;
//   final String chapterId;
//   final List? playableVideos;

//   const ChapterUnloackLoadingState(this.playableVideos,
//       {required this.chapterId, required this.courseDetail});
// }

class CourseDetailSuccesState extends CourseDetailState {
  final CourseDetailModel? courseDetail;
  final List<dynamic>? playbleVideos;

  const CourseDetailSuccesState({this.playbleVideos, this.courseDetail});
}

class CourseDetailLoadingFailedState extends CourseDetailState {
  const CourseDetailLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
