import 'dart:convert';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';

class WishListRepo {
  DataProvider dataProvider = DataProvider();
  Future<dynamic> fetchWishList() async {
    try {
      final response = await dataProvider.getRequest(
          endpoint: ApiUrls.listWishList, needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final courseResponse = jsonDecode(response.body);

        return courseResponse['data'];
      } else if (response.statusCode == 400) {
        final courseResponse = jsonDecode(response.body);
        return courseResponse['message'];
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
