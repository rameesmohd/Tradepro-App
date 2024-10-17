import 'package:equatable/equatable.dart';
import 'package:tradepro/app/dashboard/model/dashboard_model.dart';

abstract class DashBoardState extends Equatable {
  const DashBoardState();
  @override
  List<Object> get props => [];
}

class DashBoardStateInitial extends DashBoardState {}

class DashBoardLoadingState extends DashBoardState {}

class DashBoardDetailSuccesState extends DashBoardState {
  final DashboardModel? dashboardDetails;

  const DashBoardDetailSuccesState({this.dashboardDetails});
}

class DashboardLoadingFailed extends DashBoardState {
  const DashboardLoadingFailed({required this.errorMessage});
  final String errorMessage;
}
