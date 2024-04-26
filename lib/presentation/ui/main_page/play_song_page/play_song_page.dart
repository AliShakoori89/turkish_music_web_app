import 'dart:ui';
import 'package:audio_session/audio_session.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/get_core.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/circular_seekbar.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/control_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/download_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/like_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/media_buttons.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/play_list_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/position_data.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/repeat_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/song_slider.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/play_box_bloc/bloc.dart';
import '../../../bloc/play_box_bloc/event.dart';
import '../../../bloc/song_control_bloc/bloc/song_control_bloc.dart';
import '../../../helpers/widgets/custom_app_bar.dart';
import 'package:just_audio/just_audio.dart';


class PlayMusicPage extends StatefulWidget {

  final String songName;
  final String songFile;
  final String songImage;
  final String songSingerName;
  final int songID;
  const PlayMusicPage({super.key, required this.songFile,
    required this.songName, required this.songImage,
    required this.songSingerName, required this.songID});


  @override
  State<PlayMusicPage> createState() => PlayMusicPageState();
}

class PlayMusicPageState extends State<PlayMusicPage> with WidgetsBindingObserver {

  bool loop = false;

  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));

    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {

    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
        });
    try {
      String songFile = widget.songFile.substring(0, 4) + "s" + widget.songFile.substring(4, widget.songFile.length);
      await player.setAudioSource(AudioSource.uri(Uri.parse(
          songFile
      )));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
      // player.play();
  }

  @override
  void dispose() {
    // player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // player.stop();
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

    return Scaffold(
        body: Container(
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
                    child: CustomCircularSeekBar(songImage: widget
                        .songImage),
                  ),
                  SongSlider(positionDataStream: _positionDataStream,
                      player: player),
                  SizedBox(height: 15,),
                  Flexible(
                      flex: 2,
                      child: MediaButtons(player: player, loop: loop,)),
                  const Spacer(),
                  const Flexible(
                      flex: 4, child: AllSongsList())
                ],
              ),
            ),
          ),
        )

    );
  }
}