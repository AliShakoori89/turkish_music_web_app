import 'dart:async';
import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../data/model/new_music_model.dart';
import '../../data/network/api_base_helper.dart';

class MusicRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getNewMusic() async {

    ApiBaseHelper api = ApiBaseHelper();

    final response =
    await api.get('/api/Music/GetNewMusics/{apiKey}');
    final productJson = json.decode(response.body);

    return Autogenerated.fromJson(productJson);
  }
}