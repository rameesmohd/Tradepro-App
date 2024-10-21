import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../sp/sp_hleper.dart';

class DataProvider {
  Future<http.Response> sendRequest(
      {required String endpoint, dynamic body, bool needToken = false}) async {
    String? token;
    if (needToken) {
      token = await SPHelper.getData<String>(SPHelper.userTokenKey);
    }
    final header = {
      if (token != null) 'Authorization': 'Bearer $token',
    };
    log("======= sending request to $endpoint with $body and $token ========");
    body.removeWhere((key, value) => value == null);
    try {
      final response = await http
          .post(Uri.parse(endpoint), body: body, headers: header)
          .timeout(const Duration(seconds: 30));

      log("head for sent req $header when response ${response.headers.toString()}");
      log("status ${response.statusCode.toString()}");
      log("body ${response.body.toString()}");
      return response;
    } catch (e) {
      log("======= threow the error on api sending request : $e ========");
      rethrow;
    }
  }

  Future<http.Response> getRequest(
      {required String endpoint,
      bool needToken = false,
      Map<String, String>? queryParameters}) async {
    log('======== Calling request $endpoint ==========');
    try {
      String? token;
      if (needToken) {
        token = await SPHelper.getData<String>(SPHelper.userTokenKey);
      }

      final header = {
        if (token != null) 'Authorization': 'Bearer $token',
      };

      // final Uri uri = Uri.parse(endpoint);

      final Uri uri =
          Uri.parse(endpoint).replace(queryParameters: queryParameters);
      log("======= ${uri.toString()} ======== url is");

      final response = await http
          .get(uri, headers: header)
          .timeout(const Duration(seconds: 30));

      log("========= got response for $uri ${needToken ? token : ''} --------- ${response.body} ============");
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool?> uploadFormDataWithImage(
      {required String endpoint,
      required File? imageFile,
      required Map<String, String> bodyData}) async {
    try {
      // Create the request
      var request = http.MultipartRequest('POST', Uri.parse(endpoint));
      final token = await SPHelper.getData<String>(SPHelper.userTokenKey);

      // Add headers (if needed, e.g., authorization token)
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      // Add text fields
      for (var i = 0; i < bodyData.length; i++) {
        request.fields[bodyData.keys.elementAt(i)] =
            bodyData.values.elementAt(i);
      }

      // Detect MIME type and attach image file
      // final mimeType = lookupMimeType(imageFile.path);

      // Add image file to the request
      if (imageFile != null) {
        request.files.add(
          http.MultipartFile(
            'image', // Field name for image in form-data
            imageFile.readAsBytes().asStream(),
            await imageFile.length(),
            // filename: basename(imageFile.path), // Extract the file name
            // contentType:
            //     MediaType.parse(mimeType ?? 'image/jpeg'), // Set correct MIME type
          ),
        );
      }

      // Send the request
      var response = await request.send().timeout(const Duration(seconds: 30));

      // Check the response
      if (response.statusCode == 200) {
        final resString = await response.stream.bytesToString();
        final responseData = jsonDecode(resString);
        log('Upload success: $responseData');
        return responseData['status'] as bool;
      } else {
        log('Upload failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error: $e');
      return false;
    }
  }

  Future<http.Response> putRequest({
    required Map<String, dynamic> body,
    required String endpoint,
    bool needToken = true,
  }) async {
    log('======== Calling request $endpoint ==========');
    try {
      String? token;
      if (needToken) {
        token = await SPHelper.getData<String>(SPHelper.userTokenKey);
      }

      final header = {
        if (token != null) 'Authorization': 'Bearer $token',
      };

      // final Uri uri = Uri.parse(endpoint);

      final Uri uri = Uri.parse(endpoint);
      log("======= ${uri.toString()} ======== url is");

      final response = await http
          .put(uri, headers: header, body: body)
          .timeout(const Duration(seconds: 30));

      log("========= got response for $endpoint ${needToken ? token : ''} --------- ${response.body} ============");
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<http.Response> deletRequest({
    required String endpoint,
    bool needToken = true,
    Map<String, String>? queryParameters,
  }) async {
    log('======== Calling request $endpoint ==========');
    try {
      String? token;
      if (needToken) {
        token = await SPHelper.getData<String>(SPHelper.userTokenKey);
      }

      final header = {
        if (token != null) 'Authorization': 'Bearer $token',
      };

      // final Uri uri = Uri.parse(endpoint);

      final Uri uri =
          Uri.parse(endpoint).replace(queryParameters: queryParameters);
      log("======= ${uri.toString()} ======== url is");

      final response = await http
          .delete(
            uri,
            headers: header,
          )
          .timeout(const Duration(seconds: 30));

      log("========= got response for $endpoint ${needToken ? token : ''} --------- ${response.body} ============");
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

Future<void> storeSessionId(http.Response response) async {
  if (response.headers.containsKey('set-cookie')) {
    final setCookieHeader = response.headers['set-cookie'];

    final regex = RegExp(r'session_id=([^;]+)');
    final match = regex.firstMatch(setCookieHeader!);

    if (match != null) {
      final sessionId = match.group(1);
      await SPHelper.setData<String>(SPHelper.userTokenKey, sessionId!);
      log('Session ID: $sessionId');
    } else {
      log('Session ID not found');
    }
  } else {
    log('Set-Cookie header not found');
  }
}
