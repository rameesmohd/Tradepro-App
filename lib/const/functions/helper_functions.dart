import 'package:flutter/material.dart';

import '../../app/auth/login/model/login_model.dart';
import '../../providers/db_provider/hive/hive_helper.dart';

class HelperFuntions {
  static LoginModel? currentUser;

  Future<LoginModel> getCurrentUser() async {
    if (currentUser != null) {
      return currentUser!;
    } else {
      currentUser = await HiveHelper.getItem<LoginModel>(
          HiveHelper.loginUserBoxHive, HiveHelper.loginUserKeyHive);
      return currentUser!;
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
