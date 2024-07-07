import 'package:shared_preferences/shared_preferences.dart';

class MiniPlayingContainerRepository {

  Future<dynamic> firstShowMiniPlayingContainer() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstShowMiniPlayingContainer', true);
  }

  Future<bool> isItTheFirstTimeTtIsShown() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? firstShow = prefs.getBool('firstShowMiniPlayingContainer');
    if(firstShow != null){
      return firstShow;
    }else{
      return false;
    }
  }

  Future<dynamic> writeMiniPlayingRequirement(String songName, String songFile, String songImage) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('songName', songName);
    await prefs.setString('songFile', songFile);
    await prefs.setString('songImage', songImage);
  }

  Future<List> readMiniPlayingRequirement() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String songName = prefs.getString('songName')!;
    final String songFile = prefs.getString('songFile')!;
    final String songImage = prefs.getString('songImage')!;
    List requirement = [songName, songFile, songImage];
    return requirement;
  }
}