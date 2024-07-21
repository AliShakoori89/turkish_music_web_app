import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class MiniPlayingContainerRepository {

  FutureOr<dynamic> firstShowMiniPlayingContainer() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstShowMiniPlayingContainer', true);
  }

  FutureOr<bool> isItTheFirstTimeTtIsShown() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? firstShow = prefs.getBool('firstShowMiniPlayingContainer');
    if(firstShow != null){
      return firstShow;
    }else{
      return false;
    }
  }

  FutureOr<dynamic> writeMiniPlayingRequirement(String songName, String songFile, String songImage,
      String singerName, String pageName) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('songName', songName);
    await prefs.setString('songFile', songFile);
    await prefs.setString('songImage', songImage);
    await prefs.setString('singerName', singerName);
    await prefs.setString('pageName', pageName);
  }

  FutureOr<List> readMiniPlayingRequirement() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String songName = prefs.getString('songName')!;
    final String songFile = prefs.getString('songFile')!;
    final String songImage = prefs.getString('songImage')!;
    final String singerName = prefs.getString('singerName')!;
    final String pageName = prefs.getString('pageName')!;
    List requirement = [songName, songFile, songImage, singerName, pageName];
    return requirement;
  }
}