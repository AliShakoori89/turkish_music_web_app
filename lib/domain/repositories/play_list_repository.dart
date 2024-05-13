import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/playListSongModel.dart';
import '../../data/network/api_base_helper.dart';

class PlayListRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  @override
  addToPlayList(int musicID) async {

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "musicId": musicID,
      "apiKey": apiKey
    });

    String accessToken = await getAccessTokenValue();

    final response = await api.post('/api/PlayList/AddToPlayList', body, accessToken: accessToken);

    print("res          "+response.statusCode);

    if (response.statusCode == 200) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Add to playlist ...',
          showProgressIndicator: true,
          duration: const Duration(seconds: 2),
        ),
      );
      return true;
    }
    else {
      return false;
    }


  }

  @override
  removeFromPlayList(int musicID) async{

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "musicId": musicID,
      "apiKey": apiKey
    });

    String accessToken = await getAccessTokenValue();

    final response = await api.post('/api/PlayList/RemoveFromPlayList', body, accessToken: accessToken);

    if (response.statusCode == 200) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Remove from playlist ...',
          showProgressIndicator: true,
          duration: const Duration(seconds: 2),
        ),
      );
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<dynamic> getMusicFromPlayList() async{

    ApiBaseHelper api = ApiBaseHelper();

    String accessToken = await getAccessTokenValue();

    var response = await api.get('/api/PlayList/GetPlayListOfCurrentUser', accessToken: accessToken);

    final productJson = json.decode(response.body);
    // print("productJsonnnnnnnnnnnnnnn           "+productJson.toString());
    var PlayListData = PlaylistModel.fromJson(productJson);
    print("PlayListData                      "+PlayListData.data!.musics.toString());
    return PlayListData.data!.musics;
  }

  getAccessTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }
}