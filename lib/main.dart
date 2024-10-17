import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tradepro/app/auth/change_password/view_model/change_pass_bloc.dart';
import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/app/auth/login/view_model/bloc/login_bloc.dart';
import 'package:tradepro/app/auth/registration/view_model/bloc/register_bloc.dart';
import 'package:tradepro/app/checkout/view_model/checkout_bloc.dart';
import 'package:tradepro/app/course_detail/view_model/course_detail_bloc.dart';
import 'package:tradepro/app/dashboard/view_model/dashboard_bloc.dart';
import 'package:tradepro/app/home/view_model/bloc/home_bloc.dart';
import 'package:tradepro/app/profile/view_model/profile_bloc.dart';
import 'package:tradepro/app/quiz/view_model/quiz_bloc.dart';
import 'package:tradepro/app/refer_screen/view_model/referal_bloc.dart';
import 'package:tradepro/app/splash/view/splash_view.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_bloc.dart';
import 'package:tradepro/app/wishlist/view_model/wish_list_bloc.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';

import 'app/auth/forget_password/view_model/forgot_bloc.dart';

void main() async {
  await Hive.initFlutter();
  HiveHelper.registerAdapter(LoginModelAdapter());
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
          create: (BuildContext context) => ForgotPassBloc(),
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
          create: (BuildContext context) => DashboardBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => CourseDetailBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => CheckoutBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => ProfileBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => ChangePassBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => WishListBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => ReferalBloc(),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => QuizBloc(),
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
