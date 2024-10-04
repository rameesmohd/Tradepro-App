import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/model/course_detail_repo.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_event.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';

import '../../home/model/course_list_model.dart';
import '../../home/model/home_repo.dart';
import '../model/course_detail_model.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(CourseDetailStateInitial()) {
    CourseDetailRepo courseDetailRepo = CourseDetailRepo();
    CourseDetailModel? courseDetailModel;
    on<FetchCouseDetail>(
        (FetchCouseDetail event, Emitter<CourseDetailState> emit) async {
      emit(CourseDetailLoadingState());
      try {
        final CourseDetailModel? fetchedCourseDetail =
            await courseDetailRepo.fetchCourseDetail(event.id);
        if (fetchedCourseDetail != null) {
          if (fetchedCourseDetail.status) {
            courseDetailModel = fetchedCourseDetail;

            if (event.isPurchased &&
                event.playableChapter != null &&
                event.playableChapter!.isEmpty) {
              add(ChapterUnloackEvent(
                  purchasedId: event.purchasedCourseId!,
                  chapterId: fetchedCourseDetail
                      .courseDetail.lessons[0].chapters![0].id));
            } else {
              emit(CourseDetailSuccesState(
                  courseDetail: fetchedCourseDetail,
                  playbleVideos: event.playableChapter));
            }
          } else {
            emit(const CourseDetailLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when course detail $e');
      }
    });

    on<ChapterUnloackEvent>(
        (ChapterUnloackEvent event, Emitter<CourseDetailState> emit) async {
      emit(ChapterUnloackLoadingState(
          chapterId: event.chapterId, courseDetail: courseDetailModel));
      try {
        final responseDate = await courseDetailRepo.unloackChapter(
            {"purchasedId": event.purchasedId, "chapterId": event.chapterId});
        final decodedData = jsonDecode(responseDate);
        if (decodedData["message"] != null) {
          if (decodedData["message"] ==
              'Chapter marked as played successfully') {
            HomeRepo homeRepo = HomeRepo();

            final CourseListModel? fetchedCourse = await homeRepo.fetchCourse();
            List<dynamic>? playedChters = fetchedCourse
                ?.courses.purchasedCourses
                .where((element) => element.id == event.purchasedId)
                .first
                .isPlayedChapters;
            if (playedChters != null) {
              if (playedChters.isNotEmpty) {
                emit(CourseDetailSuccesState(
                    courseDetail: courseDetailModel,
                    playbleVideos: playedChters));
              } else {
                emit(const CourseDetailLoadingFailedState(
                    errorMessage: 'Something went wrong'));
              }
            }
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
