import 'dart:ui';
import 'package:audio_session/audio_session.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/download_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/like_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/play_list_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/position_data.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/repeat_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/seek_bar.dart';
import '../../../helpers/widgets/custom_app_bar.dart';
import 'package:just_audio/just_audio.dart';


class PlayMusicPage extends StatefulWidget {

  final String songName;
  final String songFile;
  final String songImage;
  final String songSingerName;
  const PlayMusicPage({super.key, required this.songFile, required this.songName,
  required this.songImage, required this.songSingerName});


  @override
  State<PlayMusicPage> createState() => PlayMusicPageState();
}

class PlayMusicPageState extends State<PlayMusicPage> with WidgetsBindingObserver {

  // bool normalize = false;
  bool loop = false;
  // // double songSecond = 0;
  // int songEndMinute = 0 ;
  // String songEndSecond = '0';

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {

    print("222222222222222                  "+widget.songFile);
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');

          print("++++++++++++                 "+widget.songFile);

        });
    // Try to load audio from a source and catch any errors.
    try {
      print("33333333333333333333333                  "+widget.songFile);
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await player.setAudioSource(AudioSource.uri(Uri.parse(
          // "http://194.5.195.145/TurkishMusicFiles/NewMusicFiles/2024-04-13-10-20-30-Sana Na.mp3"
          "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"
      )));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    // ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));


  @override
  Widget build(BuildContext context) {

    // AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
        body: Container(
          height: double.infinity,
          margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            image: DecorationImage(
              image: NetworkImage(widget.songImage),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
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
                      singerName: widget.songName,
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
                          child: Text(
                            widget.songSingerName,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: LikeButton(
                            name: widget.songName,
                            isIcon: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: CircularSeekBar(
                      width: double.infinity,
                      height: 350,
                      progress: 100,
                      barWidth: 8,
                      startAngle: 45,
                      sweepAngle: 270,
                      strokeCap: StrokeCap.butt,
                      progressGradientColors: const [
                        Colors.blue,
                        Colors.indigo,
                        Colors.purple
                      ],
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
                                image: NetworkImage(widget.songImage),
                                fit: BoxFit.fitHeight)),
                      ),
                      // maxProgress: 120,
                      // minProgress: 0,
                    ),
                  ),
                  // StreamBuilder(
                  //     stream: BlocProvider.of<SongControlBloc>(context).positionStream,
                  //   builder: ((context, snapshot) {
                  //     audioPlayer.setSourceUrl(songFile);
                  //
                  //     if (snapshot.hasData) {
                  //       Duration? duration = snapshot.data;
                  //       return Column(
                  //         children: [
                  //           Padding(
                  //               padding:
                  //               const EdgeInsets.symmetric(horizontal: 70.0),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Text((duration!.inMinutes)
                  //                           .toString()
                  //                           .padLeft(2, '0')),
                  //                       const Text(":"),
                  //                       Text((calculateSecondTimer(duration))
                  //                           .toString()
                  //                           .padLeft(2, '0'))
                  //                     ],
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Text(songEndMinute.toString()),
                  //                       const Text(":"),
                  //                       Text(songEndSecond)
                  //                     ],
                  //                   )
                  //                 ],
                  //               )),
                  //           SliderTheme(
                  //               data: SliderTheme.of(context).copyWith(
                  //                   thumbShape: const RoundSliderThumbShape(
                  //                       enabledThumbRadius: 5)),
                  //               child: SizedBox(
                  //                 width: MediaQuery.of(context).size.width / 1.5,
                  //                 child: Slider(
                  //                   // activeColor: Colors.purple,
                  //                   // inactiveColor: Colors.black,
                  //                     value: (snapshot.data?.inSeconds)
                  //                         ?.toDouble() ??
                  //                         0,
                  //                     max: duration.inSeconds.toDouble(),
                  //                     min: 0,
                  //                     onChanged: (val) {
                  //                       BlocProvider.of<SongControlBloc>(
                  //                           context)
                  //                           .seekTo(Duration(
                  //                           seconds: val.toInt()));
                  //                     })
                  //               ))
                  //         ],
                  //       );
                  //
                  //
                  //     }else{
                  //       return const SizedBox();
                  //     }
                  //   }
                  // )),
                  StreamBuilder<PositionData>(
                    stream: _positionDataStream,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        duration: positionData?.duration ?? Duration.zero,
                        position: positionData?.position ?? Duration.zero,
                        bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                        onChangeEnd: player.seek,
                      );
                    },
                  ),
                  Flexible(
                      flex: 2,
                      child: Row(
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
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 const SkipPrevious(),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              // IconButton(
              //     padding: const EdgeInsets.all(1),
              //     onPressed: (){
              //       player.play;
              //       // if (state is SongPausedState) {
              //       //   BlocProvider.of<SongControlBloc>(
              //       //       context)
              //       //       .add(ResumeSong());
              //       // } else {
              //       //   BlocProvider.of<SongControlBloc>(
              //       //       context)
              //       //       .add(PauseSong());
              //       // }
              //     },
              //     icon: Container(
              //         padding: const EdgeInsets.symmetric(
              //             vertical: 12, horizontal: 20),
              //         decoration: BoxDecoration(
              //             borderRadius:
              //             BorderRadius.circular(16),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black
              //                     .withOpacity(0.1),
              //                 offset: const Offset(
              //                   1.0,
              //                   1.0,
              //                 ),
              //                 blurRadius: 10.0,
              //                 spreadRadius: 7.0,
              //               ),
              //               BoxShadow(
              //                   color: Colors.white30
              //                       .withOpacity(0.3),
              //                   spreadRadius: 0),
              //             ]),
              //         child:
              //         // state is SongPlayedState
              //         //     ? const Icon(Icons.pause)
              //         //     :
              //         const Icon(
              //             Icons.play_arrow_rounded))),
              //                 // BlocBuilder<SongControlBloc, SongControlState>(
              //                 //   buildWhen: (previous, current) {
              //                 //     if (previous is SongPlayedState &&
              //                 //         current is SongPlayedState) {
              //                 //       return false;
              //                 //     } else {
              //                 //       return true;
              //                 //     }
              //                 //   },
              //                 //   builder: (context, state) {
              //                 //     return
              //                 //   },
              //                 // ),
              //                 const SizedBox(
              //                   width: 10,
              //                 ),
              //                 const SkipNext()
              //               ],
              //             ),
                          ControlButtons(player),
                          const Spacer(),
                          Column(
                            children: [
                              RepeatButton(loop: loop),
                              const Spacer(),
                              const DownloadButton()
                            ],
                          )
                        ],
                      )),
                  const Spacer(),
                  const Flexible(flex: 4, child: AllSongsList())
                ],
              ),
            ),
          ),
        )
      //   BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
      //       listener: (context, state) {
      //         context.read<SongControlBloc>().add(PlaySong(
      //             songId: context.read<CurrentSelectedSongBloc>().currentSelectedSongId!,
      //             songFile: context.read<CurrentSelectedSongBloc>().currentSelectedSongFile!,
      //             songImage: context.read<CurrentSelectedSongBloc>().currentSelectedSongImage!,
      //             songName: context.read<CurrentSelectedSongBloc>().currentSelectedSongName!));
      //         // context.read<AudioControlBloc>().add(UpdateSeekPositionDuration());
      //         // context.read<AudioControlBloc>().add(UpdateTimeDuration());
      //       },
      //       builder: (context, state) {
      //
      //         // audioPlayer.onDurationChanged.listen((Duration d) {
      //         //   // songSecond = double.parse(d.inSeconds.toString());
      //         //   songEndMinute = d.inSeconds~/ 60;
      //         //   songEndSecond = ((d.inSeconds) % 60).toString().padLeft(2, '0');
      //         // });
      //
      //
      //     if (state is LoadingNewSong) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (state is SelectedSongFetched) {
      //
      //       var songName = state.songName;
      //       var songFile = state.songFile;
      //       var songSingerName = state.singerName;
      //       var songImage = state.songImage;
      //
      //       BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: songName));
      //       // BlocProvider.of<SongDurationBloc>(context)
      //       //     .add(GetSongDurationEvent(songFilePath: songFile, audioPlayer: audioPlayer));
      //
      //       return BlocBuilder<SongDurationBloc, SongDurationState>(
      //       builder: (context, state) {
      //     return Container(
      //       height: double.infinity,
      //       margin: EdgeInsets.only(
      //           right: MediaQuery.of(context).size.width * 0.05,
      //           left: MediaQuery.of(context).size.width * 0.05),
      //       decoration: BoxDecoration(
      //         gradient: const LinearGradient(
      //           colors: [Colors.purple, Colors.black],
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomCenter,
      //         ),
      //         image: DecorationImage(
      //           image: NetworkImage(songImage),
      //           fit: BoxFit.fitHeight,
      //           colorFilter: ColorFilter.mode(
      //               Colors.black.withOpacity(0.2), BlendMode.dstATop),
      //         ),
      //       ),
      //       child: BackdropFilter(
      //         filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      //         child: SafeArea(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Flexible(
      //                 flex: 2,
      //                 child: CustomAppBar(
      //                   title: "Now Playing",
      //                   singerName: songName,
      //                   haveMenuButton: true,
      //                 ),
      //               ),
      //               Flexible(
      //                 flex: 1,
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Expanded(
      //                       flex: 10,
      //                       child: Text(
      //                         songSingerName,
      //                         style: const TextStyle(
      //                             fontSize: 15, color: Colors.grey),
      //                       ),
      //                     ),
      //                     Expanded(
      //                       flex: 1,
      //                       child: LikeButton(
      //                         name: songName,
      //                         isIcon: true,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Flexible(
      //                 flex: 8,
      //                 child: CircularSeekBar(
      //                   width: double.infinity,
      //                   height: 350,
      //                   progress: 100,
      //                   barWidth: 8,
      //                   startAngle: 45,
      //                   sweepAngle: 270,
      //                   strokeCap: StrokeCap.butt,
      //                   progressGradientColors: const [
      //                     Colors.blue,
      //                     Colors.indigo,
      //                     Colors.purple
      //                   ],
      //                   dashWidth: 1,
      //                   dashGap: 2,
      //                   animation: true,
      //                   animDurationMillis: 10000,
      //
      //                   child: Container(
      //                     margin: const EdgeInsets.all(20),
      //                     decoration: BoxDecoration(
      //                         color: Colors.amber,
      //                         shape: BoxShape.circle,
      //                         image: DecorationImage(
      //                             image: NetworkImage(songImage),
      //                             fit: BoxFit.fitHeight)),
      //                   ),
      //                   // maxProgress: 120,
      //                   // minProgress: 0,
      //                 ),
      //               ),
      //               // StreamBuilder(
      //               //     stream: BlocProvider.of<SongControlBloc>(context).positionStream,
      //               //   builder: ((context, snapshot) {
      //               //     audioPlayer.setSourceUrl(songFile);
      //               //
      //               //     if (snapshot.hasData) {
      //               //       Duration? duration = snapshot.data;
      //               //       return Column(
      //               //         children: [
      //               //           Padding(
      //               //               padding:
      //               //               const EdgeInsets.symmetric(horizontal: 70.0),
      //               //               child: Row(
      //               //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               //                 children: [
      //               //                   Row(
      //               //                     children: [
      //               //                       Text((duration!.inMinutes)
      //               //                           .toString()
      //               //                           .padLeft(2, '0')),
      //               //                       const Text(":"),
      //               //                       Text((calculateSecondTimer(duration))
      //               //                           .toString()
      //               //                           .padLeft(2, '0'))
      //               //                     ],
      //               //                   ),
      //               //                   Row(
      //               //                     children: [
      //               //                       Text(songEndMinute.toString()),
      //               //                       const Text(":"),
      //               //                       Text(songEndSecond)
      //               //                     ],
      //               //                   )
      //               //                 ],
      //               //               )),
      //               //           SliderTheme(
      //               //               data: SliderTheme.of(context).copyWith(
      //               //                   thumbShape: const RoundSliderThumbShape(
      //               //                       enabledThumbRadius: 5)),
      //               //               child: SizedBox(
      //               //                 width: MediaQuery.of(context).size.width / 1.5,
      //               //                 child: Slider(
      //               //                   // activeColor: Colors.purple,
      //               //                   // inactiveColor: Colors.black,
      //               //                     value: (snapshot.data?.inSeconds)
      //               //                         ?.toDouble() ??
      //               //                         0,
      //               //                     max: duration.inSeconds.toDouble(),
      //               //                     min: 0,
      //               //                     onChanged: (val) {
      //               //                       BlocProvider.of<SongControlBloc>(
      //               //                           context)
      //               //                           .seekTo(Duration(
      //               //                           seconds: val.toInt()));
      //               //                     })
      //               //               ))
      //               //         ],
      //               //       );
      //               //
      //               //
      //               //     }else{
      //               //       return const SizedBox();
      //               //     }
      //               //   }
      //               // )),
      //               StreamBuilder<PositionData>(
      //                 stream: _positionDataStream,
      //                 builder: (context, snapshot) {
      //                   final positionData = snapshot.data;
      //                   return SeekBar(
      //                     duration: positionData?.duration ?? Duration.zero,
      //                     position: positionData?.position ?? Duration.zero,
      //                     bufferedPosition:
      //                     positionData?.bufferedPosition ?? Duration.zero,
      //                     onChangeEnd: _player.seek,
      //                   );
      //                 },
      //               ),
      //               Flexible(
      //                   flex: 2,
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       const Column(
      //                         children: [
      //                           RandomPlayButton(),
      //                           Spacer(),
      //                           PlayListButton()
      //                         ],
      //                       ),
      //                       const Spacer(),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           const SkipPrevious(),
      //                           const SizedBox(
      //                             width: 10,
      //                           ),
      //                           BlocBuilder<SongControlBloc, SongControlState>(
      //                             buildWhen: (previous, current) {
      //                               if (previous is SongPlayedState &&
      //                                   current is SongPlayedState) {
      //                                 return false;
      //                               } else {
      //                                 return true;
      //                               }
      //                             },
      //                             builder: (context, state) {
      //                               return IconButton(
      //                                   padding: const EdgeInsets.all(1),
      //                                   onPressed: () async {
      //                                     if (state is SongPausedState) {
      //                                       BlocProvider.of<SongControlBloc>(
      //                                               context)
      //                                           .add(ResumeSong());
      //                                     } else {
      //                                       BlocProvider.of<SongControlBloc>(
      //                                               context)
      //                                           .add(PauseSong());
      //                                     }
      //                                   },
      //                                   icon: Container(
      //                                       padding: const EdgeInsets.symmetric(
      //                                           vertical: 12, horizontal: 20),
      //                                       decoration: BoxDecoration(
      //                                           borderRadius:
      //                                               BorderRadius.circular(16),
      //                                           boxShadow: [
      //                                             BoxShadow(
      //                                               color: Colors.black
      //                                                   .withOpacity(0.1),
      //                                               offset: const Offset(
      //                                                 1.0,
      //                                                 1.0,
      //                                               ),
      //                                               blurRadius: 10.0,
      //                                               spreadRadius: 7.0,
      //                                             ),
      //                                             BoxShadow(
      //                                                 color: Colors.white30
      //                                                     .withOpacity(0.3),
      //                                                 spreadRadius: 0),
      //                                           ]),
      //                                       child: state is SongPlayedState
      //                                           ? const Icon(Icons.pause)
      //                                           : const Icon(
      //                                               Icons.play_arrow_rounded)));
      //                             },
      //                           ),
      //                           const SizedBox(
      //                             width: 10,
      //                           ),
      //                           const SkipNext()
      //                         ],
      //                       ),
      //                       const Spacer(),
      //                       Column(
      //                         children: [
      //                           RepeatButton(loop: loop),
      //                           const Spacer(),
      //                           const DownloadButton()
      //                         ],
      //                       )
      //                     ],
      //                   )),
      //               const Spacer(),
      //               const Flexible(flex: 4, child: AllSongsList())
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   });
      // } else {
      //       return const Center(child: Text('Something went wrong'));
      //     }
      //   })
    );
  }

  int calculateSecondTimer(Duration duration){
    int secondTime = 0;
    if(duration.inSeconds < 60){
      secondTime = duration.inSeconds;
    }else if(duration.inSeconds < 120){
      secondTime = duration.inSeconds-60;
    }else if(duration.inSeconds < 180){
      secondTime = duration.inSeconds-120;
    }else if(duration.inSeconds < 240){
      secondTime = duration.inSeconds-180;
    }else if(duration.inSeconds < 300){
      secondTime = duration.inSeconds-240;
    }else if(duration.inSeconds < 360){
      secondTime = duration.inSeconds-300;
    }else if(duration.inSeconds < 420){
      secondTime = duration.inSeconds-360;
    }else if(duration.inSeconds < 480){
      secondTime = duration.inSeconds-420;
    }else if(duration.inSeconds < 540){
      secondTime = duration.inSeconds-480;
    }else if(duration.inSeconds < 600){
      secondTime = duration.inSeconds-540;
    }
    return secondTime;
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            // showSliderDialog(
            //   context: context,
            //   title: "Adjust volume",
            //   divisions: 10,
            //   min: 0.0,
            //   max: 1.0,
            //   value: player.volume,
            //   stream: player.volumeStream,
            //   onChanged: player.setVolume,
            // );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              // showSliderDialog(
              //   context: context,
              //   title: "Adjust speed",
              //   divisions: 10,
              //   min: 0.5,
              //   max: 1.5,
              //   value: player.speed,
              //   stream: player.speedStream,
              //   onChanged: player.setSpeed,
              // );
            },
          ),
        ),
      ],
    );
  }
}