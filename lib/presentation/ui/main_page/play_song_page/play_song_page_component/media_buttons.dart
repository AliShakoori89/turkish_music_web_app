import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/play_list_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/repeat_button.dart';
import 'control_button.dart';
import 'download_button.dart';

class MediaButtons extends StatelessWidget {

  // final AudioPlayer player;
  final bool loop;
  const MediaButtons({super.key,
    // required this.player,
    required this.loop});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          children: [
            RandomPlayButton(),
            Spacer(),
            PlayListButton()
          ],
        ),
        const Spacer(),
        ControlButtons(
            // player: player
        ),
        const Spacer(),
        Column(
          children: [
            RepeatButton(loop: loop),
            const Spacer(),
            const DownloadButton()
          ],
        ),
      ],
    );
  }
}
