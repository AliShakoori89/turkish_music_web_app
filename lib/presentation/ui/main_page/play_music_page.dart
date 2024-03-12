import 'dart:ui';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/like_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_next_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_previous_button.dart';
import '../../helpers/music_player_component/download_button.dart';
import '../../helpers/music_player_component/loopIcon_button.dart';

class PlayMusicPage extends StatefulWidget {
  
  final String imagePath;
  final String singerName;

  const PlayMusicPage({super.key,
    required this.imagePath,
    required this.singerName});

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState(imagePath, singerName);
}

class _PlayMusicPageState extends State<PlayMusicPage> {

  String imagePath;
  String singerName;
  final double _progress = 90;

  _PlayMusicPageState(this.imagePath, this.singerName);

  @override
  Widget build(BuildContext context) {

    print("imagePath                              "+imagePath);
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
              image: NetworkImage(imagePath),
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
                const Expanded(
                    flex: 1,
                    child: CustomAppBar()),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(widget.singerName,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                          ),)
                        ,
                      ),
                      Expanded(
                        flex: 1,
                        child: LikeButton(
                            name: widget.singerName,
                            isIcon: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Expanded(
                  flex: 6,
                  child: CircularSeekBar(
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
                          image: NetworkImage(widget.imagePath),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05
                    ),
                    child: Row(
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
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.08,
                        left: MediaQuery.of(context).size.width * 0.08
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.playlist_play_outlined,
                          color: Colors.grey,
                        ),
                        DownloadButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
