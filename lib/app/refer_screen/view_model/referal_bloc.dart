import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tradepro/app/refer_screen/model/refer_repo.dart';
import 'package:tradepro/app/refer_screen/view_model/referal_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import 'referal_event.dart';

class ReferalBloc extends Bloc<ReferalEvent, ReferalState> {
  ReferalBloc() : super(ReferalStateInitial()) {
    String? referalCode;
    ReferalRepo referalRepo = ReferalRepo();
    on<FetchUserReferal>(
        (FetchUserReferal event, Emitter<ReferalState> emit) async {
      emit(ReferalLoadingState());
      try {
        final String? fetchedUserReferal = await referalRepo.getReferalCode();

        if (fetchedUserReferal != null) {
          referalCode = fetchedUserReferal;
          emit(ReferalFetchedState(referalCode: fetchedUserReferal));
        } else {
          emit(const ReferalStateLoadingFailedState(
              errorMessage: 'Referal code not found'));
        }
      } catch (e) {
        emit(ReferalStateLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });

    on<ReferalCopyEvent>(
        (ReferalCopyEvent event, Emitter<ReferalState> emit) async {
      try {
        if (referalCode != null) {
          await HelperFuntions().copyToClipboard(referalCode!);
          emit(ReferalFetchedState(
              referalCode: referalCode!, message: 'referral code copied'));
        } else {
          emit(const ReferalStateLoadingFailedState(
              errorMessage: 'Referal code not found'));
        }
      } catch (e) {
        emit(ReferalStateLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });
    on<ReferalShareEvent>(
        (ReferalShareEvent event, Emitter<ReferalState> emit) async {
      try {
        if (referalCode != null) {
          await HelperFuntions().shareFromApp(
              'Hey! Use my referral code: $referalCode to get rewards!');
          emit(ReferalFetchedState(
              referalCode: referalCode!, message: 'referral code copied'));
        } else {
          emit(const ReferalStateLoadingFailedState(
              errorMessage: 'Referal code not found'));
        }
      } catch (e) {
        emit(ReferalStateLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });
  }
}
