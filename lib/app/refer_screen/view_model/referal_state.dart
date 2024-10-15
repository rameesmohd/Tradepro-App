import 'package:equatable/equatable.dart';

abstract class ReferalState extends Equatable {
  const ReferalState();
  @override
  List<Object> get props => [];
}

class ReferalStateInitial extends ReferalState {}

class ReferalLoadingState extends ReferalState {}

class ReferalFetchedState extends ReferalState {
  final String referalCode;
  final String? message;

  const ReferalFetchedState({required this.referalCode, this.message});
}

class ReferalStateLoadingFailedState extends ReferalState {
  const ReferalStateLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
