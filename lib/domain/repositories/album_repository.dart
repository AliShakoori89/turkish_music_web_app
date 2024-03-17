import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/album_model.dart';

import '../../data/model/new_album_model.dart';
import '../../data/network/api_base_helper.dart';

class AlbumRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
  Future<dynamic> getNewAlbum() async {
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Album/GetNewAlbums');
    final productJson = json.decode(response.body);
    var newDongData = NewAlbumModel.fromJson(productJson);

    return newDongData.data;
  }

  @override
  Future<dynamic> getSingerAllAlbum(int id) async {
    ApiBaseHelper api = ApiBaseHelper();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final response = await api.get('/api/Album/GetAlbumsBySingerId/$id', accessToken: accessToken!);
    print("1111111111 "+ response.toString());
    final productJson = json.decode(response.body);
    print("22222222222222       "+productJson.toString());
    var singerAllAlbum = AlbumModel.fromJson(productJson);
    print("3333333333333333       "+singerAllAlbum.toString());
    return singerAllAlbum.data;
  }
}