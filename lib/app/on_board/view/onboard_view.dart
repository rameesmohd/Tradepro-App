import 'package:flutter/material.dart';
import 'package:tradepro/app/auth/registration/view/register_view.dart';
import 'package:tradepro/app/on_board/widgets/onboard_content_widget.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/common_varibales.dart';

import '../../../const/widget/already_doesnt_have_n_didnt_get.dart';
import '../../../const/widget/light_button.dart';
import '../widgets/onboard_dot_widget.dart';

class ScreenOnBoardView extends StatelessWidget {
  const ScreenOnBoardView({super.key});

  static final PageController _pageController = PageController();
  static final ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondaryColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: -200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.2),
                        shape: BoxShape.circle),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    height: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                        color: AppColors.backgroundSecondaryColor,
                        shape: BoxShape.circle),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      onPageChanged: (index) {
                        currentPageIndex.value = index;
                      },
                      itemCount: CommonVariables().onBoardScreenData.length,
                      controller: _pageController,
                      itemBuilder: (context, index) => OnBoardContent(
                          centreWidget: CommonVariables()
                              .onBoardScreenData[index]
                              .centreWidget,
                          description: CommonVariables()
                              .onBoardScreenData[index]
                              .description)),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        CommonVariables().onBoardScreenData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: ValueListenableBuilder(
                              valueListenable: currentPageIndex,
                              builder: (context, value, child) {
                                return DotIndicator(
                                  isActive: index == value,
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                AppLightButton(
                  ontap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenRegisterVeiw()));
                  },
                  title: 'Get Started',
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                const SizedBox(height: 15),
                const SwitchLoginRegister(),
                const SizedBox(height: 25)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
