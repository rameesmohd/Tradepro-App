import 'package:equatable/equatable.dart';

abstract class WishListState extends Equatable {
  const WishListState();
  @override
  List<Object> get props => [];
}

class WishListStateInitial extends WishListState {}

class WishListCoursesLoadingState extends WishListState {}

class WishListFetchedState extends WishListState {
  final List wishList;
  const WishListFetchedState(this.wishList);
}

class WishListEmptyState extends WishListState {}

class WishListLoadingFailedState extends WishListState {
  const WishListLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
