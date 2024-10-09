import 'package:tradepro/app/auth/login/model/login_model.dart';
import 'package:tradepro/const/functions/helper_functions.dart';
import 'package:tradepro/providers/db_provider/hive/hive_helper.dart';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';
import 'course_list_model.dart';

class HomeRepo {
  DataProvider dataProvider = DataProvider();
  Future<CourseListModel?> fetchCourse() async {
    final userDetails = await HelperFuntions().getCurrentUser();
    try {
      final response = await dataProvider.getRequest(
          queryParameters: {'userId': userDetails.id!},
          endpoint: ApiUrls.courseListing,
          needToken: true);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final courseResponse = courseListModelFromJson(response.body);
        return courseResponse;
      } else if (response.statusCode == 400) {
        final courseResponse = courseListModelFromJson(response.body);
        return courseResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
