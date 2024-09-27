import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class UserInitialSetup extends SplashEvent {}
