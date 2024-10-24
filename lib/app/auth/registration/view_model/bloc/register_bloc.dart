import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/app/auth/registration/model/register_model.dart';
import 'package:tradepro/app/auth/registration/model/register_repo.dart';
import 'package:tradepro/app/auth/registration/view_model/bloc/register_event.dart';
import 'package:tradepro/app/auth/registration/view_model/bloc/register_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';

import '../../../../../providers/db_provider/sp/sp_hleper.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    RegisterRepo registerRepo = RegisterRepo();
    on<UserRequestForOtp>(
        (UserRequestForOtp event, Emitter<RegisterState> emit) async {
      emit(RegisterWaitingForOtp());

      try {
        final forOtp =
            RegisterModel(phoneNumber: event.phone, email: event.email);
        final response = await registerRepo.userSubmitPhoneNumber(
            credentails: registerModelOtpToJson(forOtp));
        if (response != null) {
          if (response.status != null && response.status!) {
            emit(const RegisterOtpSented());
          } else if (response.message != null) {
            emit(RegisterLoadingFailedState(errorMessage: response.message!));
          } else {
            emit(const RegisterLoadingFailedState(errorMessage: 'Cant sent'));
          }
        } else {
          emit(const RegisterLoadingFailedState(errorMessage: 'Cant sent'));
        }
      } catch (e) {
        emit(RegisterLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when register req otp $e');
      }
    });

    on<UserRegisterEvent>(
        (UserRegisterEvent event, Emitter<RegisterState> emit) async {
      emit(RegisterLoading());
      

      try {
        final response = await registerRepo.userSubmitOtp(
            credentails: registerModelUserDetails(event.userDetails!));
        if (response != null) {
          if (response.jwtToken != null) {
            SPHelper.setData<String>(SPHelper.userTokenKey, response.jwtToken!);
            HiveHelper.addItem<LoginModel>(
                HiveHelper.loginUserBoxHive,
                HiveHelper.loginUserKeyHive,
                LoginModel(
                    email: response.email,
                    message: response.message,
                    id: response.id,
                    jwtToken: response.jwtToken,
                    name: response.name,
                    password: response.password,
                    status: response.status));
            emit(RegisterSuccessState(successMessage: response.message));
          } else {
            emit(const RegisterLoadingFailedState(errorMessage: 'Cant sent'));
          }
        } else {
          emit(const RegisterLoadingFailedState(errorMessage: 'Cant sent'));
        }
      } catch (e) {
        emit(RegisterLoadingFailedState(errorMessage: e.toString()));
        log('error when register event $e');
      }
    });
  }
}
