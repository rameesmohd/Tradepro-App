import 'package:flutter/material.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';

class ScreenMainView extends StatefulWidget {
  const ScreenMainView({super.key});

  @override
  ScreenMainViewState createState() => ScreenMainViewState();
}

class ScreenMainViewState extends State<ScreenMainView> {
  int pageIndex = 0;

  final pages = [const ScreenHomeView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                child: const Icon(Icons.home, color: AppColors.whiteColor)),
            InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                child: const Icon(Icons.home, color: AppColors.whiteColor)),
            InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                child: const Icon(Icons.home, color: AppColors.whiteColor)),
            InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                child: const Icon(Icons.home, color: AppColors.whiteColor)),
            InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                child: const Icon(Icons.home, color: AppColors.whiteColor)),
          ],
        ),
        //  BottomNavigationBar(items: [
        //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //   BottomNavigationBarItem(icon: Icon(Icons.car_crash), label: 'Car'),
        //   BottomNavigationBarItem(icon: Icon(Icons.pedal_bike), label: 'Bike')
        // ])
      ),
      body: pages[pageIndex],
    );
  }
}
