import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/position_data.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/seek_bar.dart';

class SongSlider extends StatefulWidget {

  final Stream<PositionData> positionDataStream;
  final AudioPlayer player;

  const SongSlider({super.key, required this.positionDataStream, required this.player});

  @override
  State<SongSlider> createState() => _SongSliderState();
}

class _SongSliderState extends State<SongSlider> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: widget.positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition:
          positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: widget.player.seek,
        );
      },
    );
  }
}
