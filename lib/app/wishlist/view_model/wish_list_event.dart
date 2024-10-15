import 'package:equatable/equatable.dart';

abstract class WishListEvent extends Equatable {
  const WishListEvent();
  // TODO: implement props
  @override
  List<Object?> get props => [];
}

class FetchWishList extends WishListEvent {}

class WishListAddEvent extends WishListEvent {
  final String courseId;
  final String language;

  const WishListAddEvent({required this.courseId, required this.language});
}

class WishListRemoveEvent extends WishListEvent {
  final String wishListId;
  final String courseId;

  const WishListRemoveEvent({required this.courseId, required this.wishListId});
}
