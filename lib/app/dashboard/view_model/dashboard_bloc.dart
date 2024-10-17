import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/dashboard/model/dashboard_model.dart';
import 'package:tradepro/app/dashboard/model/dashboard_repo.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_event.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashBoardState> {
  DashboardBloc() : super(DashBoardStateInitial()) {
    DashboardRepo dashboardRepo = DashboardRepo();
    on<DashboardFetchEvent>(
        (DashboardFetchEvent event, Emitter<DashBoardState> emit) async {
      emit(DashBoardLoadingState());

      try {
        final DashboardModel? fetchedDashboardDetails =
            await dashboardRepo.fetchDashBoard();
        if (fetchedDashboardDetails != null) {
          if (fetchedDashboardDetails.status) {
            emit(DashBoardDetailSuccesState(
                dashboardDetails: fetchedDashboardDetails));
          } else {
            emit(const DashboardLoadingFailed(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when course detail $e');
        emit(DashboardLoadingFailed(
            errorMessage: HelperFuntions().getErrorMessage(e)));
      }
    });
  }
}
