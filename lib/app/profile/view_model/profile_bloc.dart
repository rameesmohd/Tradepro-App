import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/profile/model/profile_repo.dart';
import 'package:tradepro/app/profile/model/user_profile_model.dart';
import 'package:tradepro/app/profile/view_model/profile_event.dart';
import 'package:tradepro/app/profile/view_model/profile_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../../providers/db_provider/hive/hive_helper.dart';
import '../../auth/login/model/login_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    ProfileRepo profileRepo = ProfileRepo();
    on<FetchUserProfile>(
        (FetchUserProfile event, Emitter<ProfileState> emit) async {
      emit(ProfileLoadingState());
      try {
        final UserProfileModel? fetchedUserDetails =
            await profileRepo.fetchUserProfile();

        if (fetchedUserDetails != null) {
          if (fetchedUserDetails.status) {
            await HiveHelper.addItem<LoginModel>(
                HiveHelper.loginUserBoxHive,
                HiveHelper.loginUserKeyHive,
                LoginModel(
                    email: fetchedUserDetails.user.email,
                    message: fetchedUserDetails.message,
                    id: fetchedUserDetails.user.id,
                    jwtToken: null,
                    name: fetchedUserDetails.user.name,
                    password: null,
                    status: fetchedUserDetails.status));
            emit(ProfileSuccessFetchedState(profile: fetchedUserDetails));
          } else {
            emit(const ProfileStateLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        emit(ProfileStateLoadingFailedState(errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });
    on<UpdateUserProfile>(
        (UpdateUserProfile event, Emitter<ProfileState> emit) async {
      emit(ProfileLoadingState());
      try {
        final isUpdated = await profileRepo.updateUserDetails(
            imageFile: null,
            userName: event.userName,
            email: event.email,
            countryCode: event.countryCode,
            phoneNumber: event.phoneNumber,
            isNotification: event.isNotification);

        if (isUpdated != null) {
          if (isUpdated) {
            add(FetchUserProfile());
          } else {
            emit(const ProfileStateLoadingFailedState(
                errorMessage: 'Update failed'));
          }
        }
      } catch (e) {
        emit(ProfileStateLoadingFailedState(errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });
  }
}
