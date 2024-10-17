import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/certificates/view/certificates_view.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_bloc.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_event.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../dashboard/view/dashboard_view.dart';
import '../../home/view_model/bloc/home_bloc.dart';
import '../../home/view_model/bloc/home_event.dart';
import '../../settings/view/settings_view.dart';
import '../../splash/view_model/bloc/splash_bloc.dart';
import '../../splash/view_model/bloc/splash_state.dart';
import '../../wishlist/view/wishlist_view.dart';

class ScreenMainView extends StatefulWidget {
  const ScreenMainView({super.key});

  @override
  ScreenMainViewState createState() => ScreenMainViewState();
}

class ScreenMainViewState extends State<ScreenMainView> {
  int pageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final pages = [
    const ScreenHomeView(),
    const ScreenDashboardView(),
    const ScreenWishListView(),
    const ScreenCirtificatesView(),
    const ScreenSettingsView()
  ];

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchHomeCourseList());
    BlocProvider.of<DashboardBloc>(context).add(DashboardFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageIndex == 0
          ? PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          height: 44,
                          width: 44,
                          "assets/svg/home_app_bar_user_default.svg",
                          semanticsLabel: 'home_app_bar_user_default'),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Good Morning,',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.goodMorningGrey),
                          ),
                          const SizedBox(height: 5),
                          BlocBuilder<SplashBloc, SplashState>(
                              builder: (context, state) {
                            if (state is UserLoginState) {
                              return Text(
                                state.userDetails.name ?? 'User name',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500),
                              );
                            } else {
                              return const Text(
                                'Unknown User',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500),
                              );
                            }
                          }),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          SvgPicture.asset(
                              height: 24,
                              width: 24,
                              "assets/svg/home_wallet_icon.svg",
                              semanticsLabel: 'home_wallet_icon'),
                          const SizedBox(width: 15),
                          SvgPicture.asset(
                              height: 24,
                              width: 24,
                              "assets/svg/home_notification_icon.svg",
                              semanticsLabel: 'home_notification_icon'),
                        ],
                      )
                    ],
                  ),
                ),
              ))
          : AppBar(
              backgroundColor: AppColors.backgroundPrimaryColor,
              leading: const Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
              ),
              title: Text(
                pageIndex == 1
                    ? "Dashboard"
                    : pageIndex == 2
                        ? "Wishlist"
                        : pageIndex == 3
                            ? "Certificates"
                            : "Settings",
                style: const TextStyle(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              centerTitle: true),
      backgroundColor: AppColors.backgroundPrimaryColor,
      bottomNavigationBar: Container(
        height: 72,
        decoration: const BoxDecoration(
          color: AppColors.bottomNavigationColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                        color: pageIndex == 0
                            ? AppColors.whiteColor
                            : AppColors.languageBtnBorder,
                        "assets/svg/home_bottom_nav_button.svg",
                        semanticsLabel: 'home_logo_bottom_nav')),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                        color: pageIndex == 1
                            ? AppColors.whiteColor
                            : AppColors.languageBtnBorder,
                        "assets/svg/dashboard_bottom_nav_button.svg",
                        semanticsLabel: 'dash_logo_bottom_nav')),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                        color: pageIndex == 2
                            ? AppColors.whiteColor
                            : AppColors.languageBtnBorder,
                        "assets/svg/wishlist_bottom_nav_button.svg",
                        semanticsLabel: 'wish_logo_bottom_nav')),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                  });
                  _pageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                        color: pageIndex == 3
                            ? AppColors.whiteColor
                            : AppColors.languageBtnBorder,
                        "assets/svg/certificate_bottom_nav_button.svg",
                        semanticsLabel: 'certificate_logo_bottom_nav')),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 4;
                  });
                  _pageController.animateToPage(
                    4,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: SizedBox(
                    height: 28,
                    width: 28,
                    child: SvgPicture.asset(
                        color: pageIndex == 4
                            ? AppColors.whiteColor
                            : AppColors.languageBtnBorder,
                        "assets/svg/settings_bottom_nav_button.svg",
                        semanticsLabel: 'settings_logo_bottom_nav')),
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: pages,
      ),
    );
  }
}
