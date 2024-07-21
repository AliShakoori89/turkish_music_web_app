import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/playListSongModel.dart';
import '../../data/network/api_base_helper.dart';

class PlayListRepository {

  List playlistIDs = [];

  addToPlayList(int musicID) async {

    await dotenv.load();
    final String? apiKey = dotenv.get("apiKey");

    ApiBaseHelper api = ApiBaseHelper();

    var body = jsonEncode({
      "musicId": musicID,
      "apiKey": apiKey
    });

    String accessToken = await getAccessTokenValue();

    final response = await api.post('/api/PlayList/AddToPlayList', body, accessToken: accessToken);

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

  removeFromPlayList(int musicID) async{

    await dotenv.load();
    final String? apiKey = dotenv.get("apiKey");

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

  FutureOr<dynamic> getMusicFromPlayList() async{

    ApiBaseHelper api = ApiBaseHelper();

    String accessToken = await getAccessTokenValue();

    var response = await api.get('/api/PlayList/GetPlayListOfCurrentUser', accessToken: accessToken);

    final productJson = json.decode(response.body);
    var PlayListData = PlaylistModel.fromJson(productJson);
    return PlayListData.data!.musics;
  }

  getAccessTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  addMusicIDToList(int id){
    playlistIDs.add(id);
  }

  removeMusicIDFromList(int id){
    playlistIDs.remove(id);
  }

  bool isMusicInPlaylist(int id){
    bool exist = playlistIDs.contains(id);
    if(exist){
      return true;
    }else{
      return false;
    }
  }
}