import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/const/colors.dart';

class ScreenQuizResultView extends StatelessWidget {
  const ScreenQuizResultView({super.key, required this.isUserPassed});

  final bool isUserPassed;

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
            SvgPicture.asset(
                height: 295,
                width: 295,
                isUserPassed
                    ? "assets/svg/quiz_pass_image.svg"
                    : "assets/svg/quiz_fale_image.svg",
                semanticsLabel: 'chapter_listing_watchble_leading_icon'),
            const SizedBox(height: 24),
            Text(
              isUserPassed ? 'Congratulations!' : 'Keep Trying',
              style: const TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              isUserPassed
                  ? 'You’ve completed the quiz, and the key to the next video has been unlocked. Keep up the great work!'
                  : 'Not quite there yet, but each attempt brings you closer. Take a breath, and try again—you’ve got this!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.languageBtnBorder,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                if (!isUserPassed) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                isUserPassed ? 'View your Certificate' : 'Go to Course',
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.backgroundSecondaryColor,
                    color: AppColors.backgroundSecondaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
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
                child: Text(isUserPassed ? 'Next Lesson' : 'Try Again',
                    style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16)))),
      ),
    );
  }
}
