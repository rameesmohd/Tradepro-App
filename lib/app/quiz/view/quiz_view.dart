import 'package:flutter/material.dart';

import '../../../const/colors.dart';
import '../../course_detail/model/course_detail_model.dart';

class ScreenQuizView extends StatelessWidget {
  const ScreenQuizView({super.key, required this.quiz});
  final List<Quiz> quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Test Your Knowledge',
          style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.quizReminderBrdr),
                borderRadius: BorderRadius.circular(9)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AppColors.linedOriginalPrice,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    text: 'Reminder :',
                    children: [
                  TextSpan(
                      style: TextStyle(
                          color: AppColors.linedOriginalPrice,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      text:
                          ' Remember, you need to answer 3 questions correctly to jump to the next video!')
                ])),
          ),
          const SizedBox(height: 16),
          ...List.generate(
              quiz.length,
              (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Question 1:',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12)),
                      const SizedBox(height: 8),
                      const Text(
                          'What does the term “IPO” stand for in the stock market?',
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Radio(
                              value: '', groupValue: '', onChanged: (value) {}),
                          const Text(
                            '8 Assignments',
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )
                        ],
                      ),
                      const Divider()
                    ],
                  )),
        ],
      ),
    );
  }
}
