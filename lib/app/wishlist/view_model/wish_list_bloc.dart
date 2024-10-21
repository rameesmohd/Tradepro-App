import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/wishlist/model/wish_list_model.dart';
import 'package:tradepro/app/wishlist/model/wish_list_repo.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_event.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListStateInitial()) {
    WishListRepo wishListRepo = WishListRepo();
    List<WishListCourses> wishListCourse = [];

    on<FetchWishList>((FetchWishList event, Emitter<WishListState> emit) async {
      emit(WishListCoursesLoadingState());
      try {
        final WishListModel fetchedCourse = await wishListRepo.fetchWishList();
        wishListCourse = fetchedCourse.courses;

        if (wishListCourse.isNotEmpty) {
          emit(WishListFetchedState(wishListCourse));
        } else {
          emit(WishListEmptyState());
        }
      } catch (e) {
        emit(WishListLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when Wishlist bloc $e');
      }
    });

    on<WishListAddEvent>(
        (WishListAddEvent event, Emitter<WishListState> emit) async {
      emit(CourseAddingToWishList(courseId: event.courseId));
      try {
        final bool? courseAddResponse = await wishListRepo.courseAddToWishList(
            courseId: event.courseId, language: event.language);
        if (courseAddResponse != null && courseAddResponse) {
          add(const FetchWishList());
        } else {
          emit(const WishListAddFailedState(errorText: 'Adding error!'));
        }
      } catch (e) {
        emit(WishListAddFailedState(
            errorText: HelperFuntions().getErrorMessage(e)));
        log('error when Wishlist bloc $e');
      }
    });

    on<WishListRemoveEvent>(
        (WishListRemoveEvent event, Emitter<WishListState> emit) async {
      emit(CourseRemovingWishList(
          courseId: event.courseId, wishList: wishListCourse));
      try {
        final bool? courseAddResponse =
            await wishListRepo.courseRemoveFromWishList(
                courseId: event.courseId, wishListId: event.wishListId);
        if (courseAddResponse != null && courseAddResponse) {
          add(const FetchWishList());
        } else {
          emit(const WishListAddFailedState(errorText: 'Adding error!'));
        }
      } catch (e) {
        emit(WishListAddFailedState(
            errorText: HelperFuntions().getErrorMessage(e)));
        log('error when Wishlist bloc $e');
      }
    });
  }
}
