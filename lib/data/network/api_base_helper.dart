import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {
  final String baseUrl = 'http://194.5.195.145';


  Future<dynamic> get(String url,
      {String accessToken = '', String query = ''}) async {
    try {
      final Uri address = Uri.parse(baseUrl+url);
      Map<String, String> headers;

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $accessToken',
      };


      print("3333333333333333333333333333333333                 " + address.toString());
      final response = await http.get(address, headers: headers);
      var responseJson = _returnResponse(response);
      return responseJson;
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