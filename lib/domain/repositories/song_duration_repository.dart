import 'package:audioplayers/audioplayers.dart';

class SongDurationRepository {

  @override
  Future<dynamic> getSongDuration(String songFilePath, AudioPlayer player) async {
    final duration = await player.setSourceUrl(songFilePath);
    return duration;
  }
}