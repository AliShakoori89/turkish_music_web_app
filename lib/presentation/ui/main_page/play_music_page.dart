import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/like_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_next_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_previous_button.dart';
import '../../../data/model/album_model.dart';
import '../../bloc/is_playing_music_bloc/bloc.dart';
import '../../bloc/is_playing_music_bloc/event.dart';
import '../../bloc/is_playing_music_bloc/state.dart';
import '../../helpers/music_player_component/download_button.dart';
import '../../helpers/music_player_component/loopIcon_button.dart';
import '../../helpers/widgets/circle_button.dart';



class PlayMusicPage extends StatefulWidget {
  
  final String imagePath;
  final String singerName;
  final List<AlbumDataMusicModel> musicFiles;
  final String musicFile;

  const PlayMusicPage({super.key,
    required this.imagePath,
    required this.singerName,
    required this.musicFiles,
    required this.musicFile});

  @override
  State<PlayMusicPage> createState() => PlayMusicPageState(imagePath, singerName, musicFiles,
      musicFile);
}

class PlayMusicPageState extends State<PlayMusicPage> {

  final String imagePath;
  final String singerName;
  final List<AlbumDataMusicModel>? musicFiles;
  final String musicFile;

  PlayMusicPageState(this.imagePath, this.singerName, this.musicFiles, this.musicFile);


  AudioPlayer audioPlayer = AudioPlayer();

  PlaybackState playbackState = PlaybackState.stop;
  bool get isPlaying =>
      playbackState == PlaybackState.play ||
          playbackState == PlaybackState.preloadPlayed;

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

    print("33333333333     "+musicFile);

    BlocProvider.of<IsPlayingMusicBloc>(context)
        .add(SetIsPlayingMusicEvent(
      musicFilePath: musicFile,
      singerName: singerName,
      imagePath: imagePath,
      isPlaying: isPlaying,
    ));
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

    // print("isPlayinggggggggggggggggggg              "+isPlaying.toString());

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
                      progress: 100,
                      barWidth: 8,
                      startAngle: 45,
                      sweepAngle: 270,
                      strokeCap: StrokeCap.butt,
                      progressGradientColors: const [Colors.blue, Colors.indigo, Colors.purple],
                      dashWidth: 1,
                      dashGap: 2,
                      animation: true,
                      animDurationMillis: 10000,

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
                      // maxProgress: 120,
                      // minProgress: 0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(convertSecondsToReadableString(position.floor())),
                      Text(convertSecondsToReadableString(duration.floor())),
                    ],
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.05,
                          left: MediaQuery.of(context).size.width * 0.05
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RandomPlayButton(),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 24,
                            onPressed: () {
                              setState(() => loop = !loop);
                              player.loopPlayback(loop);
                            },
                            icon: loop
                                ? const Icon(
                              CupertinoIcons.arrow_2_circlepath,
                              color: Colors.white,
                              size: 20,)
                                : const Icon(
                                CupertinoIcons.arrow_2_circlepath,
                                color: Colors.grey,
                                size: 20),
                          )
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
                        PlayButton(
                          isPlaying: isPlaying,
                          player: player,
                          audioPlayer: audioPlayer,
                          musicFile: musicFile,
                          musicSingerName: singerName,
                          imagePath: imagePath,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const SkipNext()
                      ],
                    )
                  ),
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
      )
    );
  }

  // CircleButton playButton() {
  //   return CircleButton(
  //     size: 60,
  //     onPressed: () async {
  //       print("*******             " + isPlaying.toString());
  //       print("*******             " + player.toString());
  //       print("*******             " + audioPlayer.playerId);
  //       if (musicFile == musicFile) {
  //         if (isPlaying) {
  //           player.pause();
  //           await audioPlayer.pause();
  //         } else {
  //           player.play();
  //           await audioPlayer.play(UrlSource(musicFile!));
  //         }
  //       }
  //     },
  //     child: Icon(
  //       isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
  //       color: Colors.white,
  //       size: 50,
  //     ),
  //   );
  // }
}

