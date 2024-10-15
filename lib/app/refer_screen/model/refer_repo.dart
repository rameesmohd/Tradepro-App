import 'dart:convert';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';
import '../../../const/functions/helper_functions.dart';

class ReferalRepo {
  DataProvider dataProvider = DataProvider();
  Future<String?> getReferalCode() async {
    final userDetails = await HelperFuntions().getCurrentUser();
    try {
      final response = await dataProvider.getRequest(
          queryParameters: {'userId': userDetails.id!},
          endpoint: ApiUrls.findUserReferl,
          needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final referalResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        if (referalResponse.containsKey('data')) {
          return referalResponse['data'];
        } else {
          return null;
        }
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
