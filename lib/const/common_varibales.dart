import 'package:flutter/material.dart';

import '../app/on_board/model/onboard_content_model.dart';
import '../app/on_board/view/onboard_view.dart';

class CommonVariables {
  // Onboard screens

  // OnBoarding content list
  final List<OnBoard> onBoardScreenData = [
    OnBoard(
      centreWidget: const OnBoardScreenCentreWidget1(),
      description: "Build Your Wealth with Knowledge.",
    ),
    OnBoard(
      centreWidget: const OnBoardScreenCentreWidget2(),
      description: "Courses available in 4 languages.",
    ),
    OnBoard(
      centreWidget: const OnBoardScreenCentreWidget3(),
      description: "Start Your Financial Journey.",
    ),
  ];
}
