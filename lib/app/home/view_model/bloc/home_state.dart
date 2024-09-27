import 'package:equatable/equatable.dart';

import '../../model/course_list_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeStateInitial extends HomeState {}

class HomeStateCoursesLoadingState extends HomeState {}

class HomeCoursesFetchedState extends HomeState {
  final CourseListModel? course;

  const HomeCoursesFetchedState({this.course});
}

class HomeStateLoadingFailedState extends HomeState {
  const HomeStateLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
