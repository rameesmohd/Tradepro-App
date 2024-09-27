import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_state.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';

import '../../checkout/view/checkout_view.dart';
import '../model/course_detail_model.dart';

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined))
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
                  RatingBarWithUserName(userName: courseDetail.author),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      PublishedEncounterCard(
                        icon: Icons.calendar_month_outlined,
                        title: 'Published',
                        subString: courseDetail.publishedYear,
                      ),
                      const SizedBox(width: 12),
                      const PublishedEncounterCard(
                        icon: Icons.people_outline,
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '4.8',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 52,
                              color: AppColors.whiteColor),
                        ),
                        SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star_rate_rounded,
                                    color: AppColors.ratingStarColor),
                                Icon(Icons.star_rate_rounded,
                                    color: AppColors.ratingStarColor),
                                Icon(Icons.star_rate_rounded,
                                    color: AppColors.ratingStarColor),
                                Icon(Icons.star_rate_rounded,
                                    color: AppColors.ratingStarColor),
                                Icon(Icons.star_rate_rounded,
                                    color: AppColors.ratingStarColor),
                              ],
                            ),
                            Text(
                              '(1476) Course Rating',
                              style: TextStyle(
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
                              showSelectLanguageSheet(context, courseDetail);
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

  Future showSelectLanguageSheet(BuildContext ctx, CourseDetail course) {
    final ValueNotifier<String?> selectedLanguage = ValueNotifier(null);
    return showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              width: double.infinity,
              // height: 421,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 64),
                  const Text(
                    'Select Language',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.verifyYourPhone),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose your preferred language to enhance your experience. Select from a variety of languages to customize the app interface and content to your comfort',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.regSubtitle),
                  ),
                  const SizedBox(height: 24),
                  ValueListenableBuilder(
                      valueListenable: selectedLanguage,
                      builder: (context, languageSelected, child) {
                        return Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                              course.language.length,
                              (index) => InkWell(
                                onTap: () {
                                  selectedLanguage.value =
                                      course.language[index];
                                },
                                child: languageSelected ==
                                        course.language[index]
                                    ? SizedBox(
                                        height: 56,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        child: Stack(
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Color(
                                                              0xFF564DDB), // #564DDB
                                                          Color(
                                                              0xFF256BDC), // #256BDC
                                                          Color(
                                                              0xFF1987DA), // #1987DA
                                                          Color(
                                                              0xFF37C2CA), // #37C2CA
                                                          Color(
                                                              0xFF0E43D2), // #0E43D2
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5))),
                                            Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: Container(
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .backgroundSecondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Radio(
                                                          fillColor: WidgetStateColor
                                                              .resolveWith(
                                                                  (states) =>
                                                                      AppColors
                                                                          .whiteColor),
                                                          value: course
                                                              .language[index],
                                                          groupValue:
                                                              languageSelected,
                                                          onChanged: (value) {
                                                            selectedLanguage
                                                                .value = value;
                                                          }),
                                                      Text(
                                                        takeLanguage(course
                                                            .language[index]),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .whiteColor),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 56,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            border: Border.all(
                                                color:
                                                    AppColors.textFieldBorder),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                                fillColor: WidgetStateColor
                                                    .resolveWith((states) =>
                                                        AppColors
                                                            .languageBtnBorder),
                                                value: course.language[index],
                                                groupValue: languageSelected,
                                                onChanged: (value) {
                                                  selectedLanguage.value =
                                                      value;
                                                }),
                                            Text(
                                              takeLanguage(
                                                  course.language[index]),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: AppColors
                                                      .languageBtnBorder),
                                            )
                                          ],
                                        )),
                              ),
                            ));
                      }),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.backgroundSecondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          onPressed: () {
                            Map<String, dynamic> courseValues = {
                              'title': course.title,
                              'amount': course.price,
                              'url': course.previewVideo,
                              'language': selectedLanguage.value!,
                              'auther': course.author,
                              'published': course.publishedYear,
                              'video_hours': course.courseDuration,
                              'quiz_count': course.quizCount,
                              'video_count': course.numberOfVideos
                            };
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenCeckoutView(
                                        checkoutCourse: courseValues)));
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: AppColors.whiteColor),
                          ))),
                  const SizedBox(height: 16),
                ],
              ));
        });
  }

  String takeLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'english':
        return 'English';
      case 'hindi':
        return 'हिंदी';
      case 'malayalam':
        return 'മലയാളം';
      case 'tamil':
        return 'தமிழ்';
      default:
        return 'English';
    }
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
            const Icon(
              Icons.timer_outlined,
              color: AppColors.blackColor,
            ),
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
            const Icon(
              Icons.edit_note,
              color: AppColors.blackColor,
            ),
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
            const Icon(
              Icons.video_collection_outlined,
              color: AppColors.blackColor,
            ),
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
    required this.icon,
    required this.title,
    required this.subString,
    this.isBackGroundColorBlue = false,
  });
  final IconData icon;
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
            Icon(
              icon,
              color: isBackGroundColorBlue
                  ? AppColors.whiteColor
                  : AppColors.backgroundSecondaryColor,
            ),
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
