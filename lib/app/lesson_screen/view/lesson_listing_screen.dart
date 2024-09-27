import 'package:flutter/material.dart';
import 'package:tradepro/const/colors.dart';

class ScreenCourseLessonListing extends StatelessWidget {
  const ScreenCourseLessonListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 256,
            width: double.infinity,
            color: AppColors.textFieldBorder,
          ),
          Expanded(
              child:
                  ListView.builder(itemBuilder: (context, index) => Text('hi')))
        ],
      ),
    );
  }
}
