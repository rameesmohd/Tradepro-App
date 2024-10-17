import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../const/colors.dart';
import 'lesson_listing_screen.dart';

class LessonListingLoading extends StatelessWidget {
  const LessonListingLoading({super.key, this.showUnloackMessage = false});

  final bool showUnloackMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
            baseColor: AppColors.textFieldBorder,
            highlightColor: Colors.grey[400]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 256,
                  color: AppColors.blackColor,
                ),
                Expanded(
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          height: 30,
                          width: 100,
                          color: AppColors.blackColor,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 20,
                          width: 100,
                          color: AppColors.blackColor,
                        ),
                        const SizedBox(height: 12),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(2, (lessonIndex) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 100,
                                        color: AppColors.blackColor,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 100,
                                        color: AppColors.blackColor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Column(
                                    children: List.generate(
                                      5,
                                      (chapterIndex) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Row(children: [
                                            const LockedLeadingCircle(),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 100,
                                                  color: AppColors.blackColor,
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  height: 10,
                                                  width: 70,
                                                  color: AppColors.blackColor,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const LockedButtonWidget()
                                          ]),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 100,
                                          color: AppColors.blackColor,
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Row(children: [
                                            const LockedLeadingCircle(),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 100,
                                                  color: AppColors.blackColor,
                                                ),
                                                const SizedBox(height: 8),
                                                Container(
                                                  height: 10,
                                                  width: 70,
                                                  color: AppColors.blackColor,
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const LockedButtonWidget()
                                          ]),
                                        ),
                                        const SizedBox(height: 8)
                                      ])
                                ],
                              );
                            }))
                      ]),
                ),
              ],
            )),
        if (showUnloackMessage)
          const Center(
            child: Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('Unlocking next chapter'),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
