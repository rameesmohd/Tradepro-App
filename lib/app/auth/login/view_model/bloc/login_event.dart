import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class UserLoginEvent extends LoginEvent {
  final String? email;
  final String? password;

  const UserLoginEvent({required this.email, required this.password});
}
