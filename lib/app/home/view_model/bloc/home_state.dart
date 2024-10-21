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
  // final CourseListModel? course;
  final List<AllCourse> allCourse;
  final List<PurchasedCourse> purcahseCourses;

  final List<String> addedWishList;
  const HomeCoursesFetchedState(
      {required this.allCourse,
      required this.purcahseCourses,
      required this.addedWishList});
}

class HomeStateLoadingFailedState extends HomeState {
  const HomeStateLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
