import 'package:equatable/equatable.dart';

import '../model/user_profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileStateInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessFetchedState extends ProfileState {
  final UserProfileModel? profile;

  const ProfileSuccessFetchedState({this.profile});
}

class ProfileStateLoadingFailedState extends ProfileState {
  const ProfileStateLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
