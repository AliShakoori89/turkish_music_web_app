import 'package:shared_preferences/shared_preferences.dart';

class PlayButtonStateRepository{

  Future<bool?> getPlayButtonState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? playButtonState = prefs.getBool('playButtonState');
    return playButtonState!;
  }

  setPlayButtonState(bool playButtonState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('playButtonState', playButtonState);
  }
}