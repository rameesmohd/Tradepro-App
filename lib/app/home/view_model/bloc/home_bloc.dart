import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/home/model/home_repo.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../model/course_list_model.dart';
import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateInitial()) {
    on<FetchHomeCourseList>(
        (FetchHomeCourseList event, Emitter<HomeState> emit) async {
      emit(HomeStateCoursesLoadingState());
      try {
        HomeRepo homeRepo = HomeRepo();

        final CourseListModel? fetchedCourse = await homeRepo.fetchCourse();
        if (fetchedCourse != null) {
          if (fetchedCourse.status) {
            emit(HomeCoursesFetchedState(const [], course: fetchedCourse));
          } else {
            emit(const HomeStateLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        emit(HomeStateLoadingFailedState(errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when home bloc $e');
      }
    });
  }
}
