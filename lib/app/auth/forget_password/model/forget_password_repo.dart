import 'dart:convert';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';

class ForgetPasswordRepo {
  DataProvider dataProvider = DataProvider();
  Future<Map<String, dynamic>?> forgetPhoneNumberSubmit(
      {required String phoneNumber}) async {
    try {
      final response = await dataProvider.sendRequest(
          endpoint: ApiUrls.forgotPasswordApi,
          body: {"phoneNumber": phoneNumber});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw "Failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> forgotOtpSubmit({required String otp}) async {
    try {
      final response = await dataProvider
          .sendRequest(endpoint: ApiUrls.forgotVerifyOtp, body: {"otp": otp});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw "Failed";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> forgotSubmitNewPass(
      {required String password, required String phoneNumber}) async {
    try {
      final response = await dataProvider.sendRequest(
          endpoint: ApiUrls.forgotChangePassword,
          body: {"password": password, "phoneNumber": phoneNumber});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        throw "Failed";
      }
    } catch (e) {
      rethrow;
    }
  }
}
