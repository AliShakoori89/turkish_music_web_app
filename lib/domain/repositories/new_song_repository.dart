import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class NewSongRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  Future<dynamic> getNewMusic() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);
    var newSongData = NewMusicModel.fromJson(productJson);
    return newSongData.data;
  }

}