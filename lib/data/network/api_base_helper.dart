import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {
  final String baseUrl = 'http://194.5.195.145';
  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  Future<dynamic> post(String url, dynamic body, {String accessToken = '', String query = ''}) async {

    print("33333");
    try {
      print("44444");
      print("url               "+url);
      final Uri address =
      Uri.parse(baseUrl+url);

      print("addressssssssssss                 $address");

      Map<String, String> headers;

      if (accessToken.length > 10) {

        headers = {
          'Content-type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        };

      } else {
        print("555555");
        headers = {
          'Content-type': 'application/json',
          'Authorization': accessToken
        };

      }

      final response = await http.post(address, body: body, headers: headers);
      // print("response              "+jsonDecode(response.body));
      var responseJson = _returnResponse(response);
      var parsedJson = json.decode(response.body);
      print("responseJson              "+ parsedJson['message']);
      return responseJson;

    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }


}

http.Response _returnResponse(http.Response response) {
  return response;
}