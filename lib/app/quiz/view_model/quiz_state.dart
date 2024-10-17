import 'package:equatable/equatable.dart';

abstract class QuizState extends Equatable {
  const QuizState();
  @override
  List<Object> get props => [];
}

class QuizStateInitial extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizPassedState extends QuizState {}

class QuizFailedState extends QuizState {}

class QuizLoadingFailedState extends QuizState {
  final String errorMessage;

  const QuizLoadingFailedState({required this.errorMessage});
}
