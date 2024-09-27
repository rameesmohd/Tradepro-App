import 'package:equatable/equatable.dart';

abstract class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchCouseDetail extends CourseDetailEvent {
  final String id;

  const FetchCouseDetail({required this.id});
}
