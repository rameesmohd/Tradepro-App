import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tradepro/app/auth/change_password/view_model/change_pass_bloc.dart';
import 'package:tradepro/app/auth/change_password/view_model/change_pass_event.dart';
import 'package:tradepro/app/auth/forget_password/view_model/forgot_bloc.dart';
import 'package:tradepro/app/auth/forget_password/view_model/forgot_event.dart';
import 'package:tradepro/app/auth/forget_password/view_model/forgot_state.dart';
import 'package:tradepro/app/auth/login/view/login_view.dart';
import 'package:tradepro/const/functions/helper_functions.dart';

import '../../../../const/colors.dart';
import '../../../../const/widget/text_field.dart';
import '../view_model/change_pass_state.dart';

class ScreenChangePasswordView extends StatelessWidget {
  const ScreenChangePasswordView({super.key, this.isForForgot = false});

  final bool isForForgot;

  static TextEditingController oldPasswordController = TextEditingController();
  static TextEditingController newPasswordController = TextEditingController();
  static TextEditingController conPassWordController = TextEditingController();
  static String? oldPassword;
  static String? newPassword;
  static String? confirmPassword;
  static final _changePasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                child: Form(
                  key: _changePasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      const Text('Change Password',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor)),
                      const SizedBox(height: 8),
                      const Text(
                          'Enter your credentials to access your account',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.regSubtitle)),
                      const SizedBox(height: 25),
                      if (!isForForgot)
                        AppTextField(
                          validator: isForForgot
                              ? null
                              : (oldPassword) {
                                  if (oldPassword == null ||
                                      oldPassword.trim().isEmpty) {
                                    return 'Old password is requerd';
                                  }
                                  return null;
                                },
                          onChanged: (p0) {
                            oldPassword = p0;
                          },
                          controller: oldPasswordController,
                          hintText: 'Old Password',
                        ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: newPasswordController,
                        hintText: 'New Password',
                        onChanged: (p0) => newPassword = p0,
                        validator: (newPassword) {
                          if (newPassword == null ||
                              newPassword.trim().isEmpty) {
                            return 'New password is requerd';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      AppTextField(
                        controller: conPassWordController,
                        hintText: 'Confirm Password',
                        validator: (confirmPassword) {
                          if (confirmPassword == null ||
                              confirmPassword.trim().isEmpty) {
                            return 'Confirm password is requerd';
                          } else if (confirmPassword != newPassword) {
                            // log('hey here');
                            // log('$confirmPassword');
                            // log(newPasswordController.text);
                            return 'New password is different';
                          }
                          return null;
                        },
                        onChanged: (p0) => confirmPassword = p0,
                      ),
                      const SizedBox(height: 10),
                      !isForForgot
                          ? BlocListener<ChangePassBloc, ChangePasswordState>(
                              listener: (context, state) {
                                if (state is ChangePasswordLoadingFailedState) {
                                  HelperFuntions().showSnackBar(
                                      context, state.errorMessage);
                                } else if (state
                                    is ChangePasswordSuccessState) {
                                  oldPasswordController.clear();
                                  newPasswordController.clear();
                                  conPassWordController.clear();

                                  HelperFuntions().showSnackBar(
                                      context, state.successMessage ?? '');
                                }
                              },
                              child: BlocBuilder<ChangePassBloc,
                                      ChangePasswordState>(
                                  builder: (context, state) {
                                return SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors
                                                .backgroundSecondaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16))),
                                        onPressed: () {
                                          log(newPassword ?? 'null');
                                          log(oldPassword ?? 'null');
                                          log(confirmPassword ?? 'null');
                                          final isValid = _changePasswordFormKey
                                              .currentState
                                              ?.validate();
                                          if (isValid == null || !isValid) {
                                            return;
                                          } else {
                                            _changePasswordFormKey.currentState
                                                ?.save();
                                            BlocProvider.of<ChangePassBloc>(
                                                    context)
                                                .add(UserChangePasswordEvent(
                                                    oldPassword: oldPassword!,
                                                    newPassword: newPassword!));
                                          }
                                        },
                                        child: Text(
                                          state is ChangePasswordLoadingState
                                              ? "Loading..."
                                              : 'Continue',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.whiteColor),
                                        )));
                              }),
                            )
                          : BlocListener<ForgotPassBloc, ForgotPassState>(
                              listener: (context, state) {
                                if (state is ForgotLoadingFailedState) {
                                  HelperFuntions().showSnackBar(
                                      context, state.errorMessage);
                                } else if (state is ForgotSuccessState) {
                                  oldPasswordController.clear();
                                  newPasswordController.clear();
                                  conPassWordController.clear();
                                  HelperFuntions().showSnackBar(
                                      context, state.successMessage ?? '');
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScreenLoginView()),
                                      (route) => false);
                                }
                              },
                              child:
                                  BlocBuilder<ForgotPassBloc, ForgotPassState>(
                                      builder: (context, state) {
                                return SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors
                                                .backgroundSecondaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16))),
                                        onPressed: () {
                                          if (state is! ForgotLoadingState) {
                                            log(newPassword ?? 'null');
                                            log(oldPassword ?? 'null');
                                            log(confirmPassword ?? 'null');
                                            final isValid =
                                                _changePasswordFormKey
                                                    .currentState
                                                    ?.validate();
                                            if (isValid == null || !isValid) {
                                              log('if case');
                                              return;
                                            } else {
                                              log('else case');
                                              _changePasswordFormKey
                                                  .currentState
                                                  ?.save();
                                              BlocProvider.of<ForgotPassBloc>(
                                                      context)
                                                  .add(UserSubmitNewPassword(
                                                      password: newPassword!));
                                            }
                                          }
                                        },
                                        child: Text(
                                          state is ChangePasswordLoadingState
                                              ? "Loading..."
                                              : 'Submit',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: AppColors.whiteColor),
                                        )));
                              }),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
