import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';

import '../../data/model/new-song_model.dart';
import '../../data/network/api_base_helper.dart';

class PlayBoxRepository {

  final String apiKey = 'YekAdadApiKeyMibashadKeBarayeApplicationTurkishMusicJahatEstefadehAsApiHaSakhteShodeAst';

  @override
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

  @override
  Future<dynamic> getSongTime(String songFile) async {

    double songTime = 0;

    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setSourceUrl(songFile);

    audioPlayer.onDurationChanged.listen((Duration d) {
      songTime = double.parse(d.inSeconds.toString());
    });
    return songTime;
  }

  @override
  Future<dynamic> getSongMinute(String songFile) async {

    int songEndMinute = 0 ;

    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setSourceUrl(songFile);

    audioPlayer.onDurationChanged.listen((Duration d) {
      songEndMinute = d.inSeconds~/ 60;
    });
    return songEndMinute;
  }

  @override
  Future<dynamic> getSongSecond(String songFile) async {

    String songEndSecond = '0';

    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setSourceUrl(songFile);

    audioPlayer.onDurationChanged.listen((Duration d) {
      songEndSecond = ((d.inSeconds) % 60).toString().padLeft(2, '0');
    });
    return songEndSecond;
  }
}