import 'dart:convert';
import 'dart:developer';

import 'package:tradepro/app/auth/login/model/login_model.dart';
import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';

class LoginRepos {
  DataProvider dataProvider = DataProvider();
  Future<LoginModel?> userLogin(
      {required Map<String, dynamic> credentails}) async {
    try {
      log(credentails.toString());
      final response = await DataProvider.sendRequest(
          endpoint: ApiUrls.loginUrl, body: credentails);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final authResponse = LoginModel.fromJson(responseData);
        return authResponse;
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        final authResponse = LoginModel.fromJson(responseData);
        return authResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
