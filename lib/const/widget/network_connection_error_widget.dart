import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';

class NetworkConnectionError extends StatelessWidget {
  const NetworkConnectionError(
      {super.key, this.onTap, required this.description});
  final void Function()? onTap;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              height: 295,
              width: 295,
              "assets/svg/network_lost_image.svg",
              semanticsLabel: 'network_lost_image'),
          const SizedBox(height: 24),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.languageBtnBorder,
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: onTap,
            child: const Text(
              'Retry',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.backgroundSecondaryColor,
                  color: AppColors.backgroundSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
