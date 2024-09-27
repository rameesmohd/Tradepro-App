import 'package:equatable/equatable.dart';
import 'package:tradepro/app/auth/registration/model/register_model.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class UserRequestForOtp extends RegisterEvent {
  final String? email;
  final String? phone;

  const UserRequestForOtp({required this.email, required this.phone});
}

class UserRegisterEvent extends RegisterEvent {
  final RegisterModel? userDetails;

  const UserRegisterEvent({required this.userDetails});
}
