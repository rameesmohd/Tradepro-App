import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

import '../../home/view/home_view.dart';

class ScreenWishListView extends StatelessWidget {
  const ScreenWishListView({super.key});

  static const int itemcount = 0;

  @override
  Widget build(BuildContext context) {
    return itemcount == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 298,
                height: 298,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/wish_list_empty.png'))),
              ),
              const SizedBox(height: 32),
              const Text(
                'Your Wishlist is Empty',
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              )
            ],
          )
        : ListView.separated(
            itemCount: itemcount,
            separatorBuilder: (context, index) => const Divider(height: 40),
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 44,
                      width: 75,
                      decoration: BoxDecoration(
                          color: AppColors.textFieldBorder,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.blackColor),
                                  text:
                                      'Master the Stock Market: Complete Trading Course ',
                                  children: [
                                TextSpan(
                                    text: '(English)',
                                    style: TextStyle(
                                        color: AppColors.totalTeamText))
                              ])),
                          const SizedBox(height: 4),
                          const Text('Jos Brown',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10)),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Text('4.8',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: AppColors.ratingStarColor)),
                              SizedBox(width: 4),
                              Icon(
                                Icons.star,
                                color: AppColors.ratingStarColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.ratingStarColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.ratingStarColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.ratingStarColor,
                                size: 14,
                              ),
                              Icon(
                                Icons.star,
                                color: AppColors.ratingStarColor,
                                size: 14,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '(1,454)',
                                style: TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          const AvailableLanguagesSmallCard(
                              availableLanguages: ['English'],
                              textColor: AppColors.languageText,
                              backGroundColor: AppColors.languageBackground),
                          const SizedBox(height: 4),
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                  text: '₹35000 ',
                                  children: [
                                TextSpan(
                                    text: '₹42000',
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                        color: AppColors.linedOriginalPrice))
                              ])),
                          const SizedBox(height: 12),
                          const Text('Remove from Wishlist',
                              style: TextStyle(
                                  decorationColor:
                                      AppColors.backgroundSecondaryColor,
                                  decoration: TextDecoration.underline,
                                  color: AppColors.backgroundSecondaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ));
  }
}
