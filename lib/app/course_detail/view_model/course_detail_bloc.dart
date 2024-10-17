import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/model/course_detail_repo.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_event.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../home/model/course_list_model.dart';
import '../../home/model/home_repo.dart';
import '../model/course_detail_model.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(CourseDetailStateInitial()) {
    CourseDetailRepo courseDetailRepo = CourseDetailRepo();
    String? purchasedId;
    CourseDetailModel? courseDetailModel;
    List? playableVideos;
    on<FetchCouseDetail>(
        (FetchCouseDetail event, Emitter<CourseDetailState> emit) async {
      purchasedId = event.purchasedCourseId;

      emit(const CourseDetailLoadingState());

      try {
        final CourseDetailModel? fetchedCourseDetail =
            await courseDetailRepo.fetchCourseDetail(event.id);
        if (fetchedCourseDetail != null) {
          if (fetchedCourseDetail.status) {
            courseDetailModel = fetchedCourseDetail;

            playableVideos = event.playableChapter;
            if (event.isPurchased &&
                event.playableChapter != null &&
                event.playableChapter!.isEmpty) {
              log('entered to chapter unloack event');
              add(ChapterUnloackEvent(
                  chapterId: fetchedCourseDetail
                      .courseDetail.lessons[0].chapters![0].id));
            } else {
              emit(CourseDetailSuccesState(
                  courseDetail: fetchedCourseDetail,
                  playbleVideos: playableVideos));
            }
          } else {
            emit(const CourseDetailLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        log('error when course detail $e');
        emit(CourseDetailLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
      }
    });

    on<ChapterUnloackEvent>(
        (ChapterUnloackEvent event, Emitter<CourseDetailState> emit) async {
      try {
        emit(const CourseDetailLoadingState(unlockingNewChapter: true));
        final decodedData = await courseDetailRepo.unloackChapter(
            {"purchasedId": purchasedId!, "chapterId": event.chapterId});

        // final decodedData = {
        //   'message': 'Chapter marked as played successfully'
        // };

        if (decodedData["message"] != null) {
          HomeRepo homeRepo = HomeRepo();
          final CourseListModel? fetchedCourse = await homeRepo.fetchCourse();
          log('heeeeeeeeeey vro');

          List<dynamic>? playedChters = fetchedCourse
              ?.courses.purchasedCourses
              .where((element) => element.id == purchasedId)
              .first
              .isPlayedChapters;
          log('heeeeey nishadd $playedChters');
          if (playedChters != null) {
            if (playedChters.isNotEmpty) {
              log('Completed Successfully');
              playableVideos = playedChters;
              emit(CourseDetailSuccesState(
                  courseDetail: courseDetailModel,
                  playbleVideos: playableVideos));
            } else {
              log('Completed played chapters is empty');

              emit(const CourseDetailLoadingFailedState(
                  errorMessage: 'Something went wrong'));
            }
          } else {
            log('Completed is null');

            emit(const CourseDetailLoadingFailedState(
                errorMessage: 'Something went wrong'));
          }
        }
      } catch (e) {
        emit(CourseDetailLoadingFailedState(
            errorMessage: HelperFuntions().getErrorMessage(e)));
        log('error when course chapter make unloack $e');
      }
    });
  }
}
