import 'package:flutter/material.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';

import '../../course_detail/view/course_detail_view.dart';

class ScreenCeckoutView extends StatelessWidget {
  const ScreenCeckoutView({super.key});

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
          const Text('₹35000 ',
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 32)),
          const SizedBox(height: 8),
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
          const SizedBox(height: 12),
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
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                        child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            'Master the Stock Market: Complete Trading Course',
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20))),
                  ],
                ),
                const SizedBox(height: 12),
                const AvailableLanguagesSmallCard(
                    availableLanguages: ['English'],
                    backGroundColor: AppColors.languageBackground,
                    textColor: AppColors.languageText),
                const SizedBox(height: 12),
                const RatingBarWithUserName(),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    PublishedEncounterCard(
                      isBackGroundColorBlue: true,
                      icon: Icons.calendar_month_outlined,
                      title: 'Published',
                      subString: '18 March 2024',
                    ),
                    SizedBox(width: 12),
                    PublishedEncounterCard(
                      isBackGroundColorBlue: true,
                      icon: Icons.people_outline,
                      title: 'Enrolled',
                      subString: '1,078 people',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const CourseInclude(),
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
            const Text('₹35000',
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24)),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: AppColors.backgroundSecondaryColor),
                  onPressed: () {},
                  child: const Text('Checkout',
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16))),
            )
          ],
        ),
      ),
    );
  }
}
