import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
import 'package:tradepro/app/quiz/view/quiz_view.dart';
import 'package:tradepro/const/colors.dart';

import '../../course_detail/model/course_detail_model.dart';
import '../../course_detail/view_model/course_detail_bloc.dart';
import '../../course_detail/view_model/course_detail_event.dart';
import '../../home/view/home_view.dart';

class ScreenCourseLessonListing extends StatefulWidget {
  const ScreenCourseLessonListing(
      {super.key,
      required this.courseId,
      required this.purcahseCourseId,
      required this.vachableChapter});
  final String courseId;
  final String purcahseCourseId;
  final List? vachableChapter;

  @override
  State<ScreenCourseLessonListing> createState() =>
      _ScreenCourseLessonListingState();
}

class _ScreenCourseLessonListingState extends State<ScreenCourseLessonListing> {
  @override
  void initState() {
    BlocProvider.of<CourseDetailBloc>(context).add(FetchCouseDetail(
        playableChapter: widget.vachableChapter,
        id: widget.courseId,
        purchasedCourseId: widget.purcahseCourseId,
        isPurchased: true));
    super.initState();
  }

  final ValueNotifier<Map<String, String?>> videoUrl = ValueNotifier({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
        if (state is CourseDetailSuccesState) {
          videoUrl.value = {
            'videoUrl': state.courseDetail?.courseDetail.previewVideo
          };
          final courseDetail = state.courseDetail!.courseDetail;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 256,
                child: ValueListenableBuilder<Map<String, String?>>(
                  valueListenable: videoUrl,
                  builder: (context, value, child) {
                    if (value['videoUrl'] == null) {
                      return const Text('No video available');
                    }
                    return VideoPlayerWidget(
                      videoUrl: value['videoUrl']!,
                      nextChapterId: value['nextChapter'],
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SizedBox(height: 16),
                      Text(courseDetail.title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                      const SizedBox(height: 8),
                      Text('Created by ${courseDetail.author}',
                          style: const TextStyle(
                              color: AppColors.linedOriginalPrice,
                              fontWeight: FontWeight.w400,
                              fontSize: 16)),
                      const SizedBox(height: 12),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(courseDetail.lessons.length,
                              (lessonIndex) {
                            final lessonDetails =
                                courseDetail.lessons[lessonIndex];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Lesson ${lessonIndex + 1} - ${lessonDetails.lessonName}',
                                        style: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                    Text(
                                        '${lessonDetails.chapters?.length ?? 0} Videos',
                                        style: const TextStyle(
                                            color: AppColors.languageBtnBorder,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  children: List.generate(
                                    lessonDetails.chapters?.length ?? 0,
                                    (chapterIndex) {
                                      final chapterDetails =
                                          lessonDetails.chapters![chapterIndex];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Row(children: [
                                          isPlayeble(
                                                  watchedLessons:
                                                      state.playbleVideos!,
                                                  lessonId: chapterDetails.id)
                                              ? const PlayableLeadingCircle()
                                              : const LockedLeadingCircle(),
                                          const SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(chapterDetails.title,
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16)),
                                              const Text('Duration',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .courseListingDuration,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12))
                                            ],
                                          ),
                                          const Spacer(),
                                          isPlayeble(
                                                  watchedLessons:
                                                      state.playbleVideos!,
                                                  lessonId: chapterDetails.id)
                                              ? PlayableButtonWidget(onTap: () {
                                                  if (isPlayeble(
                                                      watchedLessons:
                                                          state.playbleVideos!,
                                                      lessonId:
                                                          chapterDetails.id)) {
                                                    videoUrl.value = {
                                                      "videoUrl":
                                                          chapterDetails.video,
                                                      "nextChapter": chapterIndex +
                                                                  1 <
                                                              lessonDetails
                                                                  .chapters!
                                                                  .length
                                                          ? lessonDetails
                                                              .chapters![
                                                                  chapterIndex +
                                                                      1]
                                                              .id
                                                          : null
                                                    };
                                                  }
                                                })
                                              : const LockedButtonWidget()
                                        ]),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (lessonDetails.quiz!.isNotEmpty)
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Quiz Time',
                                            style: TextStyle(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Row(children: [
                                            isQuizPlayable(
                                                    watchedLessons:
                                                        state.playbleVideos!,
                                                    allChapterInLesson:
                                                        lessonDetails.chapters!)
                                                ? const PlayableLeadingCircle()
                                                : const LockedLeadingCircle(),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                    'Test Your Knowledge',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16)),
                                                Text(
                                                    "${lessonDetails.quiz!.length} questions",
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .courseListingDuration,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12))
                                              ],
                                            ),
                                            const Spacer(),
                                            isQuizPlayable(
                                                    watchedLessons:
                                                        state.playbleVideos!,
                                                    allChapterInLesson:
                                                        lessonDetails.chapters!)
                                                ? PlayableButtonWidget(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ScreenQuizView(
                                                                    quiz: lessonDetails
                                                                        .quiz!,
                                                                    nextChapterUrl: lessonIndex +
                                                                                1 <
                                                                            courseDetail
                                                                                .lessons.length
                                                                        ? courseDetail
                                                                            .lessons[lessonIndex +
                                                                                1]
                                                                            .chapters![0]
                                                                            .id
                                                                        : null,
                                                                  )));
                                                    },
                                                  )
                                                : const LockedButtonWidget()
                                          ]),
                                        ),
                                        const SizedBox(height: 8)
                                      ])
                              ],
                            );
                          }))
                    ]),
              ),

              // Expanded(
              //     child: ListView.builder(
              //         itemBuilder: (context, index) => Text('hi')))
            ],
          );
        } else if (state is CourseDetailLoadingFailedState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  bool isPlayeble({required List watchedLessons, required String lessonId}) {
    return watchedLessons.contains(lessonId);
  }

  bool isQuizPlayable(
      {required List watchedLessons,
      required List<Chapter> allChapterInLesson}) {
    for (var chapter in allChapterInLesson) {
      if (!watchedLessons.contains(chapter.id)) {
        return false;
      }
    }
    return true;
  }
}

class LockedButtonWidget extends StatelessWidget {
  const LockedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: 82,
          height: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.textFieldBorder)),
          child: const Center(
            child: Text('Locked',
                style: TextStyle(
                    color: AppColors.videoCardUserNameColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16)),
          )),
    );
  }
}

class LockedLeadingCircle extends StatelessWidget {
  const LockedLeadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.textFieldBorder),
            shape: BoxShape.circle),
        child: const Icon(
          CupertinoIcons.lock,
          color: AppColors.quizReminderBrdr,
        ));
  }
}

class PlayableLeadingCircle extends StatelessWidget {
  const PlayableLeadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/course_list_playable_icon.png')),
          color: AppColors.courseListingCircleBackground.withOpacity(.10),
          shape: BoxShape.circle),
    );
  }
}

class PlayableButtonWidget extends StatelessWidget {
  const PlayableButtonWidget({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 82,
          height: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.backgroundSecondaryColor.withOpacity(.20)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded,
                  color: AppColors.backgroundSecondaryColor),
              SizedBox(width: 4),
              Text('Play',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16))
            ],
          )),
    );
  }
}
