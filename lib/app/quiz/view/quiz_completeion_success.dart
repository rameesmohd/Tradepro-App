import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

class ScreenQuizSuccessView extends StatelessWidget {
  const ScreenQuizSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: const Text('Result',
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 295,
              width: 295,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/balloon-out-of-the-box.png'))),
            ),
            const SizedBox(height: 24),
            const Text(
              'Congratulations!',
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'You’ve completed the quiz, and the key to the next video has been unlocked. Keep up the great work!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.languageBtnBorder,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'View your Certificate',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.backgroundSecondaryColor,
                  color: AppColors.backgroundSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(color: AppColors.whiteColor, boxShadow: [
          BoxShadow(
              blurRadius: 19,
              color: AppColors.blackColor.withOpacity(.11),
              offset: const Offset(0, -3))
        ]),
        child: SizedBox(
            height: 52,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.backgroundSecondaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Next Lesson',
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)))),
      ),
    );
  }
}
