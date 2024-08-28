import 'package:flutter/material.dart';
import 'package:tradepro/app/auth/login/view/login_view.dart';

import '../colors.dart';

class SwitchLoginRegister extends StatelessWidget {
  const SwitchLoginRegister({
    super.key,
    this.textType = 'REGISTER',
  });
  final String textType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (textType == 'REGISTER') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScreenLoginView()));
        } else if (textType == 'LOGIN') {
          Navigator.pop(context);
        } else {}
      },
      child: RichText(
          text: TextSpan(
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.alreadyHave),
              children: [
            TextSpan(
                text: textType == 'REGISTER'
                    ? 'Already have an account?'
                    : textType == 'LOGIN'
                        ? "Doesn't have an accout?"
                        : "Didn’t received code?"),
            TextSpan(
                text: textType == 'REGISTER'
                    ? ' Login'
                    : textType == 'LOGIN'
                        ? ' Register'
                        : ' Resend',
                style: const TextStyle(
                    color: AppColors.login, fontWeight: FontWeight.w800))
          ])),
    );
  }
}
