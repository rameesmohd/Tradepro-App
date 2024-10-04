// import 'dart:convert';

// import '../../../../const/api/apis.dart';
// import '../../../../providers/db_provider/server/api_data_provider.dart';

// class LessonListingRepo {
//   DataProvider dataProvider = DataProvider();
//   Future unloackChapter(Map<String, String> chapterDetails) async {
//     try {
//       final response = await DataProvider.sendRequest(
//           endpoint: ApiUrls.chapterUnloack,
//           needToken: true,
//           body: chapterDetails);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final encodedData = jsonDecode(response.body);
//         encodedData;
//       } else if (response.statusCode == 400) {
//         final encodedData = jsonDecode(response.body);
//         encodedData;
//       } else {
//         throw "Error loading product";
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
