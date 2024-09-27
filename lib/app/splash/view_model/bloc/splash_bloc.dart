import 'dart:developer';

import 'package:bloc/bloc.dart';


import '../../../../../providers/db_provider/sp/sp_hleper.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<UserInitialSetup>(
        (UserInitialSetup event, Emitter<SplashState> emit) async {
      emit(SplashLoadinState());

      try {
        final String? userToken =
            await SPHelper.getData<String>(SPHelper.userTokenKey);
        if (userToken != null) {
          emit(UserLoginState());
        } else {
          emit(UserLogoutState());
        }
      } catch (e) {
        log('$e');
      }
    });
  }
}
