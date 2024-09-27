import 'dart:convert';
import 'dart:developer';
import 'package:tradepro/app/auth/registration/model/register_model.dart';
import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';

class RegisterRepo {
  DataProvider dataProvider = DataProvider();

  Future<RegisterModel?> userSubmitPhoneNumber(
      {required Map<String, dynamic> credentails}) async {
    try {
      log(credentails.toString());
      final response = await DataProvider.sendRequest(
          endpoint: ApiUrls.registerUrl, body: credentails);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final authResponse = RegisterModel.fromJson(responseData);
        return authResponse;
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        final authResponse = RegisterModel.fromJson(responseData);
        return authResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<RegisterModel?> userSubmitOtp(
      {required Map<String, dynamic> credentails}) async {
    try {
      log(credentails.toString());
      final response = await DataProvider.sendRequest(
          endpoint: ApiUrls.verifyOtp, body: credentails);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final authResponse = RegisterModel.fromJson(responseData);
        return authResponse;
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        final authResponse = RegisterModel.fromJson(responseData);
        return authResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
