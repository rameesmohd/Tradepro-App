import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchHomeCourseList extends HomeEvent {}
