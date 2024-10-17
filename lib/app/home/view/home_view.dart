import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/app/course_detail/view/course_detail_view.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_event.dart';
import 'package:tradepro/app/dashboard/view/dashboard_view.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_bloc.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_event.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_state.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_event.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';
import 'package:tradepro/app/lesson_screen/view/lesson_listing_screen.dart';
import 'package:tradepro/app/refer_screen/view/refer_view.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_bloc.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_state.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/functions/helper_functions.dart';
import 'package:tradepro/const/widget/langaugeSelectionWidget.dart';
import 'package:tradepro/const/widget/network_connection_error_widget.dart';
import 'package:video_player/video_player.dart';

import '../widget/home_loading.dart';

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
            child: BlocBuilder<DashboardBloc, DashBoardState>(
                builder: (context, state) {
              if (state is DashBoardDetailSuccesState) {
                return state.dashboardDetails?.data != null
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                      backgroundColor:
                                          AppColors.backgroundPrimaryColor,
                                      appBar: AppBar(
                                        backgroundColor:
                                            AppColors.backgroundPrimaryColor,
                                      ),
                                      body: const ScreenDashboardView())));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.backgroundSecondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    height: 50,
                                    width: 50,
                                    "assets/svg/home_dash_star_icon.svg",
                                    semanticsLabel: 'settings_logo_bottom_nav'),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '₹${state.dashboardDetails?.data?.totalIncome ?? 0}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.whiteColor,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
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
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                text: 'Total Referrals: ',
                                                children: [
                                              TextSpan(
                                                  text:
                                                      "${state.dashboardDetails?.data?.totalTeamMembers.length ?? 0}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600))
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
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                text: 'Active User: ',
                                                children: [
                                              TextSpan(
                                                  text:
                                                      "${state.dashboardDetails?.data?.activeUsers.length ?? 0}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ])),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                    height: 12,
                                    width: 12,
                                    "assets/svg/home_dash_card_arrow_icon.svg",
                                    semanticsLabel:
                                        'home_dash_card_arrow_icon'),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
              } else {
                return Container(
                  width: double.infinity,
                  height: 85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.backgroundSecondaryColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            height: 50,
                            width: 50,
                            "assets/svg/home_dash_star_icon.svg",
                            semanticsLabel: 'settings_logo_bottom_nav'),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  '₹0',
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
                            Text(
                                state is DashboardLoadingFailed
                                    ? state.errorMessage.split('.')[0]
                                    : 'Loading...',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor,
                                    fontSize: 14))
                          ],
                        ),
                        const Spacer(),
                        state is DashBoardLoadingState
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.whiteColor,
                              )
                            : InkWell(
                                onTap: () {
                                  BlocProvider.of<DashboardBloc>(context)
                                      .add(DashboardFetchEvent());
                                },
                                child: const Icon(
                                  Icons.replay_circle_filled_rounded,
                                  color: AppColors.whiteColor,
                                ),
                              )
                      ],
                    ),
                  ),
                );
              }
            }),
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
                                            id: course.id, isPurchased: false));
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
                                              videoUrl: course.previewVideo),
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
                                                    color:
                                                        AppColors.blackColor),
                                              ),
                                            ),
                                            BlocBuilder<WishListBloc,
                                                    WishListState>(
                                                builder: (context, state) {
                                              return InkWell(
                                                onTap: () {
                                                  if (!course.wishlistUser
                                                      .contains(HelperFuntions
                                                          .currentUser!.id)) {
                                                    showSelectLanguageSheet(
                                                        context,
                                                        courseForAddWishlist:
                                                            course);
                                                  } else {}
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
                                                                .currentUser!
                                                                .id)
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border_outlined,
                                                    color: AppColors
                                                        .backgroundSecondaryColor,
                                                    size: 20,
                                                  ),
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        AvailableLanguagesSmallCard(
                                            availableLanguages: course.language
                                                .whereType<String>()
                                                .toList(),
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Continue Watching:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20)),
                            ),
                            const SizedBox(height: 15),
                            ...List.generate(
                              state.course!.courses.purchasedCourses.length,
                              (index) {
                                final course = state
                                    .course!.courses.purchasedCourses[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenCourseLessonListing(
                                                      vachableChapter: course
                                                          .isPlayedChapters,
                                                      purcahseCourseId:
                                                          course.id,
                                                      courseId: course
                                                          .courseModel.id)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: AppColors
                                              .backgroundSecondaryColor,
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
                                                color: AppColors
                                                    .backgroundSecondaryColor,
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
                                                color: AppColors.whiteColor),
                                          ),
                                          const SizedBox(height: 8),
                                          AvailableLanguagesSmallCard(
                                              availableLanguages: [
                                                course.language
                                              ],
                                              textColor: AppColors.languageText,
                                              backGroundColor:
                                                  AppColors.languageBackground),
                                          const SizedBox(height: 8),
                                          RatingBarWithUserName(
                                            userName: course.courseModel.author,
                                            color: AppColors.whiteColor,
                                          ),
                                          const SizedBox(height: 12),
                                          const Divider(
                                              color:
                                                  AppColors.purchasedDivider),
                                          const SizedBox(height: 12),
                                          ProgressBar(
                                              progress: ((course
                                                              .isPlayedChapters
                                                              .length /
                                                          course
                                                              .totalChapters) *
                                                      100)
                                                  .round(),
                                              title: 'Progress')
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ]),
                    );
            } else if (state is HomeStateCoursesLoadingState) {
              return const HomeLoadingWidget();
            } else if (state is HomeStateLoadingFailedState) {
              return NetworkConnectionError(
                description: state.errorMessage,
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(FetchHomeCourseList());
                },
              );
            } else {
              return const Text('Something went wrong');
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
          // const Padding(
          //   padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
          //   child: Text('Upcoming Courses',
          //       style: TextStyle(
          //           color: AppColors.blackColor,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 20)),
          // ),
          // Container(
          //   margin: const EdgeInsets.all(15),
          //   alignment: Alignment.center,
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //       color: AppColors.backgroundSecondaryColor,
          //       borderRadius: BorderRadius.circular(12)),
          //   child: Column(
          //     children: [
          //       const ThumbnailCard(),
          //       const SizedBox(height: 12),
          //       const Row(
          //         children: [
          //           Expanded(
          //             child: Text(
          //               'How manage Risk in the Stock market?',
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 16,
          //                   color: AppColors.whiteColor),
          //             ),
          //           ),
          //           SizedBox(width: 50)
          //         ],
          //       ),
          //       const SizedBox(height: 8),
          //       AvailableLanguagesSmallCard(
          //           availableLanguages: availableLanguages,
          //           backGroundColor: AppColors.whiteColor,
          //           textColor: AppColors.backgroundSecondaryColor)
          //     ],
          //   ),
          // ),
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
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ReferAndEarnVeiw()));
      },
      child: Stack(
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
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                  child: SvgPicture.asset(
                      height: 136.07,
                      width: 150,
                      "assets/svg/home_referrel_card_image.svg",
                      semanticsLabel: 'home_referrel_card_image'),
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
      ),
    );
  }
}

class RatingBarWithUserName extends StatelessWidget {
  const RatingBarWithUserName({
    super.key,
    this.userName,
    this.color,
  });
  final String? userName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
            height: 20,
            width: 19.7,
            "assets/svg/auther_default_image.svg",
            semanticsLabel: 'settings_logo_bottom_nav'),
        const SizedBox(width: 8),
        Text(userName ?? 'Jos Brown',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: color ?? AppColors.videoCardUserNameColor)),
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
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.showButton = true,
    this.purchasedId,
    this.nextChapterId,
    this.onFullScreenToggled,
  });

  final String videoUrl;
  final bool showButton;
  final String? purchasedId;
  final String? nextChapterId;
  final ValueChanged<bool>? onFullScreenToggled;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  bool isMuted = false;
  bool isLoading = true;
  bool played = false;
  bool showControls = true; // To toggle control visibility
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  late bool isChapterUnlocked;
  Timer? _hideControlsTimer; // Timer to auto-hide controls
  bool isFullScreen = false; // Full screen state

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  // Method to initialize the video controller
  void _initializeVideo() {
    setState(() {
      played = false;
      isLoading = true;
      isChapterUnlocked = false;
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
          _totalDuration = _controller.value.duration;
        });
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _currentPosition = _controller.value.position;
        });
      }

      if (_controller.value.isBuffering) {
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }

      if (_controller.value.position >= _controller.value.duration &&
          widget.nextChapterId != null &&
          !isChapterUnlocked) {
        log("Unlocking next Chapter");
        BlocProvider.of<CourseDetailBloc>(context)
            .add(ChapterUnloackEvent(chapterId: widget.nextChapterId!));
        isChapterUnlocked = true;
      }
    });
  }

  // Timer to auto-hide the controls
  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        showControls = false; // Hide the controls after 5 seconds
      });
    });
  }

  Future<bool> _onWillPop() async {
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

  // Show controls and reset the timer
  void _toggleControls() {
    setState(() {
      showControls = true;
    });
    _startHideControlsTimer(); // Restart the timer
  }

  // Skip video by the specified number of seconds
  void _skipVideo(int seconds) {
    final newPosition = _currentPosition + Duration(seconds: seconds);
    _controller.seekTo(newPosition);
  }

  // Mute/Unmute video
  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : 1);
    });
  }

  // Play/Pause video
  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _animationController.reverse();
      } else {
        _controller.play();
        _animationController.forward();
      }
    });
    _startHideControlsTimer(); // Reset timer when play/pause is toggled
  }

  // Enter/Exit full screen
  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
      if (isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }

      // Notify the parent widget of the fullscreen status
      if (widget.onFullScreenToggled != null) {
        widget.onFullScreenToggled!(isFullScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log('next chapter ${widget.nextChapterId}');
    return GestureDetector(
      onTap: _toggleControls, // Show controls on tap
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller))
            else
              const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.whiteColor)),
            if (isLoading && !showControls)
              const CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            if (widget.showButton && showControls)
              !played
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          played = true;
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: AppColors.whiteColor)
                          : VideoPlayButton(
                              isPlaying: _controller.value.isPlaying,
                            ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          // Skip, Play/Pause, Skip Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () => _skipVideo(-10),
                                icon: const Icon(
                                  Icons.keyboard_double_arrow_left_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              isLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.whiteColor)
                                  : IconButton(
                                      onPressed: _togglePlayPause,
                                      iconSize: 48,
                                      icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 64,
                                        color: Colors.white,
                                      ),
                                    ),
                              // IconButton(
                              //   onPressed: _togglePlayPause,
                              //   iconSize: 48,
                              //   icon: AnimatedIcon(
                              //     color: AppColors.whiteColor,
                              //     icon: AnimatedIcons.play_pause,
                              //     progress: _animationController,
                              //   ),
                              // ),
                              IconButton(
                                onPressed: () => _skipVideo(10),
                                icon: const Icon(
                                  Icons.keyboard_double_arrow_right_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // Video Controls: Progress Slider, Volume, Full Screen
                          Row(
                            children: [
                              // Current Position
                              Text(
                                _formatDuration(_currentPosition),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              // Progress Slider
                              Expanded(
                                child: Slider(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white.withOpacity(0.5),
                                  thumbColor: Colors.white,
                                  value: _currentPosition.inSeconds.toDouble(),
                                  min: 0,
                                  max: _totalDuration.inSeconds.toDouble(),
                                  onChanged: (value) {
                                    setState(() {
                                      _currentPosition =
                                          Duration(seconds: value.toInt());
                                      _controller.seekTo(_currentPosition);
                                    });
                                  },
                                ),
                              ),
                              // Total Duration
                              Text(
                                _formatDuration(_totalDuration),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              // Mute/Unmute Button
                              IconButton(
                                onPressed: _toggleMute,
                                icon: Icon(
                                  isMuted
                                      ? Icons.volume_off_rounded
                                      : Icons.volume_up_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              // Full Screen Button
                              IconButton(
                                onPressed: _toggleFullScreen,
                                icon: Icon(
                                  isFullScreen
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _initializeVideo();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _hideControlsTimer?.cancel(); // Dispose of the timer

    super.dispose();
  }
}



/*

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.showButton = true,
    this.purchasedId,
    this.nextChapterId,
  });

  final String videoUrl;
  final bool showButton;
  final String? purchasedId;
  final String? nextChapterId;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _animationController;
  bool isMuted = false;
  bool isLoading = true;
  bool played = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  late bool isChapterUnlocked;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  // Method to initialize the video controller
  void _initializeVideo() {
    setState(() {
      played = false;
      isLoading = true;
      isChapterUnlocked = false;
    });
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
          _totalDuration = _controller.value.duration;
        });
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        setState(() {
          _currentPosition = _controller.value.position;
        });
      }

      if (_controller.value.isBuffering) {
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }

      if (_controller.value.position >= _controller.value.duration &&
          widget.nextChapterId != null &&
          !isChapterUnlocked) {
        log("Unlocking next Chapter");
        BlocProvider.of<CourseDetailBloc>(context)
            .add(ChapterUnloackEvent(chapterId: widget.nextChapterId!));
        isChapterUnlocked = true;
      }
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _initializeVideo();
    }
  }

  // Skip video by the specified number of seconds
  void _skipVideo(int seconds) {
    final newPosition = _currentPosition + Duration(seconds: seconds);
    _controller.seekTo(newPosition);
  }

  // Mute/Unmute video
  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0 : 1);
    });
  }

  // Play/Pause video
  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _animationController.reverse();
      } else {
        _controller.play();
        _animationController.forward();
      }
    });
  }

  // Enter/Exit full screen (you can add your logic for full screen)
  void _toggleFullScreen() {
    // Logic to toggle full-screen mode can be added here.
    log('Full screen button pressed');
  }

  @override
  Widget build(BuildContext context) {
    log('next chapter ${widget.nextChapterId}');
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (_controller.value.isInitialized)
            VideoPlayer(_controller)
          else
            const Center(child: CircularProgressIndicator()),
          if (widget.showButton)
            !played
                ? InkWell(
                    onTap: () {
                      setState(() {
                        played = true;
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : VideoPlayButton(
                            isPlaying: _controller.value.isPlaying,
                          ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        // Skip, Play/Pause, Skip Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () => _skipVideo(-10),
                              icon: const Icon(
                                Icons.keyboard_double_arrow_left_rounded,
                                color: Colors.white,
                              ),
                            ),
                            isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                  )
                                : IconButton(
                                    onPressed: _togglePlayPause,
                                    iconSize: 48,
                                    icon: AnimatedIcon(
                                      color: AppColors.whiteColor,
                                      icon: AnimatedIcons.play_pause,
                                      progress: _animationController,
                                    ),
                                  ),
                            IconButton(
                              onPressed: () => _skipVideo(10),
                              icon: const Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Video Controls: Progress Slider, Volume, Full Screen
                        Row(
                          children: [
                            // Current Position
                            Text(
                              _formatDuration(_currentPosition),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            // Progress Slider
                            Expanded(
                              child: Slider(
                                activeColor: Colors.white,
                                inactiveColor: Colors.white.withOpacity(0.5),
                                thumbColor: Colors.white,
                                value: _currentPosition.inSeconds.toDouble(),
                                min: 0,
                                max: _totalDuration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    _currentPosition =
                                        Duration(seconds: value.toInt());
                                    _controller.seekTo(_currentPosition);
                                  });
                                },
                              ),
                            ),
                            // Total Duration
                            Text(
                              _formatDuration(_totalDuration),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            // Mute/Unmute Button
                            IconButton(
                              onPressed: _toggleMute,
                              icon: Icon(
                                isMuted
                                    ? Icons.volume_off_rounded
                                    : Icons.volume_up_rounded,
                                color: Colors.white,
                              ),
                            ),
                            // Full Screen Button
                            IconButton(
                              onPressed: _toggleFullScreen,
                              icon: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}




*/