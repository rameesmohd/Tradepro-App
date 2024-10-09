import 'dart:convert';

import 'package:tradepro/app/checkout/model/checkout_model.dart';
import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';

class CheckoutRepo {
  DataProvider dataProvider = DataProvider();
  Future<CheckoutModel> checkoutCourse(
      {required Map<String, dynamic> params}) async {
    try {
      final response = await dataProvider.sendRequest(needToken: true,
          endpoint: ApiUrls.courseCheckout, body: params);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final checkoutResponse = CheckoutModel.fromJson(responseData);
        return checkoutResponse;
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        final checkoutResponse = CheckoutModel.fromJson(responseData);
        return checkoutResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
