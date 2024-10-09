import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class UserChangePasswordEvent extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const UserChangePasswordEvent(
      {required this.oldPassword, required this.newPassword});
}
