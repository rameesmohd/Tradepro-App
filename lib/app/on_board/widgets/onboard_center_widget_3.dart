import 'package:flutter/material.dart';

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
                            'assets/images/light-glossy-blue-and-simple-wavy-shape-3 2.png'))),
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
                            'assets/images/light-glossy-blue-and-simple-wavy-shape-3 1.png'))),
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
                        image: AssetImage('assets/images/image 31.png'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
