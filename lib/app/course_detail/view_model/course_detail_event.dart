import 'package:equatable/equatable.dart';

abstract class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchCouseDetail extends CourseDetailEvent {
  final String id;
  final String? purchasedCourseId;
  final bool isPurchased;
  final List? playableChapter;

  const FetchCouseDetail(
      {this.playableChapter,
      this.purchasedCourseId,
      required this.isPurchased,
      required this.id});
}

class ChapterUnloackEvent extends CourseDetailEvent {
  final String purchasedId;
  final String chapterId;

  const ChapterUnloackEvent(
      {required this.purchasedId, required this.chapterId});
}
