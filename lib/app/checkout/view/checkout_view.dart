import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/checkout/view_model/checkout_bloc.dart';
import 'package:tradepro/app/checkout/view_model/checkout_event.dart';
import 'package:tradepro/app/checkout/view_model/checkout_state.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/app/main/view/screen_main_view.dart';
import 'package:tradepro/const/colors.dart';

import '../../course_detail/view/course_detail_view.dart';

class ScreenCeckoutView extends StatelessWidget {
  const ScreenCeckoutView({super.key, required this.checkoutCourse});
  final Map<String, dynamic> checkoutCourse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          // leading: const Icon(
          //   Icons.arrow_back,
          //   color: AppColors.blackColor,
          // ),
          title: const Text(
            "Checkout",
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          const Text('Total Amount:',
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20)),
          const SizedBox(height: 12),
          Text(checkoutCourse['amount'] ?? '0',
              style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 32)),
          const SizedBox(height: 8),
          if (checkoutCourse['saved'] != null)
            RichText(
                text: const TextSpan(
                    style: TextStyle(
                        color: AppColors.verifyYourPhone,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    text: 'Saved ',
                    children: [
                  TextSpan(
                      text: '₹7000',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14))
                ])),
          if (checkoutCourse['saved'] != null) const SizedBox(height: 12),
          const Text('Course Overview'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.alreadyHave),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 96,
                      height: 56,
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBorder,
                          borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: checkoutCourse['url'] != null
                            ? VideoPlayerWidget(
                                videoUrl: checkoutCourse['url'],
                                showButton: false)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            checkoutCourse['title'],
                            style: const TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20))),
                  ],
                ),
                const SizedBox(height: 12),
                AvailableLanguagesSmallCard(
                    availableLanguages: [checkoutCourse['language']],
                    backGroundColor: AppColors.languageBackground,
                    textColor: AppColors.languageText),
                const SizedBox(height: 12),
                RatingBarWithUserName(userName: checkoutCourse['auther']),
                const SizedBox(height: 16),
                Row(
                  children: [
                    PublishedEncounterCard(
                      isBackGroundColorBlue: true,
                      icon: Icons.calendar_month_outlined,
                      title: 'Published',
                      subString: checkoutCourse['published'],
                    ),
                    const SizedBox(width: 12),
                    const PublishedEncounterCard(
                      isBackGroundColorBlue: true,
                      icon: Icons.people_outline,
                      title: 'Enrolled',
                      subString: '1,078 people',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                CourseInclude(
                  courseHour: checkoutCourse['video_hours'],
                  quizCount: checkoutCourse['quiz_count'],
                  videoCount: checkoutCourse['video_count'],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 19,
                blurStyle: BlurStyle.outer,
                color: AppColors.blackColor.withOpacity(.11))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Total Pricing:',
                style: TextStyle(
                    color: AppColors.linedOriginalPrice,
                    fontWeight: FontWeight.w300,
                    fontSize: 12)),
            const SizedBox(height: 4),
            Text(checkoutCourse['amount'],
                style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24)),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: BlocListener<CheckoutBloc, CheckoutState>(
                listener: (context, state) {
                  if (state is CheckoutSuccessState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenMainView()),
                        (route) => false);
                  }
                },
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          backgroundColor: AppColors.backgroundSecondaryColor),
                      onPressed: () {
                        if (state is! CheckoutLoadingState) {
                          BlocProvider.of<CheckoutBloc>(context)
                              .add(SubmitCourseCheckout(checkoutCourseDetails: {
                            "language": checkoutCourse['language'],
                            "courseId": checkoutCourse['course_id'],
                          }));
                        }
                      },
                      child: Text(
                          state is CheckoutLoadingState
                              ? 'Loading'
                              : state is CheckoutStateLoadingFailedState
                                  ? 'Failed'
                                  : 'Checkout',
                          style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)));
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
