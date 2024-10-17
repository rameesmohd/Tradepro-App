import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../const/colors.dart';

class DashboardLoadingView extends StatelessWidget {
  const DashboardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColors.textFieldBorder,
        highlightColor: Colors.grey[400]!,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.textFieldBorder)),
              width: double.infinity,
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 100, height: 20, color: Colors.black),
                  const SizedBox(height: 8),
                  Container(width: 150, height: 50, color: Colors.black),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundSecondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () async {},
                        child: const Text(
                          ' ',
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.textFieldBorder)),
              width: double.infinity,
              height: 95,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 120, height: 20, color: Colors.black),
                      Container(width: 70, height: 40, color: Colors.black),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.textFieldBorder)),
                      width: double.infinity,
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 7.3,
                                width: 7.3,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.greenColor),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                  width: 70, height: 15, color: Colors.black),
                            ],
                          ),
                          Container(width: 70, height: 25, color: Colors.black),
                        ],
                      )),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.textFieldBorder)),
                      width: double.infinity,
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 7.3,
                                width: 7.3,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.redColor),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                  width: 70, height: 15, color: Colors.black),
                            ],
                          ),
                          Container(width: 70, height: 25, color: Colors.black),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(2, (index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    width: double.infinity,
                    height: 260,
                    color: AppColors.blackColor,
                  ));
            })
          ],
        ));
  }
}
