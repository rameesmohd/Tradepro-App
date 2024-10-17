import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class QuizSubmitEvent extends QuizEvent {
  final Map<String, int> correctQuestionAnswer;
  final Map<String, int> userEnteredQuestionAnswer;
  final String? nextChapterId;
  final String? purcahseCourseId;

  const QuizSubmitEvent(
      {required this.correctQuestionAnswer,
      required this.purcahseCourseId,
      required this.userEnteredQuestionAnswer,
      required this.nextChapterId});
}
