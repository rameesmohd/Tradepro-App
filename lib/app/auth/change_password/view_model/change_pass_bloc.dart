import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:tradepro/app/auth/change_password/model/change_pass_model.dart';
import 'package:tradepro/app/auth/change_password/model/change_pass_repo.dart';
import 'package:tradepro/app/auth/change_password/view_model/change_pass_event.dart';
import 'package:tradepro/app/auth/change_password/view_model/change_pass_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

class ChangePassBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePassBloc() : super(ChangePasswordInitial()) {
    on<UserChangePasswordEvent>((UserChangePasswordEvent event,
        Emitter<ChangePasswordState> emit) async {
      emit(ChangePasswordLoadingState());
      try {
        ChangePassRepo changePassRepo = ChangePassRepo();

        final ChangePassModel? changePassRespo =
            await changePassRepo.changePassword(
                newPassword: event.newPassword, oldPassword: event.oldPassword);
        if (changePassRespo != null) {
          if (changePassRespo.status != null && !changePassRespo.status!) {
            emit(ChangePasswordLoadingFailedState(
                errorMessage:
                    changePassRespo.message ?? 'Change Password failed'));
          } else if (changePassRespo.status != null &&
              changePassRespo.status!) {
            emit(ChangePasswordSuccessState(
                successMessage: changePassRespo.message));
          } else {
            emit(const ChangePasswordLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error on change Password $e');
        emit(ChangePasswordLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
      }
    });
  }
}
