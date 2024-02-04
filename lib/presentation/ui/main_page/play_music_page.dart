import 'dart:ui';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/like_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_back_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_next_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_previous_button.dart';
import '../../helpers/music_player_component/download_button.dart';
import '../../helpers/music_player_component/loopIcon_button.dart';

class PlayMusicPage extends StatefulWidget {
  
  final String imagePath;
  final String trackName;
  final String singerName;

  const PlayMusicPage({super.key,
    required this.imagePath,
    required this.trackName,
    required this.singerName});

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {

  final double _progress = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
              image: AssetImage(widget.imagePath),
          fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2),
                BlendMode.dstATop),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomAppBar(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.trackName,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white
                              )),
                          Text(widget.singerName,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey
                            ),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: LikeButton(
                          name: widget.singerName,
                          track: widget.trackName,
                          isIcon: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                CircularSeekBar(
                  width: double.infinity,
                  height: 350,
                  progress: _progress,
                  barWidth: 8,
                  startAngle: 45,
                  sweepAngle: 270,
                  strokeCap: StrokeCap.butt,
                  progressGradientColors: const [Colors.blue, Colors.indigo, Colors.purple],
                  dashWidth: 1,
                  dashGap: 2,
                  animation: true,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath)
                      )
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RandomPlayButton(),
                    Row(
                      children: [
                        const SkipPrevious(),
                        const SizedBox(
                          width: 10,
                        ),
                        PlayButton(),
                        const SizedBox(
                          width: 10,
                        ),
                        const SkipNext()
                      ],
                    ),
                    const LoopIconButton()
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.playlist_play_outlined,
                      color: Colors.grey,
                    ),
                    DownloadButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
