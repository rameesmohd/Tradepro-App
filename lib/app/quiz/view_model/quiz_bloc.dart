import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/model/course_detail_repo.dart';
import 'package:tradepro/app/home/model/home_repo.dart';
import 'package:tradepro/app/quiz/view_model/quiz_event.dart';
import 'package:tradepro/app/quiz/view_model/quiz_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../home/model/course_list_model.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizStateInitial()) {
    // ProfileRepo profileRepo = ProfileRepo();
    on<QuizSubmitEvent>((QuizSubmitEvent event, Emitter<QuizState> emit) async {
      log('Quiz loading....');
      emit(QuizLoadingState());
      log('Quiz loading started....');
      if (await HelperFuntions().isHaveConnectivity()) {
        log('Quiz checked connectivity loading....');

        if (areMapsEqual(
            event.correctQuestionAnswer, event.userEnteredQuestionAnswer)) {
          if (event.nextChapterId != null && event.purcahseCourseId != null) {
            log('Quiz maps equal.... "purchaseId" = ${event.purcahseCourseId},"chapter di" ${event.nextChapterId}');

            try {
              final decodedData = await CourseDetailRepo().unloackChapter({
                "purchasedId": event.purcahseCourseId!,
                "chapterId": event.nextChapterId!
              });
              final CourseListModel? fetchedCourse =
                  await HomeRepo().fetchCourse();
              log('Quiz chapter ulocked....');

              // final decodedData = {
              //   'message': 'Chapter marked as played successfully'
              // };

              if (decodedData["message"] != null) {
                log('heeeeeeeeeeeeeeeer');
                emit(QuizPassedState());
              }
            } catch (e) {
              log('$e  thhhhhhhhhhhhhhhhher');
              emit(QuizLoadingFailedState(
                  errorMessage: HelperFuntions().getErrorMessage(e)));
            }
          }
        } else {
          emit(QuizFailedState());
        }
      } else {
        emit(const QuizLoadingFailedState(errorMessage: 'Network Required'));
      }
    });
  }

  bool areMapsEqual(Map<String, int> map1, Map<String, int> map2) {
    log('map 1 = ${map1}  ==== map 2 = ${map2}');
    if (map1.length != map2.length) return false;

    for (String key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) {
        if (map1[key] != map2[key]) {
          return false;
        }
        return false;
      }
    }
    return true;
  }
}
