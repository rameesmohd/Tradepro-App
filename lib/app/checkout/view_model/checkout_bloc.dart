import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/const/functions/helper_functions.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';

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

        if (chekcoutResponse.status!) {
          emit(CheckoutSuccessState(checkoutResponse: chekcoutResponse));
        } else {
          emit(const CheckoutStateLoadingFailedState(
              errorMessage: 'Something went wrong'));
        }
      } catch (e) {
        log('error when home bloc $e');
      }
    });
  }
}
