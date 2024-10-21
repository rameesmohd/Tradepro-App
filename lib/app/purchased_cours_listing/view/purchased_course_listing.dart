import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_state.dart';

import '../../../const/colors.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../home/view/home_view.dart';
import '../../lesson_screen/view/lesson_listing_screen.dart';

class PurchasedCourseListingView extends StatelessWidget {
  const PurchasedCourseListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeCoursesFetchedState) {
        return state.purcahseCourses.isNotEmpty
            ? ListView(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Continue Watching:',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                ),
                const SizedBox(height: 15),
                ...List.generate(
                  state.purcahseCourses.length,
                  (index) {
                    final course = state.purcahseCourses[index];
                    int totalChapters = course.totalChapters ?? 0;
                    int playedChapters = course.isPlayedChapters?.length ?? 0;
                    double progressPercentage = (totalChapters > 0)
                        ? ((playedChapters / totalChapters) * 100)
                        : 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ScreenCourseLessonListing(
                                          vachableChapter:
                                              course!.isPlayedChapters,
                                          purcahseCourseId: course.id!,
                                          courseId: course.courseModel!.id)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundSecondaryColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // show video thumbnail here
                              Container(
                                alignment: Alignment.center,
                                height: 196,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.backgroundSecondaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: SamplePlayer(
                                    videoUrl:
                                        course.courseModel?.previewVideo ?? ''),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${course.courseModel?.title ?? 'Title'} (${course.courseModel?.courseType ?? ''})',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.whiteColor),
                              ),
                              const SizedBox(height: 8),
                              if (course.language != null)
                                AvailableLanguagesSmallCard(
                                    availableLanguages: [course!.language],
                                    textColor: AppColors.languageText,
                                    backGroundColor:
                                        AppColors.languageBackground),
                              const SizedBox(height: 8),
                              RatingBarWithUserName(
                                showRatingCount: false,
                                userName:
                                    course.courseModel?.author ?? 'Author',
                                color: AppColors.whiteColor,
                              ),
                              const SizedBox(height: 12),
                              const Divider(color: AppColors.purchasedDivider),
                              const SizedBox(height: 12),
                              if (course != null)
                                ProgressBar(
                                    progress: progressPercentage.round(),
                                    title: 'Progress')
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ])
            : const Center(
                child: Text('Empty'),
              );
      } else if (state is HomeStateCoursesLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return const Text('error');
      }
    });
  }
}
