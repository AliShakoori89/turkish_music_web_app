import 'dart:ui';

import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/music_progress_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/normalize_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_back_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/stop_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/volume_button.dart';

import '../../helpers/music_player_component/download_button.dart';

class PlayMusicPage extends StatefulWidget {
  
  final String imagePath;
  const PlayMusicPage({super.key, required this.imagePath});

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {

  final double _progress = 90;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("assets/images/tarkan.png"),
          fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2),
                BlendMode.dstATop),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.15,
                  left: MediaQuery.of(context).size.width * 0.15
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PlayBackButton(),
                    Row(
                      children: [
                        StopButton(),
                        const SizedBox(
                          width: 5,
                        ),
                        PlayButton(),
                        const SizedBox(
                          width: 5,
                        ),
                        const VolumeButton()
                      ],
                    ),
                    const DownloadButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
