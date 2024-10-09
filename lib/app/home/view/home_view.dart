import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/course_detail/view/course_detail_view.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_event.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_event.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';
import 'package:tradepro/app/lesson_screen/view/lesson_listing_screen.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/functions/helper_functions.dart';
import 'package:video_player/video_player.dart';

class ScreenHomeView extends StatefulWidget {
  const ScreenHomeView({super.key});

  @override
  State<ScreenHomeView> createState() => _ScreenHomeViewState();
}

class _ScreenHomeViewState extends State<ScreenHomeView> {
  late final List<String> languages;
  late final List<String> availableLanguages;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchHomeCourseList());
    languages = ['All', 'English', 'Tamil', 'Hindi', 'Malayalam'];
    availableLanguages = ['English', 'Tamil', 'Hindi', 'Malayalam'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimaryColor,
      body: ListView(
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.backgroundSecondaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor.withOpacity(.12)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/home_star.png'))),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          children: [
                            Text(
                              '₹35,000',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'wallet balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                  fontSize: 14),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    text: 'Total Referrals: ',
                                    children: [
                                  TextSpan(
                                      text: '780',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ])),
                            const SizedBox(width: 5),
                            Container(
                              height: 4,
                              width: 4,
                              decoration: const BoxDecoration(
                                  color: AppColors.whiteColor,
                                  shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 5),
                            RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                    text: 'Active User: ',
                                    children: [
                                  TextSpan(
                                      text: '20',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600))
                                ])),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.double_arrow_rounded,
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeCoursesFetchedState) {
              log(state.course!.courses.purchasedCourses.isEmpty.toString());
              return state.course!.courses.purchasedCourses.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('Unlock Your Financial Potential:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('Start Trading Today!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: AppColors.backgroundSecondaryColor)),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              scrollDirection: Axis.horizontal,
                              itemCount: languages.length,
                              itemBuilder: (context, index) => LanguageButton(
                                language: languages[index],
                                isSelected: index == 0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ...List.generate(
                            state.course!.courses.allCourses.length,
                            (index) {
                              final course =
                                  state.course!.courses.allCourses[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: InkWell(
                                  onTap: () {
                                    BlocProvider.of<CourseDetailBloc>(context)
                                        .add(FetchCouseDetail(
                                            id: course.id!,
                                            isPurchased: false));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ScreenCourseDetailView()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.textFieldBorder),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // show video thumbnail here
                                        Container(
                                          alignment: Alignment.center,
                                          height: 196,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: AppColors.textFieldBorder,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: VideoPlayerWidget(
                                              videoUrl: course.previewVideo!),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          '${course.title} (${course.courseType})',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.blackColor),
                                        ),
                                        const SizedBox(height: 8),
                                        AvailableLanguagesSmallCard(
                                            availableLanguages:
                                                course.language!,
                                            textColor: AppColors
                                                .backgroundSecondaryColor,
                                            backGroundColor: AppColors
                                                .verifyYourPhone
                                                .withOpacity(.1)),
                                        const SizedBox(height: 8),
                                        RatingBarWithUserName(
                                            userName: course.author),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Text(
                                              '₹${course.price}',
                                              style: const TextStyle(
                                                  color: AppColors.blackColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            // SizedBox(width: 8),
                                            // Text(
                                            //   '₹42000',
                                            //   style: TextStyle(
                                            //       color: AppColors.videoCardUserNameColor,
                                            //       fontWeight: FontWeight.w400,
                                            //       fontSize: 16),
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ])
                  : SizedBox(
                      child: Column(children: [
                        ...List.generate(
                          state.course!.courses.allCourses.length,
                          (index) {
                            final course =
                                state.course!.courses.allCourses[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<CourseDetailBloc>(context)
                                      .add(FetchCouseDetail(
                                          id: course.id!, isPurchased: false));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenCourseDetailView()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.textFieldBorder),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // show video thumbnail here
                                      Container(
                                        alignment: Alignment.center,
                                        height: 196,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.textFieldBorder,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: VideoPlayerWidget(
                                            videoUrl: course.previewVideo!),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${course.title} (${course.courseType})',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: AppColors.blackColor),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (!course.wishlistUser.contains(
                                                  HelperFuntions
                                                      .currentUser!.id)) {
                                                
                                              }
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors
                                                      .backgroundSecondaryColor
                                                      .withOpacity(.10)),
                                              child: Icon(
                                                course.wishlistUser.contains(
                                                        HelperFuntions
                                                            .currentUser!.id)
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_outlined,
                                                color: AppColors
                                                    .backgroundSecondaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      AvailableLanguagesSmallCard(
                                          availableLanguages: course.language!,
                                          textColor: AppColors
                                              .backgroundSecondaryColor,
                                          backGroundColor: AppColors
                                              .verifyYourPhone
                                              .withOpacity(.1)),
                                      const SizedBox(height: 8),
                                      RatingBarWithUserName(
                                          userName: course.author),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${course.price}',
                                            style: const TextStyle(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          // SizedBox(width: 8),
                                          // Text(
                                          //   '₹42000',
                                          //   style: TextStyle(
                                          //       color: AppColors.videoCardUserNameColor,
                                          //       fontWeight: FontWeight.w400,
                                          //       fontSize: 16),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ...List.generate(
                          state.course!.courses.purchasedCourses.length,
                          (index) {
                            final course =
                                state.course!.courses.purchasedCourses[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScreenCourseLessonListing(
                                                  vachableChapter:
                                                      course.isPlayedChapters,
                                                  purcahseCourseId: course.id,
                                                  courseId:
                                                      course.courseModel.id)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.textFieldBorder),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // show video thumbnail here
                                      Container(
                                        alignment: Alignment.center,
                                        height: 196,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColors.textFieldBorder,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: VideoPlayerWidget(
                                            videoUrl: course
                                                .courseModel.previewVideo),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        '${course.courseModel.title} (${course.courseModel.courseType})',
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColors.blackColor),
                                      ),
                                      const SizedBox(height: 8),
                                      AvailableLanguagesSmallCard(
                                          availableLanguages: [course.language],
                                          textColor: AppColors
                                              .backgroundSecondaryColor,
                                          backGroundColor: AppColors
                                              .verifyYourPhone
                                              .withOpacity(.1)),
                                      const SizedBox(height: 8),
                                      RatingBarWithUserName(
                                          userName: course.courseModel.author),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${course.courseModel.price}',
                                            style: const TextStyle(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          // SizedBox(width: 8),
                                          // Text(
                                          //   '₹42000',
                                          //   style: TextStyle(
                                          //       color: AppColors.videoCardUserNameColor,
                                          //       fontWeight: FontWeight.w400,
                                          //       fontSize: 16),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ]),
                    );
            } else {
              return const LinearProgressIndicator();
            }
          }),
          const Padding(
            padding: EdgeInsets.all(15),
            child: ReferalAdCard(
              title: '#ShareTheJoy',
              description: 'Earn up-to ',
              boldDesc: '₹3500 ',
              trilingDesc: 'in return!',
              buttonText: 'Refer Now',
              buttonColor: AppColors.blackColor,
              titleBackGroundColor: AppColors.backgroundSecondaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: Text('Upcoming Courses',
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const ThumbnailCard(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'How manage Risk in the Stock market?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.whiteColor),
                      ),
                    ),
                    SizedBox(width: 50)
                  ],
                ),
                const SizedBox(height: 8),
                AvailableLanguagesSmallCard(
                    availableLanguages: availableLanguages,
                    backGroundColor: AppColors.whiteColor,
                    textColor: AppColors.backgroundSecondaryColor)
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}

class ReferalAdCard extends StatelessWidget {
  const ReferalAdCard({
    super.key,
    required this.title,
    required this.description,
    required this.boldDesc,
    required this.buttonText,
    this.showTermsAndCon = false,
    required this.titleBackGroundColor,
    required this.buttonColor,
    required this.trilingDesc,
    this.gradiantColors,
  });
  final String title;
  final String description;
  final String boldDesc;
  final String trilingDesc;
  final String buttonText;
  final bool showTermsAndCon;
  final Color titleBackGroundColor;
  final Color buttonColor;
  final List<Color>? gradiantColors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: AppColors.textFieldBorder)),
          width: double.infinity,
          height: 196,
          padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                          text: description,
                          children: [
                        TextSpan(
                            text: boldDesc,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(
                          text: trilingDesc,
                        )
                      ])),
                  const SizedBox(height: 4),
                  gradiantColors != null
                      ? Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 28,
                          width: 133,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: gradiantColors!,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: AppColors.whiteColor),
                          ),
                        )
                      : SizedBox(
                          height: 28,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blackColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  buttonText,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: AppColors.whiteColor),
                                ),
                              ))),
                  const SizedBox(height: 30),
                  if (showTermsAndCon)
                    const Text('*Terms & Condition Applied',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 7,
                            color: AppColors.languageBtnBorder))
                ],
              )),
              Expanded(
                  child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image:
                              AssetImage('assets/images/home_referral.png'))),
                ),
              ))
            ],
          ),
        ),
        Positioned(
          top: 15,
          left: 1,
          child: Container(
            alignment: Alignment.center,
            height: 28,
            decoration: BoxDecoration(
                color: titleBackGroundColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class RatingBarWithUserName extends StatelessWidget {
  const RatingBarWithUserName({
    super.key,
    this.userName,
  });
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/user_in_videocard.png')),
              color: AppColors.backgroundSecondaryColor,
              shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(userName ?? 'Jos Brown',
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.videoCardUserNameColor)),
        const SizedBox(width: 10),
        // const SizedBox(
        //   height: 21,
        //   child: VerticalDivider(
        //     width: 0,
        //     color: AppColors.textFieldBorder,
        //   ),
        // ),
        // const SizedBox(width: 10),
        // const Text(
        //   '4.8',
        //   style: TextStyle(
        //     fontWeight: FontWeight.w600,
        //     fontSize: 14,
        //   ),
        // ),
        // const SizedBox(width: 3.5),
        // const Icon(
        //   Icons.star_rate_rounded,
        //   color: AppColors.ratingStarColor,
        //   size: 14,
        // ),
        // const Icon(
        //   Icons.star_rate_rounded,
        //   color: AppColors.ratingStarColor,
        //   size: 14,
        // ),
        // const Icon(
        //   Icons.star_rate_rounded,
        //   color: AppColors.ratingStarColor,
        //   size: 14,
        // ),
        // const Icon(
        //   Icons.star_rate_rounded,
        //   color: AppColors.ratingStarColor,
        //   size: 14,
        // ),
        // const Icon(
        //   Icons.star_rate_rounded,
        //   color: AppColors.ratingStarColor,
        //   size: 14,
        // ),
        // const SizedBox(
        //   width: 8,
        // ),
        // const Text(
        //   '(1,454 rating)',
        //   style: TextStyle(
        //       color: AppColors.blackColor,
        //       fontWeight: FontWeight.w500,
        //       fontSize: 12),
        // ),
      ],
    );
  }
}

class AvailableLanguagesSmallCard extends StatelessWidget {
  const AvailableLanguagesSmallCard({
    super.key,
    required this.availableLanguages,
    required this.backGroundColor,
    required this.textColor,
  });

  final List<String> availableLanguages;
  final Color backGroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(
          availableLanguages.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: backGroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  availableLanguages[index],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ThumbnailCard extends StatelessWidget {
  const ThumbnailCard({
    super.key,
    this.showPreview = false,
    this.url,
  });
  final bool showPreview;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 196,
      decoration: BoxDecoration(
          color: AppColors.textFieldBorder,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: url != null ? VideoPlayerWidget(videoUrl: url!) : null,
          ),
          // Container(
          //   width: 97,
          //   height: 97,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: AppColors.whiteColor.withOpacity(.4)),
          // ),
          // Container(
          //   width: 74,
          //   height: 74,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: AppColors.whiteColor.withOpacity(.4)),
          // ),
          // const VideoPlayButton(),
          if (showPreview)
            const Positioned(
              top: 160,
              child: Text('Preview',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.whiteColor)),
            )
        ],
      ),
    );
  }
}

class VideoPlayButton extends StatelessWidget {
  const VideoPlayButton({
    super.key,
    this.isPlaying,
  });
  final bool? isPlaying;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 43,
        width: 43,
        decoration: const BoxDecoration(
            color: AppColors.backgroundSecondaryColor, shape: BoxShape.circle),
        child: isPlaying != null
            ? Icon(
                isPlaying! ? Icons.pause : Icons.play_arrow,
                color: AppColors.whiteColor,
              )
            : const SizedBox());
  }
}

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    super.key,
    required this.language,
    required this.isSelected,
  });

  final String language;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? AppColors.backgroundSecondaryColor
                : AppColors.whiteColor,
            border: !isSelected
                ? Border.all(color: AppColors.languageBtnBorder)
                : null),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            language,
            style: TextStyle(
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.languageBtnBorder,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget(
      {super.key, required this.videoUrl, this.showButton = true});
  final String videoUrl;
  final bool showButton;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool isLoadin = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  // Method to initialize the video controller
  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          isLoadin = false;
        });
      });

    _controller.addListener(() {
      if (_controller.value.isBuffering) {
        setState(() {
          isLoadin = true;
        });
      } else {
        setState(() {
          isLoadin = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      // If the video URL changes, dispose of the old controller and initialize the new one
      _controller.dispose();
      _initializeVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (_controller.value.isInitialized)
          VideoPlayer(_controller)
        else
          const Center(child: CircularProgressIndicator()),
        if (widget.showButton)
          InkWell(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: isLoadin
                ? const CircularProgressIndicator()
                : VideoPlayButton(
                    isPlaying: _controller.value.isPlaying,
                  ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
