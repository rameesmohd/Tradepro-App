import 'package:equatable/equatable.dart';

abstract class ForgetPassEvent extends Equatable {
  const ForgetPassEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class UserPhoneSubmitEvent extends ForgetPassEvent {
  final String phoneNumber;
  const UserPhoneSubmitEvent({required this.phoneNumber});
}

class UserOtpSubmitEvent extends ForgetPassEvent {
  final String otp;
  const UserOtpSubmitEvent({required this.otp});
}

class UserSubmitNewPassword extends ForgetPassEvent {
  final String password;
  const UserSubmitNewPassword({required this.password});
}
