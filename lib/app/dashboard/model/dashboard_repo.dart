import 'dart:convert';

import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/app/dashboard/model/dashboard_model.dart';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';
import '../../../const/functions/helper_functions.dart';

class DashboardRepo {
  DataProvider dataProvider = DataProvider();
  Future<DashboardModel?> fetchDashBoard() async {
    try {
      final LoginModel userDetails = await HelperFuntions().getCurrentUser();
      final response = await dataProvider.getRequest(
          endpoint: ApiUrls.finadUserWallet,
          needToken: true,
          queryParameters: {'id': userDetails.id!});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dashboardResponse = dashboardModelFromJson(response.body);
        return dashboardResponse;
      } else if (response.statusCode == 400) {
        final dashboardResponse = dashboardModelFromJson(response.body);
        return dashboardResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
