import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:tradepro/app/auth/change_password/view/change_password_view.dart';
import 'package:tradepro/app/home/view/home_view.dart';
import 'package:tradepro/const/colors.dart';
import 'package:tradepro/const/widget/already_doesnt_have_n_didnt_get.dart';

import '../../../../const/widget/text_field.dart';

class ScreenRegisterVeiw extends StatelessWidget {
  const ScreenRegisterVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text('Welcome to',
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
                    const Text('Enter your details to setup your account',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.regSubtitle)),
                    const SizedBox(height: 25),
                    const AppTextField(
                      hintText: 'Full Name',
                    ),
                    const SizedBox(height: 10),
                    const AppTextField(
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 10),
                    const PhoneField(),
                    const AppTextField(
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 10),
                    const AppTextField(
                      hintText: 'Confirm Password',
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.backgroundSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              showOTPBottomSheet(context);
                            },
                            child: const Text(
                              'Create an Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.whiteColor),
                            ))),
                    const SizedBox(height: 30),
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
                    const Align(
                        alignment: Alignment.center,
                        child: SwitchLoginRegister())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future showOTPBottomSheet(BuildContext ctx) {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.textFieldBorder),
      borderRadius: BorderRadius.circular(4),
    ),
  );

  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.backgroundSecondaryColor),
    borderRadius: BorderRadius.circular(4),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: AppColors.backgroundSecondaryColor.withOpacity(.2),
    ),
  );
  return showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          width: double.infinity,
          height: 341,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  width: double.infinity,
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          style: IconButton.styleFrom(
                              shape: const CircleBorder(
                                  side:
                                      BorderSide(color: AppColors.blackColor))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                    ),
                    const Text(
                      'Verify your Phone Number',
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.verifyYourPhone,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please enter the otp send to 756******98',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 15),
                    Pinput(
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      validator: (s) {
                        return s == '2222' ? null : 'Pin is incorrect';
                      },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      length: 6,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.backgroundSecondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenChangePasswordView()),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Verify',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppColors.whiteColor),
                            ))),
                    const SizedBox(height: 15),
                    const Align(
                        alignment: Alignment.center,
                        child: SwitchLoginRegister(
                          textType: 'OTP',
                        )),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      dropdownIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      flagsButtonPadding: const EdgeInsets.all(8),
      dropdownIconPosition: IconPosition.trailing,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.backgroundSecondaryColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.textFieldBorder)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.textFieldBorder),
              borderRadius: BorderRadius.circular(10))),
      initialCountryCode: 'IN',
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}
