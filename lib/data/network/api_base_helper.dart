import 'dart:convert';
import 'package:http/http.dart' as http;
import 'http_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = 'http://194.5.195.145';
  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  Future<> getBestArtistList() async {
    final url = '$_baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    final res = await http.get (Uri.parse (url));
    if(res.statusCode != 200){
      throw FetchDataException ("unable to fetch weather data");
    }
    final weatherJson = json.decode (res.body);
    return WeatherModel.fromJson (weatherJson);
  }


}