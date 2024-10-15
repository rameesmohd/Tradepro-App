import 'package:equatable/equatable.dart';

abstract class ReferalEvent extends Equatable {
  const ReferalEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchUserReferal extends ReferalEvent {}

class ReferalCopyEvent extends ReferalEvent {}

class ReferalShareEvent extends ReferalEvent {}
