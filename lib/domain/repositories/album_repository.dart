import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import '../../data/model/new_album_model.dart';
import '../../data/network/api_base_helper.dart';

class AlbumRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  FutureOr<dynamic> getAllAlbum(String char) async {
    ApiBaseHelper api = ApiBaseHelper();

    try {
      final response = await api.get('/api/Album/GetAll', page: "1", count: "4000", searchChar: char);
      if (response.statusCode == 200) {
        List<AlbumDataModel> allAlbum = [];
        final data = jsonDecode(response.body);
        final List<dynamic> allSongList = data['data'];
        allAlbum = allSongList.map((e) => AlbumDataModel.fromJson(e)).toList();
        return allAlbum;
      }
    }catch (e) {
      throw e.toString();
    }
  }

  FutureOr<dynamic> getNewAlbum() async {
    List<NewAlbumDataModel> list = [];
    ApiBaseHelper api = ApiBaseHelper();
    final response = await api.get('/api/Album/GetNewAlbums');
    final productJson = json.decode(response.body);
    var newAlbumData = NewAlbumModel.fromJson(productJson);
    for(int i = newAlbumData.data!.length-4; i < newAlbumData.data!.length; i++){
      list.add(newAlbumData.data![i]);
    }
    return list;
  }

  FutureOr<dynamic> getSingerAllAlbum(int singerID) async {
    ApiBaseHelper api = ApiBaseHelper();
    List<String> list = [];
    List<AlbumDataModel> list1 = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final response = await api.get('/api/Album/GetAlbumsBySingerId/$singerID', accessToken: accessToken!);
    final productJson = json.decode(response.body);
    var singerAllAlbum = AlbumModel.fromJson(productJson);
    for(int i = 0 ; i < singerAllAlbum.data!.length ; i++){
      list.add(singerAllAlbum.data![i].name!);
    }

    list.sort((a, b) {
      var yearA = extractYearOrAlbum(a);
      var yearB = extractYearOrAlbum(b);
      if (int.tryParse(yearB) != null && int.tryParse(yearA) != null) {
        return int.parse(yearB).compareTo(int.parse(yearA));
      }
      return yearA.compareTo(yearA);
    });

    for(int i = 0 ; i < singerAllAlbum.data!.length ; i++){
      for(int j = 0 ; j < singerAllAlbum.data!.length ; j++){
        if(list[i] == singerAllAlbum.data![j].name!){
          list1.add(singerAllAlbum.data![j]);
        }
      }
    }
    return list1;
  }

  FutureOr<dynamic> getAlbumAllSongsByID(int albumID) async {
    ApiBaseHelper api = ApiBaseHelper();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final response = await api.get('/api/Album/GetOneAlbum/$albumID', accessToken: accessToken!);
    final productJson = json.decode(response.body);
    var albumSongs = AlbumDataModel.fromJson(productJson['data']);
    return albumSongs.musics;
  }

  String extractYearOrAlbum(String album) {
    RegExp regExp = RegExp(r'\((\d{4})\)'); // Regular expression to match year (4 digits inside parentheses)
    Match? match = regExp.firstMatch(album);

    if (match != null) {
      return match.group(1)!; // Return the year as a string if found
    }

    return album; // Return the original album name if no year is found
  }
}