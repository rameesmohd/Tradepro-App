import 'package:flutter/material.dart';
import 'package:tradepro/app/auth/registration/view/register_view.dart';

import '../../../../const/colors.dart';

class ScreenForgetView extends StatelessWidget {
  const ScreenForgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        AppColors.whiteColor,
                        AppColors.backgroundSecondaryColor
                      ])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text('Enter your Phone\nNumber',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor)),
                    const SizedBox(height: 8),
                    const Text('Enter your credentials to access your account',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.regSubtitle)),
                    const SizedBox(height: 25),
                    const PhoneField(),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.backgroundSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              showOTPBottomSheet(context);
                            },
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.whiteColor),
                            ))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
