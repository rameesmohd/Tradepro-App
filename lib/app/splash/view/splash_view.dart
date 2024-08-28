import 'dart:async';

import 'package:flutter/material.dart';

import '../../on_board/view/onboard_view.dart';

class ScreenSplashView extends StatefulWidget {
  const ScreenSplashView({super.key});

  @override
  State<ScreenSplashView> createState() => _ScreenSplashViewState();
}

class _ScreenSplashViewState extends State<ScreenSplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenOnBoardView(),
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash screen')),
    );
  }
}
