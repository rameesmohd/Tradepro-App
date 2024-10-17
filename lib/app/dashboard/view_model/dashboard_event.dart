import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class DashboardFetchEvent extends DashboardEvent {}
