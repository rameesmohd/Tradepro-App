import 'package:flutter/material.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';

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
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(15),
            shrinkWrap: true,
            children: [
              const ThumbnailCard(showPreview: true),
              const SizedBox(height: 15),
              const Text(
                'Master the Stock Market: Complete Trading Course ',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.blackColor),
              ),
              const SizedBox(height: 8),
              AvailableLanguagesSmallCard(
                  availableLanguages: availableLanguages,
                  backGroundColor: AppColors.verifyYourPhone.withOpacity(.1),
                  textColor: AppColors.backgroundSecondaryColor),
              const SizedBox(height: 8),
              const RatingBarWithUserName(),
              const SizedBox(height: 16),
              const Row(
                children: [
                  PublishedEncounterCard(
                    icon: Icons.calendar_month_outlined,
                    title: 'Published',
                    subString: '18 March 2024',
                  ),
                  SizedBox(width: 12),
                  PublishedEncounterCard(
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
              const Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 12),
                  Text(
                    '24.6 total hours included',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(
                    Icons.edit_note,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 12),
                  Text(
                    '8 Quiz',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.blackColor),
                  )
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(
                    Icons.video_collection_outlined,
                    color: AppColors.blackColor,
                  ),
                  SizedBox(width: 12),
                  Text(
                    '20 Videos',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.blackColor),
                  )
                ],
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
              const Text(
                'In this video series, you’ll start by learning the basics of stock trading, including how to buy and sell stocks, read charts, and place market orders. You’ll then explore various investment strategies, such as value and growth investing, to build a strong portfolio. Next, you’ll dive into technical analysis, mastering the use of charts and indicators to predict stock movements. You’ll also gain insights into fundamental analysis, evaluating company financials and economic indicators to make informed decisions. Additionally, you’ll learn essential risk management techniques like diversification and stop-loss orders, and get introduced to advanced trading instruments such as options and derivatives.',
                style: TextStyle(
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
                            backgroundColor: AppColors.backgroundSecondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {},
                        child: const Text(
                          'Purchase',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.whiteColor),
                        ))),
              ))
        ],
      ),
    );
  }
}

class PublishedEncounterCard extends StatelessWidget {
  const PublishedEncounterCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subString,
  });
  final IconData icon;
  final String title;
  final String subString;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        height: 67,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: AppColors.backgroundSecondaryColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.blackColor),
                ),
                Text(
                  subString,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.videoCardUserNameColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}