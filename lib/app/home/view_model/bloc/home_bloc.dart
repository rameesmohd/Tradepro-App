import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/app/home/model/home_repo.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../model/course_list_model.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateInitial()) {
    List<AllCourse> allcourse = [];
    List<PurchasedCourse> purchasedCourse = [];
    List<String> currentUserWishlist = [];
    on<FetchHomeCourseList>(
        (FetchHomeCourseList event, Emitter<HomeState> emit) async {
      emit(HomeStateCoursesLoadingState());
      try {
        HomeRepo homeRepo = HomeRepo();

        final CourseListModel? fetchedCourse = await homeRepo.fetchCourse();
        if (fetchedCourse != null) {
          if (fetchedCourse.status ?? false) {
            allcourse.clear();
            purchasedCourse.clear();
            currentUserWishlist.clear();
            final LoginModel currentUser =
                await HelperFuntions().getCurrentUser();
            log('heeeeeeeeeeeeeeeeere');
            // for (var element in allcourse) {
            //   log('wissssssssssssssssshlist user ${element.wishlistUser}');
            //   if (element.wishlistUser.contains(currentUser.id)) {
            //     log('cureeeeeent user ${currentUser.id}');
            //     currentUserWishlist.add(element.id);
            //   }
            // }
            currentUserWishlist.addAll(
              fetchedCourse.courses!.allCourses!
                  .where((course) {
                    return course.wishlistUser.contains(currentUser.id);
                  })
                  .map((course) => course.id)
                  .toList(),
            );
            allcourse.addAll(fetchedCourse.courses?.allCourses ?? []);
            purchasedCourse
                .addAll(fetchedCourse.courses?.purchasedCourses ?? []);

            emit(HomeCoursesFetchedState(
                addedWishList: currentUserWishlist,
                allCourse: allcourse,
                purcahseCourses: purchasedCourse));
          } else {
            emit(const HomeStateLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        emit(HomeStateLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });

    on<AddToWishList>((AddToWishList event, Emitter<HomeState> emit) async {
      emit(HomeStateCoursesLoadingState());
      currentUserWishlist.add(event.id);
      emit(HomeCoursesFetchedState(
          addedWishList: currentUserWishlist,
          allCourse: allcourse,
          purcahseCourses: purchasedCourse));
    });
    on<RemoveFromWishList>(
        (RemoveFromWishList event, Emitter<HomeState> emit) async {
      currentUserWishlist.remove(event.id);
      emit(HomeCoursesFetchedState(
          addedWishList: currentUserWishlist,
          allCourse: allcourse,
          purcahseCourses: purchasedCourse));
    });
  }
}
