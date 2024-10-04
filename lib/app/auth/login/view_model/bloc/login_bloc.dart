import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/app/auth/login/model/login_services.dart';
import 'package:tradepro/providers/db_provider/sp/sp_hleper.dart';

import '../../../../../providers/db_provider/hive/hive_helper.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLoginEvent>((UserLoginEvent event, Emitter<LoginState> emit) async {
      emit(LoginLoadingState());
      try {
        LoginRepos loginRepo = LoginRepos();
        final loginDetails =
            LoginModel(email: event.email, password: event.password);
        final LoginModel? login = await loginRepo.userLogin(
            credentails: loginModelToJson(loginDetails));
        if (login != null) {
          if (login.status != null && !login.status!) {
            emit(LoginLoadingFailedState(
                errorMessage: login.message ?? 'Login Failed'));
          } else if (login.jwtToken != null) {
            HiveHelper.addItem<LoginModel>(
                HiveHelper.loginUserBoxHive, HiveHelper.loginUserKeyHive, login);
            SPHelper.setData<String>(SPHelper.userTokenKey, login.jwtToken!);
            emit(LoginSuccessState(successMessage: login.message));
          } else {
            emit(const LoginLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when login $e');
      }
    });
  }
}
