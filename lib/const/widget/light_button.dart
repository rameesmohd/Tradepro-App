import 'package:flutter/material.dart';

import '../colors.dart';

class AppLightButton extends StatelessWidget {
  const AppLightButton({
    super.key,
    this.buttonHeight = 52,
    this.width = double.infinity,
    required this.title,
    this.ontap,
    required this.padding,
  });

  final double? buttonHeight;
  final double? width;
  final String title;
  final void Function()? ontap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: buttonHeight,
        child: Padding(
          padding: padding,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              onPressed: ontap,
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.blackColor),
              )),
        ));
  }
}
