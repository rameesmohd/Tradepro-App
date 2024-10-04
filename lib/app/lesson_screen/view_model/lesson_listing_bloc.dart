// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tradepro/app/course_detail/model/course_detail_repo.dart';
// import 'package:tradepro/app/course_detail/view_model/course_detail_event.dart';
// import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
// import 'package:tradepro/app/lesson_screen/model/lesson_listing_repo.dart';
// import 'package:tradepro/app/lesson_screen/view_model/lesson_listing_event.dart';
// import 'package:tradepro/app/lesson_screen/view_model/lesson_listing_state.dart';

// class LessonListingBloc extends Bloc<LessonListingEvent, LessonListState> {
//   LessonListingBloc() : super(LessonListStateInitial()) {
//     on<UnlockChapterEvent>(
//         (UnlockChapterEvent event, Emitter<LessonListState> emit) async {
//       emit(ChapterUnLockLoading(chapterIndex: 0, lessonIndex: 0));
//       try {
//         LessonListingRepo lessonListingRepo = LessonListingRepo();

//         final chapterUnlockRespo = await lessonListingRepo.unloackChapter(
//             {'purchasedId': event.purchasedId, 'chapterId': event.chapterId});
//         if (chapterUnlockRespo['message'] &&
//             chapterUnlockRespo['message'] ==
//                 "Chapter marked as played successfully") {
//                   emit(Lessonsta)
//         } else {}
//       } catch (e) {
//         log('error when course detail $e');
//       }
//     });
//   }
// }
