import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';

import '../../../../../providers/db_provider/sp/sp_hleper.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoadinState()) {
    on<UserInitialSetup>(
        (UserInitialSetup event, Emitter<SplashState> emit) async {
      emit(SplashLoadinState());

      try {
        final String? userToken =
            await SPHelper.getData<String>(SPHelper.userTokenKey);
        if (userToken != null) {
          final userDetails = await HiveHelper.getItem<LoginModel>(
              HiveHelper.loginUserBoxHive, HiveHelper.loginUserKeyHive);
          if (userDetails != null) {
            log(userDetails.toString());
            emit(UserLoginState(userDetails: userDetails));
          } else {
            emit(UserLogoutState());
          }
        } else {
          emit(UserLogoutState());
        }
      } catch (e) {
        log('$e');
      }
    });
  }
}
