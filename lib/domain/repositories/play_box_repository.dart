import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class PlayBoxRepository {

  final String? apiKey = dotenv.env['map.apikey'];

  Future<dynamic> getPlayBox(String songName) async {
    ApiBaseHelper api = ApiBaseHelper();
    List<NewSongDataModel> renewSongData =  [];
    final response = await api.get('/api/NewMusic/GetAll');
    final productJson = json.decode(response.body);
    var newSongData = NewMusicModel.fromJson(productJson);

    for(int i=0; i < newSongData.data.length; i++){
      if(newSongData.data[i].name != songName){
        renewSongData.add(newSongData.data[i]);
      }
    }
    return renewSongData;
  }

  Future<dynamic> getSongTime(String songFile) async {

    double songTime = 0;
    return songTime;
  }

  Future<dynamic> getSongMinute(String songFile) async {

    int songEndMinute = 0 ;




    return songEndMinute;
  }

  Future<dynamic> getSongSecond(String songFile) async {

    String songEndSecond = '0';

    return songEndSecond;
  }
}