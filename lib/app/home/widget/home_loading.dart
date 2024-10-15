import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../const/colors.dart';
import '../view/home_view.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: AppColors.textFieldBorder,
          highlightColor: Colors.grey[400]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 25),
                Container(
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
                                    image: AssetImage(
                                        'assets/images/home_star.png'))),
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
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // show video thumbnail here
                      Container(
                        alignment: Alignment.center,
                        height: 196,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.textFieldBorder,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 150,
                        height: 20,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 8),
                      const AvailableLanguagesSmallCard(
                          availableLanguages: [
                            '           ',
                            '                ',
                            '                      '
                          ],
                          textColor: AppColors.backgroundSecondaryColor,
                          backGroundColor: AppColors.verifyYourPhone),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user_in_videocard.png')),
                                color: AppColors.backgroundSecondaryColor,
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 100,
                            height: 20,
                            color: AppColors.blackColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 150,
                        height: 30,
                        color: AppColors.blackColor,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // show video thumbnail here
                      Container(
                        alignment: Alignment.center,
                        height: 196,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.textFieldBorder,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 150,
                        height: 20,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 8),
                      const AvailableLanguagesSmallCard(
                          availableLanguages: [
                            '           ',
                            '                ',
                            '                      '
                          ],
                          textColor: AppColors.backgroundSecondaryColor,
                          backGroundColor: AppColors.verifyYourPhone),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/user_in_videocard.png')),
                                color: AppColors.backgroundSecondaryColor,
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 100,
                            height: 20,
                            color: AppColors.blackColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 150,
                        height: 30,
                        color: AppColors.blackColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
