import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoadinState extends SplashState {}

class UserLogoutState extends SplashState {}

class UserLoginState extends SplashState {}
