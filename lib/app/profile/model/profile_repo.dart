import 'dart:developer';
import 'dart:io';

import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';
import '../../../const/functions/helper_functions.dart';
import 'user_profile_model.dart';

class ProfileRepo {
  DataProvider dataProvider = DataProvider();
  Future<UserProfileModel?> fetchUserProfile() async {
    final userDetails = await HelperFuntions().getCurrentUser();
    try {
      final response = await dataProvider.getRequest(
          queryParameters: {'userId': userDetails.id!},
          endpoint: ApiUrls.findUserProfile,
          needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final profileResponse = userProfileModelFromJson(response.body);
        return profileResponse;
      } else if (response.statusCode == 400) {
        final profileResponse = userProfileModelFromJson(response.body);
        return profileResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> updateUserDetails(
      {required File? imageFile,
      required String userName,
      required String email,
      required String countryCode,
      required String phoneNumber,
      required bool isNotification}) async {
    final userDetails = await HelperFuntions().getCurrentUser();
    try {
      return await dataProvider.uploadFormDataWithImage(
          endpoint: ApiUrls.porfileUpdate,
          imageFile: imageFile,
          bodyData: {
            'name': userName,
            'email': email,
            'countryCode': countryCode,
            'phoneNumber': phoneNumber,
            'isNotification': isNotification.toString(),
            'userId': userDetails.id!
          });
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
