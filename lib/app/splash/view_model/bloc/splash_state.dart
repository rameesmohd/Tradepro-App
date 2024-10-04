import 'package:equatable/equatable.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoadinState extends SplashState {}

class UserLogoutState extends SplashState {}

class UserLoginState extends SplashState {
  final LoginModel userDetails;

  const UserLoginState({required this.userDetails});
}
