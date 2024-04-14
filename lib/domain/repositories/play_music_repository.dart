import 'package:shared_preferences/shared_preferences.dart';

class SingerRepository {

  saveMusicIsPlaying(String filePath) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('filePath', filePath);
  }

}