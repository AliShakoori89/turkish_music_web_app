import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/album_model.dart';

import '../../data/model/new_album_model.dart';
import '../../data/model/song_model.dart';
import '../../data/network/api_base_helper.dart';

class AlbumRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  Future<dynamic> getNewAlbum() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Album/GetNewAlbums');
    final productJson = json.decode(response.body);
    var newDongData = NewAlbumModel.fromJson(productJson);
    return newDongData;
  }

  Future<dynamic> getSingerAllAlbum(int id) async {
    ApiBaseHelper api = ApiBaseHelper();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final response = await api.get('/api/Album/GetAlbumsBySingerId/$id', accessToken: accessToken!);
    final productJson = json.decode(response.body);
    var singerAllAlbum = AlbumModel.fromJson(productJson);
    return singerAllAlbum.data;
  }
}