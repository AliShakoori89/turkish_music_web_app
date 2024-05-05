import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/network/api_base_helper.dart';

class PlayListRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  @override
  addToPlayList(int userID, int musicID) async {
    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "userId": userID,
      "musicId": musicID,
      "apiKey": apiKey
    });

    await api.post('/api/PlayList/AddToPlayList', body);
  }

  @override
  removeFromPlayList(int userID, int musicID) async{

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "userId": userID,
      "musicId": musicID,
      "apiKey": apiKey
    });
  await api.post('/api/PlayList/AddToPlayList', body);
  }
}