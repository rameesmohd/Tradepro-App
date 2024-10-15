import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tradepro/app/refer_screen/view_model/referal_bloc.dart';
import 'package:tradepro/app/refer_screen/view_model/referal_event.dart';
import 'package:tradepro/app/refer_screen/view_model/referal_state.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

class ReferAndEarnVeiw extends StatelessWidget {
  const ReferAndEarnVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReferalBloc>(context).add(FetchUserReferal());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      backgroundColor: AppColors.blackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Text(
              'Refer friend and earn ₹150',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 28),
            ),
            const SizedBox(height: 29),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 108,
                  width: 143,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/refer_screen_image.png'))),
                ),
                Column(
                  children: [
                    const SizedBox(height: 90),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                      decoration: BoxDecoration(
                          color: AppColors.referAndEarnContainer,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                            'Your Referral Code',
                            style: TextStyle(
                                color: AppColors.referAndEarnGreyText
                                    .withOpacity(.8),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          BlocListener<ReferalBloc, ReferalState>(
                            listener: (context, state) {
                              if (state is ReferalFetchedState) {
                                if (state.message != null) {
                                  HelperFuntions()
                                      .showSnackBar(context, state.message!);
                                }
                              }
                            },
                            child: BlocBuilder<ReferalBloc, ReferalState>(
                                builder: (context, state) {
                              if (state is ReferalFetchedState) {
                                return Text(
                                  state.referalCode,
                                  style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 32),
                                );
                              } else if (state is ReferalLoadingState) {
                                return Shimmer.fromColors(
                                    baseColor: AppColors.textFieldBorder,
                                    highlightColor: Colors.grey[400]!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: 50,
                                      width: 100,
                                    ));
                              } else if (state
                                  is ReferalStateLoadingFailedState) {
                                return Text(state.errorMessage,
                                    style:
                                        const TextStyle(color: Colors.white));
                              } else {
                                return const Text('Something went Wrong',
                                    style: TextStyle(color: Colors.white));
                              }
                            }),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              height: 52,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      backgroundColor: AppColors.whiteColor),
                                  onPressed: () {
                                    BlocProvider.of<ReferalBloc>(context)
                                        .add(ReferalShareEvent());
                                  },
                                  icon: const Icon(
                                    Icons.share_outlined,
                                    color: AppColors.blackColor,
                                  ),
                                  label: const Text('Share code',
                                      style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)))),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: 52,
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      backgroundColor:
                                          AppColors.backgroundSecondaryColor),
                                  onPressed: () {
                                    BlocProvider.of<ReferalBloc>(context)
                                        .add(ReferalCopyEvent());
                                  },
                                  icon: const Icon(
                                    Icons.copy_rounded,
                                    color: AppColors.whiteColor,
                                  ),
                                  label: const Text('Copy code',
                                      style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)))),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            const ReferAndEarnIns(
              value: 1,
              description: 'Send an invite to a friend',
            ),
            const SizedBox(height: 14),
            const ReferAndEarnIns(
              value: 2,
              description: 'Your friend sign up.',
            ),
            const SizedBox(height: 14),
            const ReferAndEarnIns(
              value: 3,
              description:
                  'You’ll both get cash when your friend purchase course',
            ),
          ],
        ),
      ),
    );
  }
}

class ReferAndEarnIns extends StatelessWidget {
  const ReferAndEarnIns({
    super.key,
    required this.value,
    required this.description,
  });
  final int value;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor.withOpacity(.3)),
          child: Text(
            value.toString(),
            style: TextStyle(
                fontFamily: 'Inter',
                color: AppColors.referAndEarnGreyText.withOpacity(.8),
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
                fontFamily: 'Inter',
                color: AppColors.referAndEarnGreyText.withOpacity(.8),
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        )
      ],
    );
  }
}
