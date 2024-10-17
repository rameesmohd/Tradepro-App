import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/forget_password/view/number_entry.dart';
import 'package:tradepro/app/auth/login/view_model/bloc/login_bloc.dart';
import 'package:tradepro/app/main/view/screen_main_view.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_bloc.dart';
import 'package:tradepro/app/splash/view_model/bloc/splash_event.dart';

import '../../../../const/colors.dart';
import '../../../../const/widget/already_doesnt_have_n_didnt_get.dart';
import '../../../../const/widget/text_field.dart';
import '../view_model/bloc/login_event.dart';
import '../view_model/bloc/login_state.dart';

class ScreenLoginView extends StatelessWidget {
  const ScreenLoginView({super.key});

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static late String email;
  static late String password;

  static final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _loginFormKey,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          AppColors.whiteColor,
                          AppColors.backgroundSecondaryColor
                        ])),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: BlocBuilder<LoginBloc, LoginState>(
                      // bloc: BlocProvider.of<LoginBloc>(context),
                      builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        const Text('Welcome Back to',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor)),
                        const Text('Tradepro Academy!',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: AppColors.backgroundSecondaryColor)),
                        const SizedBox(height: 8),
                        const Text(
                            'Enter your credentials to access your account',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.regSubtitle)),
                        const SizedBox(height: 25),
                        AppTextField(
                          hintText: 'Email',
                          controller: emailController,
                          onChanged: (p0) {
                            email = p0;
                          },
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          hintText: 'Password',
                          controller: passwordController,
                          onChanged: (p0) {
                            password = p0;
                          },
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: BlocListener(
                              bloc: BlocProvider.of<LoginBloc>(context),
                              listener: (context, state) {
                                if (state is LoginSuccessState) {
                                  BlocProvider.of<SplashBloc>(context)
                                      .add(UserInitialSetup());
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenMainView()),
                                      (route) => false);
                                } else if (state is LoginLoadingFailedState) {
                                  var snackdemo = SnackBar(
                                    content: Text(state.errorMessage,
                                        style:
                                            const TextStyle(color: Colors.red)),
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(5),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackdemo);
                                }
                              },
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.backgroundSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  onPressed: () {
                                    if (_loginFormKey.currentState!.validate()) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                          UserLoginEvent(
                                              email: email, password: password));
                                    }
                                  },
                                  child: Text(
                                    state is LoginLoadingState
                                        ? 'Loading...'
                                        : state is LoginLoadingFailedState
                                            ? "Try again!"
                                            : 'Login',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AppColors.whiteColor),
                                  )),
                            )),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenForgetView(),
                                  ));
                            },
                            child: const Text('Forgot Password',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blackColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16))),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 16,
                                      width: 16,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/fi_104093.png'))),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: AppColors.whiteColor),
                                    ),
                                  ],
                                ))),
                        const SizedBox(height: 30),
                        const Spacer(),
                        const Align(
                            alignment: Alignment.center,
                            child: SwitchLoginRegister(
                              textType: 'LOGIN',
                            ))
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // if (value.length < 6) {
    //   return 'Password must be at least 6 characters';
    // }
    return null;
  }
}
