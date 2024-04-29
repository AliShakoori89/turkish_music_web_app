import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart' as justAudio;
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/like_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/media_buttons.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/play_box_bloc/bloc.dart';
import '../../../bloc/play_box_bloc/event.dart';
import '../../../bloc/song_control_bloc/bloc/song_control_bloc.dart';
import '../../../helpers/widgets/custom_app_bar.dart';

class PlayMusicPage extends StatefulWidget {

  final String songName;
  final String songFile;

  PlayMusicPage({super.key, required this.songName, required this.songFile});


  @override
  State<PlayMusicPage> createState() => PlayMusicPageState();
}

class PlayMusicPageState extends State<PlayMusicPage> with WidgetsBindingObserver {
//
  bool loop = false;

  bool loaded = false;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));
    // initPlayer();
    // ambiguate(WidgetsBinding.instance)!.addObserver(this);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    // _init();
  }

  void initPlayer(){
    advancedPlayer = AudioPlayer();

    advancedPlayer.onDurationChanged.listen((Duration d) {
      _duration = d;
      print('Max duration: $d');
    });

    advancedPlayer.onPositionChanged.listen((Duration p) {
      _position = p;
      print('Max duration: $p');
    });
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  // Future<void> _init() async {
  //
  //   final session = await AudioSession.instance;
  //   await session.configure(const AudioSessionConfiguration.speech());
  //   // Listen to errors during playback.
  //   audioPlayer.playbackEventStream.listen((event) {},
  //       onError: (Object e, StackTrace stackTrace) {
  //       });
  //   // try {
  //   //   String songFile = widget.songFile.substring(0, 4) + "s" + widget.songFile.substring(4, widget.songFile.length);
  //   //   await player.setAudioSource(AudioSource.uri(Uri.parse(
  //   //       songFile
  //   //   )));
  //   // } on PlayerException catch (e) {
  //   //   print("Error loading audio source: $e");
  //   // }
  //     // player.play();
  // }

  // @override
  // void dispose() {
  //   // player.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused) {
  //     // player.stop();
  //   }
  // }

  // Stream<PositionData> get _positionDataStream =>
  //     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //         audioPlayer.positionStream,
  //         audioPlayer.bufferedPositionStream,
  //         audioPlayer.durationStream,
  //             (position, bufferedPosition, duration) => PositionData(
  //             position, bufferedPosition, duration ?? Duration.zero));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
            listener: (context, state) {

              context
                  .read<SongControlBloc>()
                  .add(PlaySong(
                  songId: context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongId!,
                  songName: context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongName!,
                  songImage: context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongImage!,
                  songFile: changeFilePath(context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongFile!)
              ));
            },
            builder: (context, state) {

              if (state is LoadingNewSong) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SelectedSongFetched) {
                return Container(
                  height: double.infinity,
                  margin: EdgeInsets.only(
                      right: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05,
                      left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(state.songImage),
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
                              singerName: state.singerName,
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
                                    state.singerName,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: LikeButton(
                                    name: state.songName,
                                    isIcon: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SongSlider(positionDataStream: _positionDataStream,
                          //     player: audioPlayer),
                          StreamBuilder(
                              stream: BlocProvider.of<SongControlBloc>(context).positionStream,
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  final secondCurrentDuration = (snapshot.data?.inSeconds ?? 0).toStringAsPrecision(2);
                                  final minuteCurrentDuration = (snapshot.data?.inMinutes ?? 0).toStringAsPrecision(2);
                                  return Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(minuteCurrentDuration),
                                                  Text(":"),
                                                  Text(secondCurrentDuration),
                                                ],
                                              ),
                                              Text("${snapshot.data?.inSeconds}")],
                                          )),
                                      SliderTheme(
                                        data: SliderTheme.of(context)
                                            .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                                        child: Slider(
                                            value: _position.inSeconds.toDouble(),
                                            min: 0.0,
                                            max: _duration.inSeconds.toDouble(),
                                            onChanged: (double value) {
                                              setState(() {
                                                seekToSecond(value.toInt());
                                                value = value;
                                              });}),
                                      )
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              })),
                          SizedBox(height: 15,),
                          Flexible(
                              flex: 2,
                              child:
                              MediaButtons(
                                  // player: player,
                                  loop: loop)
                          ),
                          const Spacer(),
                          const Flexible(
                              flex: 4, child: AllSongsList())
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                print("44444444444444444444444444444444");
                return const Center(child: Text('Something went wrong'));
              }
            }
        )
    );
  }

  changeFilePath(String path){
    String songFile = path.substring(0, 4) + "s" + path.substring(4, path.length);
    return songFile;
  }
}