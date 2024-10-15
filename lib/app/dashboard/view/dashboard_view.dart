import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

class ScreenDashboardView extends StatelessWidget {
  const ScreenDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              const Text('Total Income',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
              const Text('₹38,000',
                  style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 40)),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundSecondaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {},
                    child: const Text(
                      'View Details',
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
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/people_icon.png'))),
              ),
              const SizedBox(width: 24),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total team members',
                    style: TextStyle(
                        color: AppColors.totalTeamText,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text('320',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: AppColors.blackColor))
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          const Text(
                            'Active Users',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.greenColor),
                          )
                        ],
                      ),
                      const Text('120',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.blackColor))
                    ],
                  )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                          const Text(
                            'Inactive User',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.redColor),
                          )
                        ],
                      ),
                      const Text('200',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.blackColor))
                    ],
                  )),
            )
          ],
        ),
        const SizedBox(height: 12),
        const DashboardLevelCards(
          backgroundColor: AppColors.backgroundSecondaryColor,
          income: '₹35000',
          refferals: '300',
          progress: 95,
          level: '1',
        ),
        const SizedBox(height: 12),
        const DashboardLevelCards(
          backgroundColor: AppColors.dashboardLevelCardBlue,
          income: '₹3000',
          refferals: '20',
          progress: 5,
          level: '2',
        )
      ],
    );
  }
}

class DashboardLevelCards extends StatelessWidget {
  const DashboardLevelCards({
    super.key,
    required this.level,
    required this.income,
    required this.refferals,
    required this.progress,
    required this.backgroundColor,
  });
  final String level;
  final String income;
  final String refferals;
  final int progress;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Stack(
        children: [
          Positioned(
            right: -125,
            top: -60,
            child: Container(
              padding: const EdgeInsets.all(40),
              width: 221,
              height: 221,
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.whiteColor.withOpacity(.13), width: 40),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Level $level',
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 36)),
                const SizedBox(height: 12),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        text: 'Level $level Income: ',
                        children: [
                      TextSpan(
                          text: income,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20))
                    ])),
                const SizedBox(height: 8),
                Text('$refferals Total Referrals',
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14)),
                const SizedBox(height: 8),
                ProgressBar(
                  progress: progress,
                  title: 'Progress',
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      onPressed: () {},
                      child: const Text('View Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: AppColors.blackColor))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.progress,
    required this.title,
  });

  final String title;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            Text('$progress%',
                style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ],
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          minHeight: 9,
          borderRadius: BorderRadius.circular(10),
          value: progress / 100,
          color: AppColors.whiteColor,
          backgroundColor: AppColors.whiteColor.withOpacity(.13),
        ),
      ],
    );
  }
}
