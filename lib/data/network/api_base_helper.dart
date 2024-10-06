import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {

  final String baseUrl = 'api.turkishmusicapi.ir';
  // final String baseUrl = '194.5.195.145';

  FutureOr<dynamic> get(String url,
      {String accessToken = "", String query = "", String page = "", String count = "", String searchChar = ""}) async {
    try {

      await dotenv.load();
      final String? apiKey = dotenv.get("apiKey");

      final queryParameters = {
        "page": page,
        "count": count,
        "searchChar": searchChar
      };

      Map<String, String> headers;

      headers = {
        'Content-Type': 'application/json',
        'ApiKey': '$apiKey',
        'Authorization': 'bearer $accessToken',
      };

      final Uri address = Uri(
          host: baseUrl, scheme: "https", query: query, path: url, queryParameters: queryParameters);

      final response = await http.get(address, headers: headers);
      print("response 2                "+response.statusCode.toString());
      return response;
    } on SocketException {
      print("4444444444444444444444");
      throw FetchDataException('No Internet connection');
    }
  }

  FutureOr<dynamic> post(String url, dynamic body, {String accessToken = '', String query = ''}) async {

    await dotenv.load();
    final String? apiKey = dotenv.get("apiKey");

    try {

      final Uri address =
      Uri(host: baseUrl, scheme: "https", query: query, path: url);
      //https://api.turkishmusicapi.ir/api/User/FirstStepLogin
      Map<String, String> headers;

      headers = {
        'Content-type': 'application/json',
        'ApiKey': '$apiKey',
        'Authorization': 'bearer $accessToken'
      };

      final response = await http.post(address, body: body, headers: headers);
      var responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }
}

http.Response _returnResponse(http.Response response) {
  return response;
}