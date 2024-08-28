import 'package:flutter/material.dart';

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
                        image: AssetImage('assets/images/image 24.png'))),
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
                        image: AssetImage('assets/images/image 25.png'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
