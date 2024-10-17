import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/quiz/view/quiz_completeion_success.dart';
import 'package:tradepro/app/quiz/view_model/quiz_bloc.dart';
import 'package:tradepro/app/quiz/view_model/quiz_event.dart';
import 'package:tradepro/app/quiz/view_model/quiz_state.dart';
import 'package:tradepro/const/widget/network_connection_error_widget.dart';

import '../../../const/colors.dart';
import '../../course_detail/model/course_detail_model.dart';
import '../../home/view_model/bloc/home_event.dart';

class ScreenQuizView extends StatefulWidget {
  const ScreenQuizView(
      {super.key,
      required this.quiz,
      required this.nextChapterUrl,
      this.purchasedId});
  final List<Quiz> quiz;
  final String? nextChapterUrl;
  final String? purchasedId;

  @override
  State<ScreenQuizView> createState() => _ScreenQuizViewState();
}

class _ScreenQuizViewState extends State<ScreenQuizView> {
  late final Map<String, int> quizAnswers;
  ValueNotifier<Map<String, int>> quizSelected = ValueNotifier({});
  bool showWrongAnswers = false;

  @override
  void initState() {
    quizAnswers = {};
    int count = 0;
    for (var quizAns in widget.quiz) {
      quizAnswers.addAll({count.toString(): int.parse(quizAns.answer)});
      count++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('quiz ${widget.purchasedId}');
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
              widget.quiz.length,
              (quizIndex) => ValueListenableBuilder(
                  valueListenable: quizSelected,
                  builder: (context, selectedOption, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Question ${quizIndex + 1}:',
                            style: const TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12)),
                        const SizedBox(height: 8),
                        Text(widget.quiz[quizIndex].question,
                            style: const TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        Visibility(
                          visible: showWrongAnswers &&
                              selectedOption[quizIndex.toString()] !=
                                  quizAnswers[quizIndex.toString()],
                          child: const Text(' * Wrong answer',
                              style: TextStyle(
                                  color: AppColors.redColor,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12)),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(
                            widget.quiz[quizIndex].options.length,
                            (optionsIndex) => Row(
                                  children: [
                                    Radio(
                                        value: optionsIndex + 1,
                                        groupValue: selectedOption[
                                            quizIndex.toString()],
                                        onChanged: (value) {
                                          final updatedValues =
                                              Map<String, int>.from(
                                                  selectedOption);
                                          updatedValues[quizIndex.toString()] =
                                              value!; // Update the map with the new value

                                          // Assign the new map to the ValueNotifier to trigger rebuild
                                          quizSelected.value = updatedValues;

                                          // setState(() {
                                          //   showWrongAnswers = false;
                                          // });
                                          // log(quizSelected.value.toString());
                                        }),
                                    Text(
                                      widget.quiz[quizIndex]
                                          .options[optionsIndex],
                                      style: const TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    )
                                  ],
                                )),
                        const Divider()
                      ],
                    );
                  })),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(color: AppColors.whiteColor, boxShadow: [
          BoxShadow(
              blurRadius: 19,
              color: AppColors.blackColor.withOpacity(.11),
              offset: const Offset(0, -3))
        ]),
        child: BlocListener<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuizPassedState) {
              BlocProvider.of<HomeBloc>(context).add(FetchHomeCourseList());
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ScreenQuizResultView(isUserPassed: true)));
            } else if (state is QuizFailedState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ScreenQuizResultView(isUserPassed: false)));
            } else if (state is QuizLoadingFailedState) {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                        decoration: const BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        width: double.infinity,
                        child: NetworkConnectionError(
                          description: state.errorMessage,
                          onTap: () {
                            Navigator.pop(context);
                            BlocProvider.of<QuizBloc>(context).add(
                                QuizSubmitEvent(
                                    purcahseCourseId: widget.purchasedId,
                                    correctQuestionAnswer: quizAnswers,
                                    userEnteredQuestionAnswer:
                                        quizSelected.value,
                                    nextChapterId: widget.nextChapterUrl));
                          },
                        ),
                      ));
            }
          },
          child: SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: AppColors.backgroundSecondaryColor),
                  onPressed: () {
                    // setState(() {
                    //   showWrongAnswers = true;
                    // });
                    BlocProvider.of<QuizBloc>(context).add(QuizSubmitEvent(
                        purcahseCourseId: widget.purchasedId,
                        correctQuestionAnswer: quizAnswers,
                        userEnteredQuestionAnswer: quizSelected.value,
                        nextChapterId: widget.nextChapterUrl));
                  },
                  child: BlocBuilder<QuizBloc, QuizState>(
                      builder: (context, state) {
                    return Text(
                        state is QuizLoadingState ? "Loading..." : 'Submit',
                        style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16));
                  }))),
        ),
      ),
    );
  }
}
