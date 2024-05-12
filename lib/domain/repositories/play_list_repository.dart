import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
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

    await api.post('/api/PlayList/AddToPlayList', body);

    Get.showSnackbar(
      GetSnackBar(
        message: 'Add to playlist ...',
        showProgressIndicator: true,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  removeFromPlayList(int musicID) async{

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "musicId": musicID,
      "apiKey": apiKey
    });
    await api.post('/api/PlayList/RemoveFromPlayList', body);

    Get.showSnackbar(
      GetSnackBar(
        message: 'Remove from playlist ...',
        showProgressIndicator: true,
        duration: const Duration(seconds: 2),
      ),
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