import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {
  final String? successMessage;

  const ChangePasswordSuccessState({this.successMessage});
}

class ChangePasswordLoadingFailedState extends ChangePasswordState {
  const ChangePasswordLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
