import 'dart:io';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {

  final String baseUrl = 'http://194.5.195.145';
  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';



  Future<dynamic> get(String url,
      {String accessToken = '', int page = 0, int count = 0}) async {
    try {

      final queryParameters = {
        'apiKey': apiKey,
        "page": page ,
        "count": count
      };

      Map<String, String> headers;

      headers = {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $accessToken',
      };

      var secondURL = Uri.http("194.5.195.145", url, queryParameters);
      final response = await http.get(secondURL, headers: headers);
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