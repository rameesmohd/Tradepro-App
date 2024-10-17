import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tradepro/app/auth/forget_password/model/forget_password_repo.dart';
import 'package:tradepro/app/auth/forget_password/view_model/forgot_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import 'forgot_event.dart';

class ForgotPassBloc extends Bloc<ForgetPassEvent, ForgotPassState> {
  ForgotPassBloc() : super(ForgotPassInitialState()) {
    String? phoneNumberForChangePassword;
    on<UserPhoneSubmitEvent>(
        (UserPhoneSubmitEvent event, Emitter<ForgotPassState> emit) async {
      phoneNumberForChangePassword = event.phoneNumber;
      emit(ForgotLoadingState());
      try {
        ForgetPasswordRepo forgetPasswordRepo = ForgetPasswordRepo();
        final Map<String, dynamic>? response = await forgetPasswordRepo
            .forgetPhoneNumberSubmit(phoneNumber: event.phoneNumber);

        if (response != null) {
          if (response["message"] == "otp send successfully") {
            emit(OtpSentForChangePassState());
          } else if (response['message'] != null) {
            emit(ForgotLoadingFailedState(errorMessage: response['message']));
          } else {
            emit(const ForgotLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when login $e');
        emit(ForgotLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
      }
    });

    on<UserOtpSubmitEvent>(
        (UserOtpSubmitEvent event, Emitter<ForgotPassState> emit) async {
      emit(ForgotLoadingState());
      try {
        ForgetPasswordRepo forgetPasswordRepo = ForgetPasswordRepo();
        final Map<String, dynamic>? response =
            await forgetPasswordRepo.forgotOtpSubmit(otp: event.otp);

        if (response != null) {
          if (response["message"] == "Verified successfully") {
            emit(OtpVerifiedState());
          } else if (response['message'] != null) {
            emit(ForgotLoadingFailedState(errorMessage: response['message']));
          } else {
            emit(const ForgotLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when login $e');
        emit(ForgotLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
      }
    });

    on<UserSubmitNewPassword>(
        (UserSubmitNewPassword event, Emitter<ForgotPassState> emit) async {
      emit(ForgotLoadingState());
      if (phoneNumberForChangePassword != null) {
        try {
          ForgetPasswordRepo forgetPasswordRepo = ForgetPasswordRepo();
          final Map<String, dynamic>? response =
              await forgetPasswordRepo.forgotSubmitNewPass(
                  password: event.password,
                  phoneNumber: phoneNumberForChangePassword!);

          if (response != null) {
            if (response["message"] == "Password updated successfully") {
              emit(ForgotSuccessState(successMessage: response["message"]));
            } else if (response['message'] != null) {
              emit(ForgotLoadingFailedState(errorMessage: response['message']));
            } else {
              emit(const ForgotLoadingFailedState(
                  errorMessage: 'Something went wrong'));
            }
          }
        } catch (e) {
          log('error when login $e');
          emit(ForgotLoadingFailedState(
              errorMessage: HelperFuntions().getErrorMessage(e)));
        }
      } else {
        emit(ForgotLoadingFailedState(
            errorMessage:
                HelperFuntions().getErrorMessage('phone number missing')));
      }
    });
  }
}
