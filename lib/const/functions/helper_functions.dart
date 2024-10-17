import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  String takeLanguage(String language) {
    switch (language.toLowerCase()) {
      case 'english':
        return 'English';
      case 'hindi':
        return 'हिंदी';
      case 'malayalam':
        return 'മലയാളം';
      case 'tamil':
        return 'தமிழ்';
      default:
        return 'English';
    }
  }

  String getErrorMessage(dynamic exception) {
    if (exception is TimeoutException) {
      return "Request timed out. Please try again later.";
    } else if (exception is SocketException) {
      return "No Internet connection. Please check your network.";
    } else if (exception is HttpException) {
      return "Server error. Please try again later.";
    } else if (exception is FormatException) {
      return "Unexpected response format. Please try again.";
    } else {
      return "Something went wrong. Please try again.";
    }
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  Future<ShareResult> shareFromApp(String message) async {
    return await Share.share(message);
  }

  Future<bool> isHaveConnectivity() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }
    return false;
  }
}
