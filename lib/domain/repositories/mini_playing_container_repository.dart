import 'package:shared_preferences/shared_preferences.dart';

class MiniPlayingContainerRepository {

  Future<dynamic> firstShowMiniPlayingContainer() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstShowMiniPlayingContainer', true);
  }

  Future<bool> isItTheFirstTimeTtIsShown() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? firstShow = prefs.getBool('firstShowMiniPlayingContainer');
    print("firstShow                "+firstShow.toString());
    if(firstShow != null){
      return firstShow;
    }else{
      return false;
    }
  }
}