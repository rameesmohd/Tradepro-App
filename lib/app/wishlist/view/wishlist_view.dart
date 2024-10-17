import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/wishlist/model/wish_list_model.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_bloc.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_event.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_state.dart';
import 'package:tradepro/const/colors.dart';

import '../../home/view/home_view.dart';
import '../../home/view_model/bloc/home_event.dart';

class ScreenWishListView extends StatefulWidget {
  const ScreenWishListView({super.key});

  @override
  State<ScreenWishListView> createState() => _ScreenWishListViewState();
}

class _ScreenWishListViewState extends State<ScreenWishListView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishListBloc>(context).add(FetchWishList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishListBloc, WishListState>(
      builder: (context, state) {
        if (state is WishListCoursesLoadingState ||
            state is WishListStateInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WishListEmptyState) {
          return const WishListEmptyWidget();
        } else if (state is CourseRemovingWishList) {
          return WishListHaveItems(
              courses: state.wishList, deletingCourseId: state.courseId);
        } else if (state is WishListFetchedState) {
          return WishListHaveItems(courses: state.wishList);
        } else if (state is WishListLoadingFailedState) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}

class WishListHaveItems extends StatelessWidget {
  const WishListHaveItems({
    super.key,
    required this.courses,
    this.deletingCourseId,
  });

  final List<WishListCourses> courses;
  final String? deletingCourseId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: courses.length,
        separatorBuilder: (context, index) => const Divider(height: 40),
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 75,
                  decoration: BoxDecoration(
                      color: AppColors.textFieldBorder,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.blackColor),
                              text: '${courses[index].course.title} ',
                              children: [
                            TextSpan(
                                text: '(${courses[index].language})',
                                style: const TextStyle(
                                    color: AppColors.totalTeamText))
                          ])),
                      const SizedBox(height: 4),
                      Text(courses[index].course.author,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 10)),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Text('4.8',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: AppColors.ratingStarColor)),
                          SizedBox(width: 4),
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 14,
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.ratingStarColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '(1,454)',
                            style: TextStyle(
                                color: AppColors.blackColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      AvailableLanguagesSmallCard(
                          availableLanguages: [(courses[index].language)],
                          textColor: AppColors.languageText,
                          backGroundColor: AppColors.languageBackground),
                      const SizedBox(height: 4),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                              text: '₹${courses[index].course.price} ',
                              children: const [
                            // TextSpan(
                            //     text: '₹42000',
                            //     style: TextStyle(
                            //         decoration: TextDecoration.lineThrough,
                            //         fontWeight: FontWeight.w300,
                            //         fontSize: 16,
                            //         color: AppColors.linedOriginalPrice))
                          ])),
                      const SizedBox(height: 12),
                      deletingCourseId != courses[index].course.id
                          ? BlocListener<WishListBloc, WishListState>(
                              listener: (context, state) {
                                if (state is WishListFetchedState ||
                                    state is WishListEmptyState) {
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(FetchHomeCourseList());
                                }
                              },
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<WishListBloc>(context).add(
                                      WishListRemoveEvent(
                                          courseId: courses[index].course.id,
                                          wishListId: courses[index].id));
                                },
                                child: const Text('Remove from Wishlist',
                                    style: TextStyle(
                                        decorationColor:
                                            AppColors.backgroundSecondaryColor,
                                        decoration: TextDecoration.underline,
                                        color:
                                            AppColors.backgroundSecondaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                              ),
                            )
                          : const CircularProgressIndicator()
                    ],
                  ),
                )
              ],
            ));
  }
}

class WishListEmptyWidget extends StatelessWidget {
  const WishListEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
            height: 294,
            width: 294,
            "assets/svg/wishlist_empty_image.svg",
            semanticsLabel: 'wishlist_empty_image'),
        const SizedBox(height: 32),
        const Text(
          'Your Wishlist is Empty',
          style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 24),
        )
      ],
    );
  }
}
