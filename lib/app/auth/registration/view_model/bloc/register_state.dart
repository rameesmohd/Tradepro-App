import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterWaitingForOtp extends RegisterState {}

class RegisterOtpSented extends RegisterState {
  final String? message;

  const RegisterOtpSented({this.message});
}

class RegisterLoading extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String? successMessage;

  const RegisterSuccessState({this.successMessage});
}

class RegisterLoadingFailedState extends RegisterState {
  const RegisterLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
