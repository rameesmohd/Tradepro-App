import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/main/view/screen_main_view.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_bloc.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_event.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_state.dart';

import '../../on_board/view/onboard_view.dart';

class ScreenSplashView extends StatefulWidget {
  const ScreenSplashView({super.key});

  @override
  State<ScreenSplashView> createState() => _ScreenSplashViewState();
}

class _ScreenSplashViewState extends State<ScreenSplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2),
        () => BlocProvider.of<SplashBloc>(context).add(UserInitialSetup()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
          bloc: BlocProvider.of<SplashBloc>(context),
          listener: (context, state) {
            if (state is UserLoginState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ScreenMainView()));
            } else if (state is SplashLoadinState) {
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenOnBoardView(),
                  ));
            }
          },
          child: const Center(child: Text('Splash screen'))),
    );
  }
}
