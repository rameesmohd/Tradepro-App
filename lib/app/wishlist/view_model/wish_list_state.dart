import 'package:equatable/equatable.dart';
import 'package:tradepro/app/wishlist/model/wish_list_model.dart';

abstract class WishListState extends Equatable {
  const WishListState();
  @override
  List<Object> get props => [];
}

class WishListStateInitial extends WishListState {}

class WishListCoursesLoadingState extends WishListState {}

class CourseAddingToWishList extends WishListState {
  final String courseId;

  const CourseAddingToWishList({required this.courseId});
}

class CourseRemovingWishList extends WishListState {
  final String courseId;
  final List<WishListCourses> wishList;

  const CourseRemovingWishList(
      {required this.wishList, required this.courseId});
}

class WishListAddedState extends WishListState {}

class WishListAddFailedState extends WishListState {
  final String errorText;

  const WishListAddFailedState({required this.errorText});
}

class WishListFetchedState extends WishListState {
  final List<WishListCourses> wishList;
  const WishListFetchedState(this.wishList);
}

class WishListEmptyState extends WishListState {}

class WishListLoadingFailedState extends WishListState {
  const WishListLoadingFailedState({required this.errorMessage});
  final String errorMessage;
}
