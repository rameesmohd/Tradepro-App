import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/model/course_detail_repo.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_event.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';

import '../model/course_detail_model.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(CourseDetailStateInitial()) {
    on<FetchCouseDetail>(
        (FetchCouseDetail event, Emitter<CourseDetailState> emit) async {
      emit(CourseDetailLoadingState());
      try {
        CourseDetailRepo _courseDetailRepo = CourseDetailRepo();

        final CourseDetailModel? fetchedCourseDetail =
            await _courseDetailRepo.fetchCourseDetail(event.id);
        if (fetchedCourseDetail != null) {
          if (fetchedCourseDetail.status) {
            emit(CourseDetailSuccesState(courseDetail: fetchedCourseDetail));
          } else {
            emit(const CourseDetailLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when course detail $e');
      }
    });
  }
}
