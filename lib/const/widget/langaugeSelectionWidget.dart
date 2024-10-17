import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/home/model/course_list_model.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_bloc.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_event.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_state.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../app/checkout/view/checkout_view.dart';
import '../../app/course_detail/model/course_detail_model.dart';
import '../../app/home/view_model/bloc/home_event.dart';
import '../colors.dart';

Future showSelectLanguageSheet(BuildContext ctx,
    {CourseDetail? course, AllCourse? courseForAddWishlist}) {
  final ValueNotifier<String?> selectedLanguage = ValueNotifier(null);
  final List<String> languages =
      (course?.language ?? courseForAddWishlist?.language ?? [])
          .whereType<String>()
          .toList();
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
                            languages.length,
                            (index) => InkWell(
                              onTap: () {
                                selectedLanguage.value = languages[index];
                              },
                              child: languageSelected == languages[index]
                                  ? SizedBox(
                                      height: 56,
                                      width: MediaQuery.of(context).size.width *
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Radio(
                                                        fillColor: WidgetStateColor
                                                            .resolveWith((states) =>
                                                                AppColors
                                                                    .whiteColor),
                                                        value: languages[index],
                                                        groupValue:
                                                            languageSelected,
                                                        onChanged: (value) {
                                                          selectedLanguage
                                                              .value = value;
                                                        }),
                                                    Text(
                                                      HelperFuntions()
                                                          .takeLanguage(
                                                              languages[index]),
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
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          border: Border.all(
                                              color: AppColors.textFieldBorder),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              fillColor:
                                                  WidgetStateColor.resolveWith(
                                                      (states) => AppColors
                                                          .languageBtnBorder),
                                              value: languages[index],
                                              groupValue: languageSelected,
                                              onChanged: (value) {
                                                selectedLanguage.value = value;
                                              }),
                                          Text(
                                            HelperFuntions()
                                                .takeLanguage(languages[index]),
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
                BlocListener<WishListBloc, WishListState>(
                  listener: (context, state) {
                    if (state is WishListAddedState) {
                      BlocProvider.of<HomeBloc>(context)
                          .add(FetchHomeCourseList());
                      Navigator.pop(context);
                    }
                  },
                  child: BlocBuilder<WishListBloc, WishListState>(
                      builder: (context, state) {
                    return SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.backgroundSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              if (course != null) {
                                late final Map<String, dynamic> courseValues;
                                courseValues = {
                                  'course_id': course.id,
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
                              } else {
                                BlocProvider.of<WishListBloc>(context).add(
                                    WishListAddEvent(
                                        courseId: courseForAddWishlist!.id,
                                        language: selectedLanguage.value!));
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              state is CourseAddingToWishList
                                  ? "Loading..."
                                  : 'Continue',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.whiteColor),
                            )));
                  }),
                ),
                const SizedBox(height: 16),
              ],
            ));
      });
}
