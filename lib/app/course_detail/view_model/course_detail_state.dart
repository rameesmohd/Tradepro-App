import 'package:equatable/equatable.dart';

import '../model/course_detail_model.dart';

abstract class CourseDetailState extends Equatable {
  const CourseDetailState();
  @override
  List<Object> get props => [];
}

class CourseDetailStateInitial extends CourseDetailState {}

class CourseDetailLoadingState extends CourseDetailState {}

class CourseDetailSuccesState extends CourseDetailState {
  final CourseDetailModel? courseDetail;

  const CourseDetailSuccesState({this.courseDetail});
}

class CourseDetailLoadingFailedState extends CourseDetailState {
  const CourseDetailLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
