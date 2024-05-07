import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
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

    Get.snackbar(
        "",
        "Add to playlist ...",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        barBlur: 50,
        colorText: Colors.white,
        maxWidth: 200
    );
  }

  @override
  removeFromPlayList(int userID, int musicID) async{

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "userId": userID,
      "musicId": musicID,
      "apiKey": apiKey
    });
    await api.post('/api/PlayList/RemoveFromPlayList', body);

    Get.snackbar(
        "",
        "Remove from playlist ...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      barBlur: 50,
      colorText: Colors.white,
      maxWidth: 200
    );
  }

  @override
  getMusicToPlayList() async{

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "apiKey": apiKey
    });
    await api.post('/api/PlayList/GetPlayListOfCurrentUser', body);
  }
}