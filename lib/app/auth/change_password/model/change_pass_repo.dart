import 'dart:convert';

import 'package:tradepro/app/auth/change_password/model/change_pass_model.dart';
import 'package:tradepro/const/functions/helper_functions.dart';
import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';

class ChangePassRepo {
  DataProvider dataProvider = DataProvider();
  Future<ChangePassModel?> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      HelperFuntions helperFun = HelperFuntions();
      final currentUser = await helperFun.getCurrentUser();
      final response = await dataProvider.putRequest(
          endpoint: ApiUrls.changePasswordSettings,
          body: {
            "oldPassword": oldPassword,
            "newPassword": newPassword,
            "userID": currentUser.id
          });
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = changePassModelFromJson(response.body);
        return responseData;
      } else if (response.statusCode == 400) {
        final responseData = changePassModelFromJson(response.body);
        return responseData;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
