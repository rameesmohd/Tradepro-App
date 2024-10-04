import 'package:equatable/equatable.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class SubmitCourseCheckout extends CheckoutEvent {
  final Map<String,String> checkoutCourseDetails;

  const SubmitCourseCheckout({required this.checkoutCourseDetails});
}
