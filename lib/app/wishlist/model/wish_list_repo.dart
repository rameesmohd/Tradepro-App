import 'dart:convert';
import 'dart:developer';

import 'package:tradepro/const/functions/helper_functions.dart';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';
import 'wish_list_model.dart';

class WishListRepo {
  DataProvider dataProvider = DataProvider();
  Future<WishListModel> fetchWishList() async {
    try {
      final response = await dataProvider.getRequest(
          endpoint: ApiUrls.listWishList, needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final wishListReponse = wishListModelFromJson(response.body);

        return wishListReponse;
      } else if (response.statusCode == 400) {
        final wishListReponse = wishListModelFromJson(response.body);

        return wishListReponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> courseAddToWishList(
      {required String courseId, required String language}) async {
    final user = await HelperFuntions().getCurrentUser();

    try {
      final response = await dataProvider.sendRequest(
          body: {'userId': user.id, 'courseId': courseId, 'language': language},
          endpoint: ApiUrls.addToWishlist,
          needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final courseResponse = jsonDecode(response.body);
        log(courseResponse.toString());
        return courseResponse['message'] != null;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> courseRemoveFromWishList(
      {required String courseId, required String wishListId}) async {
    final user = await HelperFuntions().getCurrentUser();

//     wishlistID:670104cb517c724090a440bc
// userID:66fedc347012eeb6bff79a53
// courseID:66f59f0e396c896c845f9a47

    try {
      final response = await dataProvider.deletRequest(queryParameters: {
        "wishlistID": wishListId,
        "userID": user.id!,
        "courseID": courseId
      }, endpoint: ApiUrls.removeFromWishlist, needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final courseResponse = jsonDecode(response.body);
        log(courseResponse.toString());
        return courseResponse['status'];
      } else if (response.statusCode == 400) {
        final courseResponse = jsonDecode(response.body);
        return courseResponse['status'];
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
