
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String? successMessage;

  const LoginSuccessState({this.successMessage});
}

class LoginLoadingFailedState extends LoginState {
  const LoginLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
