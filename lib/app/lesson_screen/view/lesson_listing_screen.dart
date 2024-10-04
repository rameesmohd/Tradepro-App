import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
import 'package:tradepro/app/quiz/view/quiz_view.dart';
import 'package:tradepro/const/colors.dart';

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

  final ValueNotifier<String?> videoUrl = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
        if (state is CourseDetailSuccesState) {
          videoUrl.value ??= state.courseDetail?.courseDetail.previewVideo;
          final courseDetail = state.courseDetail!.courseDetail;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 256,
                child: ValueListenableBuilder<String?>(
                  valueListenable: videoUrl,
                  builder: (context, value, child) {
                    if (value == null) {
                      return const Text('No video available');
                    }
                    return VideoPlayerWidget(videoUrl: value);
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
                              (index) {
                            final lessonDetails = courseDetail.lessons[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Lesson ${index + 1} - ${lessonDetails.lessonName}',
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
                                    (index) {
                                      final chapterDetails =
                                          lessonDetails.chapters![index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Row(children: [
                                          Container(
                                              height: 42,
                                              width: 42,
                                              decoration: BoxDecoration(
                                                  image: chapterDetails.isPlayed
                                                      ? const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/course_list_playable_icon.png'))
                                                      : null,
                                                  color: chapterDetails.isPlayed
                                                      ? AppColors
                                                          .courseListingCircleBackground
                                                          .withOpacity(.10)
                                                      : null,
                                                  border: !chapterDetails
                                                          .isPlayed
                                                      ? Border.all(
                                                          color: AppColors
                                                              .textFieldBorder)
                                                      : null,
                                                  shape: BoxShape.circle),
                                              child: !chapterDetails.isPlayed
                                                  ? const Icon(
                                                      CupertinoIcons.lock,
                                                      color: AppColors
                                                          .quizReminderBrdr,
                                                    )
                                                  : null),
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
                                          InkWell(
                                            onTap: () {
                                              if (isPlayeble(
                                                  watchedLessons:
                                                      state.playbleVideos!,
                                                  lessonId:
                                                      chapterDetails.id)) {
                                                videoUrl.value =
                                                    chapterDetails.video;
                                              }
                                            },
                                            child: Container(
                                                width: 82,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    border: !isPlayeble(
                                                            watchedLessons: state
                                                                .playbleVideos!,
                                                            lessonId: chapterDetails
                                                                .id)
                                                        ? Border.all(
                                                            color: AppColors
                                                                .textFieldBorder)
                                                        : null,
                                                    color: isPlayeble(watchedLessons: state.playbleVideos!, lessonId: chapterDetails.id)
                                                        ? AppColors
                                                            .backgroundSecondaryColor
                                                            .withOpacity(.20)
                                                        : null),
                                                child: isPlayeble(
                                                        watchedLessons:
                                                            state.playbleVideos!,
                                                        lessonId: chapterDetails.id)
                                                    ? const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .play_arrow_rounded,
                                                              color: AppColors
                                                                  .backgroundSecondaryColor),
                                                          SizedBox(width: 4),
                                                          Text('Play',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 16))
                                                        ],
                                                      )
                                                    : const Center(
                                                        child: Text('Locked',
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .videoCardUserNameColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16)),
                                                      )),
                                          )
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
                                            Container(
                                                height: 42,
                                                width: 42,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.greenColor,
                                                    shape: BoxShape.circle)),
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
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ScreenQuizView(
                                                                quiz: lessonDetails
                                                                    .quiz!)));
                                              },
                                              child: Container(
                                                width: 82,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: AppColors
                                                        .backgroundSecondaryColor
                                                        .withOpacity(.20)),
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .play_arrow_rounded,
                                                        color: AppColors
                                                            .backgroundSecondaryColor),
                                                    SizedBox(width: 4),
                                                    Text('Play',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              ),
                                            )
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  bool isPlayeble({required List watchedLessons, required String lessonId}) {
    return watchedLessons.contains(lessonId);
  }
}
