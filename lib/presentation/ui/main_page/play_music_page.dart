import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/like_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_next_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_previous_button.dart';
import '../../../data/model/album_model.dart';
import '../../helpers/music_player_component/download_button.dart';
import '../../helpers/music_player_component/loopIcon_button.dart';

class PlayMusicPage extends StatefulWidget {
  
  final String imagePath;
  final String singerName;
  List<AlbumDataMusicModel>? musicFiles;
  String? musicFile;

  PlayMusicPage({super.key,
    required this.imagePath,
    required this.singerName,
    this.musicFiles,
    this.musicFile});

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState(imagePath, singerName, musicFiles,
      musicFile);
}

class _PlayMusicPageState extends State<PlayMusicPage> {

  String imagePath;
  String singerName;
  List<AlbumDataMusicModel>? musicFiles;
  String? musicFile;

  final double _progress = 90;

  AudioPlayer audioPlayer = AudioPlayer();

  PlaybackState playbackState = PlaybackState.stop;
  bool get isPlaying =>
      playbackState == PlaybackState.play ||
          playbackState == PlaybackState.preloadPlayed;

  _PlayMusicPageState(this.imagePath, this.singerName, this.musicFiles,
      this.musicFile);

  final SimpleAudio player = SimpleAudio(
    onSkipNext: (_) => debugPrint("Next"),
    onSkipPrevious: (_) => debugPrint("Prev"),
    onNetworkStreamError: (player, error) {
      debugPrint("Network Stream Error: $error");
      player.stop();
    },
    onDecodeError: (player, error) {
      debugPrint("Decode Error: $error");
      player.stop();
    },
  );

  String convertSecondsToReadableString(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;

    return "$m:${s > 9 ? s : "0$s"}";
  }

  @override
  void initState() {
    super.initState();

    player.playbackStateStream.listen((event) async {
      setState(() => playbackState = event);
    });

    player.progressStateStream.listen((event) {
      setState(() {
        position = event.position.toDouble();
        duration = event.duration.toDouble();
      });
    });
  }

  bool get isMuted => volume == 0;
  double trueVolume = 1;
  double volume = 1;
  bool normalize = false;
  bool loop = false;

  double position = 0;
  double duration = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
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
          fit: BoxFit.fitHeight,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2),
                BlendMode.dstATop),
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: CustomAppBar(
                    title: "Now Playing",
                    singerName: singerName,
                    haveMenuButton: true,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(singerName,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: LikeButton(
                          name: singerName,
                          isIcon: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
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
                              fit: BoxFit.fitHeight
                          )
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RandomPlayButton(),
                        LoopIconButton()
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const SkipPrevious(),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleButton(
                        size: 40,
                        onPressed: () async{

                          if (isPlaying) {
                            player.pause();
                            await audioPlayer.pause();
                          } else {
                            player.play();
                            print("@@@@@@@@@@@@@@@               "+musicFile.toString());

                            await audioPlayer.play(UrlSource(musicFile!));
                          }
                        },
                        child: Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SkipNext()
                  ],
                ),),
                Flexible(
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
                ),
                musicFiles != null ? Flexible(
                  flex: 4,
                  child: ListView.builder(
                    itemCount: musicFiles?.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10
                        ),
                        child: Text(musicFiles![index].name!),
                      );
                    },
                  )
                )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.onPressed,
    required this.child,
    this.size = 35,
    this.color = Colors.blue,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            canRequestFocus: false,
            onTap: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}
