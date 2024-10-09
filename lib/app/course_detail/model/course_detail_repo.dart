import 'dart:convert';

import '../../../../const/api/apis.dart';
import '../../../../providers/db_provider/server/api_data_provider.dart';
import 'course_detail_model.dart';

class CourseDetailRepo {
  DataProvider dataProvider = DataProvider();
  Future<CourseDetailModel?> fetchCourseDetail(String id) async {
    try {
      final response = await dataProvider.getRequest(
          endpoint: ApiUrls.courseDetailListing,
          needToken: true,
          queryParameters: {'id': id});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final courseResponse = courseDetailModelFromJson(response.body);
        return courseResponse;
      } else if (response.statusCode == 400) {
        final courseResponse = courseDetailModelFromJson(response.body);
        return courseResponse;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future unloackChapter(Map<String, String> chapterDetails) async {
    try {
      final response = await dataProvider.sendRequest(
          endpoint: ApiUrls.chapterUnloack,
          needToken: true,
          body: chapterDetails);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final encodedData = jsonDecode(response.body);
        encodedData;
      } else if (response.statusCode == 400) {
        final encodedData = jsonDecode(response.body);
        encodedData;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
