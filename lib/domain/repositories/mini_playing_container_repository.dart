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

  FutureOr<dynamic> writeMiniPlayingRequirement(int songID, int albumID) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("writeMiniPlayingRequirement      "+songID.toString());
    await prefs.setInt('songID', songID);
    await prefs.setInt('albumID', albumID);
  }

  FutureOr<List> readMiniPlayingRequirement() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int songID = prefs.getInt('songID')!;
    final int albumID = prefs.getInt('albumID')!;
    List requirement = [songID, albumID];
    return requirement;
  }
}