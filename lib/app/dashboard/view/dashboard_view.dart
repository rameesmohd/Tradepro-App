import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/app/dashboard/model/dashboard_repo.dart';
import 'package:tradepro/app/dashboard/view/dashboard_loading_view.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_event.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_state.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/widget/network_connection_error_widget.dart';

import '../view_model/dashboard_bloc.dart';

class ScreenDashboardView extends StatelessWidget {
  const ScreenDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashBoardState>(
        builder: (context, state) {
      if (state is DashBoardDetailSuccesState) {
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
                  Text('₹${state.dashboardDetails?.data?.totalIncome ?? 0}',
                      style: const TextStyle(
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
                        onPressed: () async {
                          final hey = await DashboardRepo().fetchDashBoard();
                          log(hey?.data?.totalIncome.toString() ?? 'nulll');
                        },
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
                  SvgPicture.asset(
                      height: 40,
                      width: 40,
                      "assets/svg/dashboard_people_image.svg",
                      semanticsLabel: 'dashboard_people_image'),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total team members',
                        style: TextStyle(
                            color: AppColors.totalTeamText,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      Text(
                          '${state.dashboardDetails?.data?.totalTeamMembers.length ?? 0}',
                          style: const TextStyle(
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
                              const Text(
                                'Active Users',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColors.greenColor),
                              )
                            ],
                          ),
                          Text(
                              '${state.dashboardDetails?.data?.activeUsers.length ?? 0}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.blackColor))
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
                              const Text(
                                'Inactive User',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColors.redColor),
                              )
                            ],
                          ),
                          Text(
                              '${state.dashboardDetails?.data?.inActiveUsers.length ?? 0}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.blackColor))
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(state.dashboardDetails?.data?.levels.length ?? 0,
                (index) {
              final levelDetails = state.dashboardDetails?.data?.levels[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DashboardLevelCards(
                  backgroundColor: index == 0
                      ? AppColors.backgroundSecondaryColor
                      : AppColors.dashboardLevelCardBlue,
                  income: '₹${levelDetails?.levelIncome ?? 0}',
                  refferals: '${levelDetails?.totalReferrals.length ?? 0}',
                  progress: 95,
                  level: levelDetails?.levelName ?? 'Name',
                  visible: levelDetails?.visibility ?? false,
                ),
              );
            })
          ],
        );
      } else if (state is DashBoardLoadingState) {
        return const DashboardLoadingView();
      } else if (state is DashboardLoadingFailed) {
        return NetworkConnectionError(
            description: state.errorMessage,
            onTap: () {
              BlocProvider.of<DashboardBloc>(context)
                  .add(DashboardFetchEvent());
            });
      } else {
        return const Center(child: Text('Something went wrong'));
      }
    });
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
    required this.visible,
  });
  final String level;
  final String income;
  final String refferals;
  final int progress;
  final Color backgroundColor;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: backgroundColor),
      child: Stack(
        children: [
          Positioned(
            right: -120,
            top: -50,
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
                Text(level,
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
                        text: '$level Income: ',
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
                // const SizedBox(height: 8),
                // ProgressBar(
                //   progress: progress,
                //   title: 'Progress',
                // ),
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
          ),
          if (!visible)
            Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.backgroundSecondaryColor,
                              borderRadius: BorderRadius.circular(16)),
                          height: 52,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.lock,
                                size: 20,
                                color: AppColors.whiteColor,
                              ),
                              SizedBox(width: 2),
                              Text('Locked',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppColors.whiteColor))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
