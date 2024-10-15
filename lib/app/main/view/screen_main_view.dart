import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/certificates/view/certificates_view.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';

import '../../dashboard/view/dashboard_view.dart';
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
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.backgroundSecondaryColor
                                .withOpacity(.1)),
                        child: const Image(
                            image:
                                AssetImage('assets/images/user_profile.png')),
                      ),
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
                          SizedBox(height: 5),
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
                      const Row(
                        children: [
                          Icon(Icons.wallet),
                          SizedBox(width: 15),
                          Icon(Icons.notifications_none_rounded)
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
                  child: Image.asset(
                    'assets/images/fi_1946488.png',
                    color: pageIndex == 0
                        ? AppColors.whiteColor
                        : AppColors.languageBtnBorder,
                  ),
                ),
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
                  child: Image.asset(
                    'assets/images/XMLID_1_.png',
                    color: pageIndex == 1
                        ? AppColors.whiteColor
                        : AppColors.languageBtnBorder,
                  ),
                ),
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
                  child: Image.asset(
                    'assets/images/fi_13369080.png',
                    color: pageIndex == 2
                        ? AppColors.whiteColor
                        : AppColors.languageBtnBorder,
                  ),
                ),
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
                  child: Image.asset(
                    'assets/images/Layer_6.png',
                    color: pageIndex == 3
                        ? AppColors.whiteColor
                        : AppColors.languageBtnBorder,
                  ),
                ),
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
                  child: Image.asset(
                    'assets/images/fi_3019014.png',
                    color: pageIndex == 4
                        ? AppColors.whiteColor
                        : AppColors.languageBtnBorder,
                  ),
                ),
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
