import 'package:equatable/equatable.dart';
import 'package:tradepro/app/checkout/model/checkout_model.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
  @override
  List<Object> get props => [];
}

class CheckoutStateInitial extends CheckoutState {}

class CheckoutLoadingState extends CheckoutState {}

class CheckoutSuccessState extends CheckoutState {
  final CheckoutModel? checkoutResponse;

  const CheckoutSuccessState({this.checkoutResponse});
}

class CheckoutStateLoadingFailedState extends CheckoutState {
  const CheckoutStateLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
