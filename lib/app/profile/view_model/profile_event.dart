import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchUserProfile extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final File? imageFile;
  final String userName;
  final String email;
  final String countryCode;
  final String phoneNumber;
  final bool isNotification;

  const UpdateUserProfile(
      {required this.imageFile,
      required this.userName,
      required this.email,
      required this.countryCode,
      required this.phoneNumber,
      required this.isNotification});
}
