import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/home/model/home_repo.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';
import 'package:tradepro/app/wishlist/model/wish_list_repo.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_event.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListStateInitial()) {
    on<FetchWishList>((FetchWishList event, Emitter<WishListState> emit) async {
      emit(WishListCoursesLoadingState());
      try {
        WishListRepo wishListRepo = WishListRepo();

        final dynamic fetchedCourse = await wishListRepo.fetchWishList();
        if (fetchedCourse != null) {
          if (fetchedCourse is List) {
            if (fetchedCourse.isNotEmpty) {
              emit(WishListFetchedState(fetchedCourse));
            } else {
              emit(WishListEmptyState());
            }
          } else if (fetchedCourse is String) {
            emit(WishListLoadingFailedState(errorMessage: fetchedCourse));
          } else {
            emit(const WishListLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        emit(const WishListLoadingFailedState(
            errorMessage: 'Something went wrong'));
        log('error when home bloc $e');
      }
    });
  }
}
