import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/app/on_board/widgets/onboard_helper.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/common_varibales.dart';

import '../model/onboard_content_model.dart';

class ScreenOnBoardView extends StatelessWidget {
  const ScreenOnBoardView({super.key});

  static final PageController _pageController = PageController();

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
                        // setState(() {
                        //   _pageIndex = index;
                        // });
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                        CommonVariables().onBoardScreenData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: DotIndicator(
                            isActive: index == 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardScreenCentreWidget3 extends StatelessWidget {
  const OnBoardScreenCentreWidget3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        height: 450,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: Container(
                width: 103,
                height: 103,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/something/light-glossy-blue-and-simple-wavy-shape-3 2.png'))),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/something/light-glossy-blue-and-simple-wavy-shape-3 1.png'))),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 221,
                height: 303,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/something/image 31.png'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardScreenCentreWidget2 extends StatelessWidget {
  const OnBoardScreenCentreWidget2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 350,
        width: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 226,
                height: 267,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/something/image 24-1.png'))),
              ),
            ),
            const Positioned(
              bottom: 20,
              right: 0,
              child: Column(
                children: [
                  OnBoardLanguageRadio(title: 'English', opacity: 1),
                  SizedBox(height: 5),
                  OnBoardLanguageRadio(title: 'Malayalam', opacity: .8),
                  SizedBox(height: 5),
                  OnBoardLanguageRadio(title: 'Hindi', opacity: .6),
                  SizedBox(height: 5),
                  OnBoardLanguageRadio(title: 'Tamil', opacity: .4),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardLanguageRadio extends StatelessWidget {
  const OnBoardLanguageRadio({
    super.key,
    required this.title,
    required this.opacity,
  });
  final String title;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 140,
        height: 38,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
                fillColor:
                    WidgetStateColor.resolveWith((states) => Colors.green),
                value: 'English',
                groupValue: title,
                onChanged: (va) {}),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}

class OnBoardScreenCentreWidget1 extends StatelessWidget {
  const OnBoardScreenCentreWidget1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 320,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                // color: Colors.black,
                height: 216,
                width: 158,

                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/something/image 24.png'))),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                // color: Colors.black,
                height: 196,
                width: 171,

                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/something/image 25.png'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
