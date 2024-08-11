import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {

  final String baseUrl = 'api.turkishmusicapi.ir';


  FutureOr<dynamic> get(String url,
      {String accessToken = "", String query = "", String page = "", String count = "", String searchChar = ""}) async {
    try {

      await dotenv.load();
      final String? apiKey = dotenv.get("apiKey");

      final queryParameters = {
        'apiKey': apiKey,
        "page": page,
        "count": count,
        "searchChar": searchChar
      };

      Map<String, String> headers;

      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $accessToken',
      };

      final Uri address = Uri(
          host: baseUrl, scheme: "https", query: query, path: url, queryParameters: queryParameters);

      print(address);
      final response = await http.get(address, headers: headers);
      print(response.body);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  FutureOr<dynamic> post(String url, dynamic body, {String accessToken = '', String query = ''}) async {

    try {

      final Uri address =
      Uri(host: baseUrl, scheme: "https", query: query, path: url);

      Map<String, String> headers;

      headers = {
        'Content-type': 'application/json',
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