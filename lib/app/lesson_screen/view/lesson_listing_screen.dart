import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';
import 'package:tradepro/app/lesson_screen/view/lesson_listing_loading.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../course_detail/model/course_detail_model.dart';
import '../../course_detail/view_model/course_detail_bloc.dart';
import '../../course_detail/view_model/course_detail_event.dart';
import '../../home/model/course_list_model.dart' as purchasedCourseModel;
import '../../home/view/home_view.dart';
import '../../home/view_model/bloc/home_bloc.dart';
import '../../home/view_model/bloc/home_event.dart';
import '../../quiz/view/quiz_view.dart';

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
  bool isFullScreen = false; // Track the fullscreen state

  // Callback function to handle fullscreen toggle
  void _handleFullScreenToggled(bool isFullScreen) {
    setState(() {
      this.isFullScreen = isFullScreen;
    });
    if (isFullScreen) {
      log("Entered fullscreen mode");
    } else {
      log("Exited fullscreen mode");
    }
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    log('heyyyyyy');
    if (isFullScreen) {
      // Exit full-screen mode when the back button is pressed
      setState(() {
        isFullScreen = false;
      });

      // Return to portrait mode and restore system UI
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      // Notify the video player widget to exit full screen
      return false; // Prevent exiting the screen when in full-screen mode
    }
    return true; // Allow exiting the screen when not in full-screen mode
  }

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimaryColor,
        body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
            builder: (context, state) {
          if (state is CourseDetailSuccesState) {
            BlocProvider.of<HomeBloc>(context).add(FetchHomeCourseList());
            if (videoUrl.value['videoUrl'] == null) {
              videoUrl.value = {
                'videoUrl': state.courseDetail?.courseDetail.previewVideo
              };
            }
            final courseDetail = state.courseDetail!.courseDetail;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height:
                      isFullScreen ? MediaQuery.of(context).size.height : 256,
                  child: ValueListenableBuilder<Map<String, String?>>(
                    valueListenable: videoUrl,
                    builder: (context, value, child) {
                      if (value['videoUrl'] == null) {
                        return const Text('No video available');
                      }
                      return VideoPlayerWidget(
                        videoUrl: value['videoUrl']!,
                        nextChapterId: value['nextChapter'],
                        onFullScreenToggled: _handleFullScreenToggled,
                      );
                    },
                  ),
                ),
                if (!isFullScreen)
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
                              children: List.generate(
                                  courseDetail.lessons.length, (lessonIndex) {
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
                                                color:
                                                    AppColors.languageBtnBorder,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15)),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      children: List.generate(
                                        lessonDetails.chapters?.length ?? 0,
                                        (chapterIndex) {
                                          final chapterDetails = lessonDetails
                                              .chapters![chapterIndex];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8),
                                            child: Row(children: [
                                              LeadingCircle(
                                                  purchasedId:
                                                      widget.purcahseCourseId,
                                                  chapters: const [],
                                                  chapterId: chapterDetails.id),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(chapterDetails.title,
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .blackColor,
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
                                              // isPlayeble(
                                              //         watchedLessons:
                                              //             state.playbleVideos ?? [],
                                              //         lessonId: chapterDetails.id)
                                              //     ?
                                              TrailingPlayButton(
                                                  chapters: const [],
                                                  chapterId: chapterDetails.id,
                                                  purchasedId:
                                                      widget.purcahseCourseId,
                                                  onTap: () {
                                                    // if (
                                                    //   isPlayeble(
                                                    //     watchedLessons:
                                                    //         state.playbleVideos!,
                                                    //     lessonId:
                                                    //         chapterDetails.id)) {

                                                    // }
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
                                                  })
                                              // : const LockedButtonWidget()
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Row(children: [
                                                LeadingCircle(
                                                    purchasedId:
                                                        widget.purcahseCourseId,
                                                    chapters:
                                                        lessonDetails.chapters!,
                                                    chapterId: null),
                                                // isQuizPlayable(
                                                //         watchedLessons:
                                                //             state.playbleVideos ??
                                                //                 [],
                                                //         allChapterInLesson:
                                                //             lessonDetails.chapters!)
                                                //     ? const PlayableLeadingCircle()
                                                //     : const LockedLeadingCircle(),
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
                                                TrailingPlayButton(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ScreenQuizView(
                                                                    purchasedId:
                                                                        widget
                                                                            .purcahseCourseId,
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
                                                    chapterId: null,
                                                    purchasedId:
                                                        widget.purcahseCourseId,
                                                    chapters:
                                                        lessonDetails.chapters!)
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
          } else if (state is CourseDetailLoadingState) {
            return LessonListingLoading(
                showUnloackMessage: state.unlockingNewChapter);
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        }),
      ),
    );
  }

  // bool isPlayeble({required List watchedLessons, required String lessonId}) {
  //   return watchedLessons.contains(lessonId);
  // }

  // bool isQuizPlayable(
  //     {required List watchedLessons,
  //     required List<Chapter> allChapterInLesson}) {
  //   for (var chapter in allChapterInLesson) {
  //     if (!watchedLessons.contains(chapter.id)) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }
}

class LockedButtonWidget extends StatelessWidget {
  const LockedButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HelperFuntions().showSnackBar(context, 'Locked');
      },
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
      child: Center(
        child: SvgPicture.asset(
            height: 16.99,
            width: 19.05,
            "assets/svg/chapter_listing_locked_leading_icon.svg",
            semanticsLabel: 'chapter_listing_locked_leading_icon'),
      ),
    );
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
          color: AppColors.courseListingCircleBackground.withOpacity(.10),
          shape: BoxShape.circle),
      child: Center(
        child: SvgPicture.asset(
            height: 16.99,
            width: 19.05,
            "assets/svg/chapter_listing_watchble_leading_icon.svg",
            semanticsLabel: 'chapter_listing_watchble_leading_icon'),
      ),
    );
  }
}

class PlayableButtonWidget extends StatelessWidget {
  const PlayableButtonWidget({super.key, this.onPlayTap});

  final void Function()? onPlayTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPlayTap,
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

class TrailingPlayButton extends StatelessWidget {
  const TrailingPlayButton(
      {super.key,
      required this.purchasedId,
      required this.chapters,
      this.onTap,
      required this.chapterId});
  final String purchasedId;
  final String? chapterId;
  final List<Chapter> chapters;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeCoursesFetchedState) {
        final currentCourse = state.course?.courses.purchasedCourses
            .where((course) => course.id == purchasedId)
            .first;
        final canShow = chapterId != null
            ? canPlayChapter(course: currentCourse, chapterId: chapterId!)
            : canPlayQuiz(
                watchedLessons: currentCourse?.isPlayedChapters,
                allChapterInLesson: chapters);
        return canShow
            ? PlayableButtonWidget(onPlayTap: onTap)
            : const LockedButtonWidget();
      } else {
        return Shimmer.fromColors(
            baseColor: AppColors.textFieldBorder,
            highlightColor: Colors.grey[400]!,
            child: const LockedButtonWidget());
      }
    });
  }

  bool canPlayChapter(
      {required purchasedCourseModel.PurchasedCourse? course,
      required String chapterId}) {
    if (course == null) {
      return false;
    }
    final isContain = course.isPlayedChapters.contains(chapterId);
    return isContain;
  }

  bool canPlayQuiz(
      {required List? watchedLessons,
      required List<Chapter> allChapterInLesson}) {
    if (watchedLessons == null) {
      return false;
    }
    for (var chapter in allChapterInLesson) {
      if (!watchedLessons.contains(chapter.id)) {
        return false;
      }
    }
    return true;
  }
}

class LeadingCircle extends StatelessWidget {
  const LeadingCircle({
    super.key,
    required this.purchasedId,
    required this.chapters,
    required this.chapterId,
  });
  final String purchasedId;
  final List<Chapter> chapters;
  final String? chapterId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeCoursesFetchedState) {
        final currentCourse = state.course?.courses.purchasedCourses
            .where((course) => course.id == purchasedId)
            .first;
        final canShow = chapterId != null
            ? canPlayChapter(course: currentCourse, chapterId: chapterId!)
            : canPlayQuiz(
                watchedLessons: currentCourse?.isPlayedChapters,
                allChapterInLesson: chapters);
        return canShow
            ? const PlayableLeadingCircle()
            : const LockedLeadingCircle();
      } else {
        return Shimmer.fromColors(
            baseColor: AppColors.textFieldBorder,
            highlightColor: Colors.grey[400]!,
            child: const LockedLeadingCircle());
      }
    });
  }

  bool canPlayChapter(
      {required purchasedCourseModel.PurchasedCourse? course,
      required String chapterId}) {
    if (course == null) {
      return false;
    }
    log(" heeey iam nishad ${course.isPlayedChapters.toString()}");
    final isContain = course.isPlayedChapters.contains(chapterId);
    log('chapter conatin $isContain');
    return isContain;
  }

  bool canPlayQuiz(
      {required List? watchedLessons,
      required List<Chapter> allChapterInLesson}) {
    if (watchedLessons == null) {
      return false;
    }
    for (var chapter in allChapterInLesson) {
      if (!watchedLessons.contains(chapter.id)) {
        return false;
      }
    }
    return true;
  }
}
