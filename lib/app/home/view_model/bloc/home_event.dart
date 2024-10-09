import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchHomeCourseList extends HomeEvent {}

class WishListAddEvent extends HomeEvent {
  final String courseId;
  final String language;

  const WishListAddEvent({required this.courseId, required this.language});
}
