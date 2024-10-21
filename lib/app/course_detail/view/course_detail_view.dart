import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';

import '../../../const/widget/langaugeSelectionWidget.dart';

class ScreenCourseDetailView extends StatelessWidget {
  const ScreenCourseDetailView({super.key});

  static final List<String> availableLanguages = [
    'English',
    'Tamil',
    'Hindi',
    'Malayalam'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      appBar: AppBar(
          backgroundColor: AppColors.backgroundPrimaryColor,
          surfaceTintColor: AppColors.backgroundPrimaryColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                  height: 20,
                  width: 20,
                  "assets/svg/course_detail_share.svg",
                  semanticsLabel: 'course_detail_share'),
            )
          ]),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
          builder: (context, state) {
        if (state is CourseDetailSuccesState) {
          final courseDetail = state.courseDetail!.courseDetail;
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(15),
                shrinkWrap: true,
                children: [
                  ThumbnailCard(
                      url: courseDetail.previewVideo, showPreview: true),
                  const SizedBox(height: 15),
                  Text(
                    courseDetail.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 8),
                  AvailableLanguagesSmallCard(
                      availableLanguages: courseDetail.language,
                      backGroundColor:
                          AppColors.verifyYourPhone.withOpacity(.1),
                      textColor: AppColors.backgroundSecondaryColor),
                  const SizedBox(height: 8),
                  RatingBarWithUserName(
                    userName: courseDetail.author,
                    rating: courseDetail.starRating,
                    totalRatings: courseDetail.rating,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      PublishedEncounterCard(
                        icon: 'course_detail_calendar',
                        title: 'Published',
                        subString: courseDetail.publishedYear,
                      ),
                      const SizedBox(width: 12),
                      const PublishedEncounterCard(
                        icon: 'course_detail_enrolled_icon',
                        title: 'Enrolled',
                        subString: '1,078 people',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'This course include',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 12),
                  CourseInclude(
                    courseHour: courseDetail.courseDuration,
                    quizCount: courseDetail.quizCount,
                    videoCount: courseDetail.numberOfVideos,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    courseDetail.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Show more',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.verifyYourPhone),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Reviews',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.blackColor),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    // padding: EdgeInsets.symmetric(vertical: 21),
                    width: double.infinity,
                    height: 92,
                    decoration: BoxDecoration(
                        color: AppColors.backgroundSecondaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          courseDetail.starRating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 52,
                              color: AppColors.whiteColor),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: courseDetail.starRating,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 14,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              '(${courseDetail.rating}) Course Rating',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.whiteColor),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 60)
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.backgroundSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              showSelectLanguageSheet(context,
                                  course: courseDetail);
                            },
                            child: const Text(
                              'Purchase',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.whiteColor),
                            ))),
                  ))
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}

class CourseInclude extends StatelessWidget {
  const CourseInclude({
    super.key,
    this.courseHour,
    this.quizCount,
    this.videoCount,
  });
  final dynamic courseHour;
  final dynamic quizCount;
  final dynamic videoCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
                height: 20,
                width: 20,
                "assets/svg/course_detail_hours.svg",
                semanticsLabel: 'course_detail_hours'),
            const SizedBox(width: 12),
            Text(
              '${courseHour ?? '0'} total hours included',
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.blackColor),
            )
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SvgPicture.asset(
                height: 20,
                width: 20,
                "assets/svg/course_detail_quiz.svg",
                semanticsLabel: 'course_detail_quiz'),
            const SizedBox(width: 12),
            Text(
              '${quizCount ?? 0} Quiz',
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.blackColor),
            )
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SvgPicture.asset(
                height: 20,
                width: 20,
                "assets/svg/course_detail_videos.svg",
                semanticsLabel: 'course_detail_videos'),
            const SizedBox(width: 12),
            Text(
              '${videoCount ?? 0} Videos',
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.blackColor),
            )
          ],
        ),
      ],
    );
  }
}

class PublishedEncounterCard extends StatelessWidget {
  const PublishedEncounterCard({
    super.key,
    this.icon,
    required this.title,
    required this.subString,
    this.isBackGroundColorBlue = false,
  });
  final dynamic icon;
  final String title;
  final String subString;
  final bool isBackGroundColorBlue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 67,
        decoration: BoxDecoration(
            color: isBackGroundColorBlue
                ? AppColors.backgroundSecondaryColor
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null)
              icon is IconData
                  ? Icon(
                      icon,
                      color: isBackGroundColorBlue
                          ? AppColors.whiteColor
                          : AppColors.backgroundSecondaryColor,
                    )
                  : SvgPicture.asset(
                      height: 24,
                      width: 24,
                      "assets/svg/$icon.svg",
                      semanticsLabel: 'chapter_listing_locked_leading_icon'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isBackGroundColorBlue
                          ? AppColors.whiteColor
                          : AppColors.blackColor),
                ),
                Text(
                  subString,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: isBackGroundColorBlue
                          ? AppColors.whiteColor
                          : AppColors.videoCardUserNameColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
