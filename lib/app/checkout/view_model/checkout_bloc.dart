import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../model/checkout_model.dart';
import '../model/checkout_repo.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutStateInitial()) {
    on<SubmitCourseCheckout>(
        (SubmitCourseCheckout event, Emitter<CheckoutState> emit) async {
      emit(CheckoutLoadingState());
      try {
        CheckoutRepo checkoutRepo = CheckoutRepo();
        final LoginModel userDetails = await HelperFuntions().getCurrentUser();
        event.checkoutCourseDetails
            .addAll({'userId': userDetails.id!, "paymentId": "1234"});

        final CheckoutModel chekcoutResponse = await checkoutRepo
            .checkoutCourse(params: event.checkoutCourseDetails);

        if (chekcoutResponse.status != null) {
          if (chekcoutResponse.status!) {
            emit(CheckoutSuccessState(checkoutResponse: chekcoutResponse));
          } else {
            emit(const CheckoutStateLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        } else if (chekcoutResponse.message ==
            'Course purchased successfully') {
          emit(CheckoutSuccessState(checkoutResponse: chekcoutResponse));
        } else {
          if (chekcoutResponse.message != null) {
            emit(CheckoutStateLoadingFailedState(
                errorMessage: chekcoutResponse.message!));
          } else {
            emit(const CheckoutStateLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log("Error on checkout api $e");
        emit(CheckoutStateLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
      }
    });
  }
}
