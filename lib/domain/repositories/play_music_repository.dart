import 'package:shared_preferences/shared_preferences.dart';

class IsPlayingMusicRepository {

  setMusicIsPlaying(String filePath, String singerName, String singerImage) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('filePath', filePath);
    await prefs.setString('singerName', singerName);
    await prefs.setString('singerImage', singerImage);
  }

  Future<> getMusicIsPlaying() async{
    final prefs = await SharedPreferences.getInstance();
    final String? filePath = prefs.getString('filePath');
    final String? singerName = prefs.getString('singerName');
    final String? singerImage = prefs.getString('singerImage');

    return ;
  }

}