import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../sp/sp_hleper.dart';

class DataProvider {
  static Future<http.Response> sendRequest(
      {required String endpoint, dynamic body, bool needToken = false}) async {
    String? token;
    if (needToken) {
      token = await SPHelper.getData<String>(SPHelper.userTokenKey);
    }
    final header = {
      if (token != null) 'Authorization': 'Bearer $token',
    };
    log("======= sending request to $endpoint with $body and $token ========");
    try {
      final response =
          await http.post(Uri.parse(endpoint), body: body, headers: header);

      log("head for sent req $header when response ${response.headers.toString()}");
      log("status ${response.statusCode.toString()}");
      log("body ${response.body.toString()}");
      return response;
    } catch (e) {
      log("======= threow the error on api sending request : $e ========");
      rethrow;
    }
  }

  static Future<http.Response> getRequest(
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

      final response = await http.get(uri, headers: header);

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
