import 'dart:io';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {

  final String baseUrl = 'api.turkishmusicapi.ir';
  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';



  Future<dynamic> get(String url,
      {String accessToken = '', String query = ""}) async {
    try {

      final queryParameters = {
        'apiKey': apiKey
      };

      Map<String, String> headers;

      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $accessToken',
      };

      final Uri address = Uri(
          host: baseUrl, scheme: "http", query: query, path: url, queryParameters: queryParameters);

      print("address                           "+address.toString());

      // var secondURL = Uri.http(baseUrl, url, queryParameters);
      // print("secondURL                        "+secondURL.toString());
      final response = await http.get(address, headers: headers);

      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> post(String url, dynamic body, {String accessToken = '', String query = ''}) async {

    try {
      // final Uri address = Uri.parse(baseUrl+url);

      final Uri address =
      Uri(host: baseUrl+url, scheme: "http", path: url);

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