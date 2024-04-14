import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class IsPlayingMusicRepository {

  setMusicIsPlaying(String filePath, String singerName, String singerImage) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('filePath', filePath);
    await prefs.setString('singerName', singerName);
    await prefs.setString('singerImage', singerImage);
  }

  FutureOr<String?> getMusicFileIsPlaying() async{
    final prefs = await SharedPreferences.getInstance();
    final String? filePath = prefs.getString('filePath');
    return filePath;
  }

  FutureOr<String?> getMusicSingerNameIsPlaying() async{
    final prefs = await SharedPreferences.getInstance();
    final String? singerName = prefs.getString('singerName');
    return singerName;
  }

  FutureOr<String?> getMusicSingerImageIsPlaying() async{
    final prefs = await SharedPreferences.getInstance();
    final String? singerImage = prefs.getString('singerImage');
    return singerImage;
  }

}