import 'package:flutter/material.dart';

import 'onboard_langauge_with_radio.dart';

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
                        image: AssetImage('assets/images/image 24-1.png'))),
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
