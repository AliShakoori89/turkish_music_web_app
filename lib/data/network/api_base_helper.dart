import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {

  final String baseUrl = 'http://194.5.195.145';
  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';



  Future<dynamic> get(String url,
      {String accessToken = '', String query = ""}) async {
    try {

      final queryParameters = {
        'apiKey': apiKey
      };

      // final Uri uri =
      // Uri(host: "194.5.195.145", scheme: "http");

      Map<String, String> headers;

      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $accessToken',
      };

      // print("uri                                "+uri.toString());

      var urll = Uri.http("194.5.195.145", url, queryParameters);
      print(urll);
      print("222222222222222222222222222222222222222222222222222222 ");
      final response = await http.get(urll, headers: headers);
      print("333333333333333333333333333333333333333333333333333333333 ");
      print("response                                 eeeeeee             "+response.body);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> post(String url, dynamic body, {String accessToken = '', String query = ''}) async {

    try {
      final Uri address = Uri.parse(baseUrl+url);

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