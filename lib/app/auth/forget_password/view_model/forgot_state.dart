import 'package:equatable/equatable.dart';

abstract class ForgotPassState extends Equatable {
  const ForgotPassState();
  @override
  List<Object> get props => [];
}

class ForgotPassInitialState extends ForgotPassState {}

class ForgotLoadingState extends ForgotPassState {}

class OtpSentForChangePassState extends ForgotPassState {}

class OtpVerifiedState extends ForgotPassState {}

class ForgotSuccessState extends ForgotPassState {
  final String? successMessage;

  const ForgotSuccessState({this.successMessage});
}

class ForgotLoadingFailedState extends ForgotPassState {
  const ForgotLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
