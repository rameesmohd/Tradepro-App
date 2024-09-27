import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/login/view_model/bloc/login_bloc.dart';
import 'package:tradepro/app/auth/registration/view_model/bloc/register_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/splash/view/splash_view.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => RegisterBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => SplashBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => CourseDetailBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Trade Pro',
        theme: ThemeData(
          fontFamily: 'Poppins',

          // Customize text styles if needed
          // textTheme: TextTheme(
          //   bod: TextStyle(fontSize: 16.0),
          //   bodyText2: TextStyle(fontSize: 14.0),
          //   headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          //   // Add more text styles as needed
          // ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ScreenSplashView(),
      ),
    );
  }
}
