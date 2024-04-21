import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/download_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/like_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/play_list_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/repeat_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/skip_next_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/skip_previous_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/song_slider.dart';
import '../../../bloc/audio_control/bloc/audio_control_bloc.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/play_box_bloc/event.dart';

class PlayMusicPage extends StatefulWidget {
  const PlayMusicPage({super.key});


  @override
  State<PlayMusicPage> createState() => PlayMusicPageState();
}

class PlayMusicPageState extends State<PlayMusicPage> {

  bool normalize = false;
  bool loop = false;
  double songSecond = 0;
  int songEndMinute = 0 ;
  String songEndSecond = '0';

  int i = 00;


  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
        body: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
            listener: (context, state) {
              context.read<AudioControlBloc>().add(PlaySong(
                  songId: context.read<CurrentSelectedSongBloc>().currentSelectedSongId!,
                  songFile: context.read<CurrentSelectedSongBloc>().currentSelectedSongFile!,
                  songImage: context.read<CurrentSelectedSongBloc>().currentSelectedSongImage!,
                  songName: context.read<CurrentSelectedSongBloc>().currentSelectedSongName!));
              // context.read<AudioControlBloc>().add(UpdateSeekPositionDuration());
              // context.read<AudioControlBloc>().add(UpdateTimeDuration());
            }, builder: (context, state) {
          if (state is LoadingNewSong) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SelectedSongFetched) {

            var songName = state.songName;
            var songFile = state.songFile;

            BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: songName));

            return StreamBuilder(
                stream: BlocProvider
                    .of<AudioControlBloc>(context)
                    .positionStream,
                builder: ((context, snapshot) {
                  audioPlayer.setSourceUrl(songFile);

                  audioPlayer.onDurationChanged.listen((Duration d) {
                    songSecond = double.parse(d.inSeconds.toString());
                    songEndMinute = d.inSeconds~/ 60;
                    songEndSecond = ((d.inSeconds) % 60).toString().padLeft(2, '0');
                  });

                  if (snapshot.hasData) {
                    Duration? duration = snapshot.data;



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
                                  singerName: state.songName,
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
                                            image: NetworkImage(state.songImage),
                                            fit: BoxFit.fitHeight)),
                                  ),
                                  // maxProgress: 120,
                                  // minProgress: 0,
                                ),
                              ),
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text((duration!.inMinutes ).toString().padLeft(2, '0')),
                                            const Text(":"),
                                            Text((calculateSecondTimer(duration)).toString().padLeft(2, '0'))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(songEndMinute.toString()),
                                            const Text(":"),
                                            Text(songEndSecond)
                                          ],
                                        )
                                      ],
                                    )),
                                SliderTheme(
                                  data: SliderTheme.of(context)
                                      .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    child: Slider(
                                        activeColor: Colors.purple,
                                        inactiveColor: Colors.black,
                                        value: (snapshot.data?.inSeconds)?.toDouble() ?? 0,
                                        max: songSecond,
                                        min: 0,
                                        // activeColor: Theme.of(context).colorScheme.background,
                                        onChangeEnd: (value) {},
                                        onChanged: (val) {
                                          BlocProvider.of<AudioControlBloc>(context).seekTo(Duration(seconds: val.toInt()));
                                        }),
                                  ),
                                )
                              ],
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SkipPrevious(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          BlocBuilder<AudioControlBloc, AudioControlState>(
                                            buildWhen: (previous, current) {
                                              if (previous is AudioPlayedState &&
                                                  current is AudioPlayedState) {
                                                return false;
                                              } else {
                                                return true;
                                              }
                                            },
                                            builder: (context, state) {
                                              return IconButton(
                                                  padding: const EdgeInsets.all(1),
                                                  onPressed: () async {
                                                    if (state is AudioPausedState) {
                                                      BlocProvider.of<AudioControlBloc>(
                                                          context).add(ResumeSong());
                                                    } else {
                                                      BlocProvider.of<AudioControlBloc>(
                                                          context).add(PauseSong());
                                                    }
                                                  },
                                                  icon: Container(
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: 12, horizontal: 20),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(16), boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(
                                                              0.1),
                                                          offset: const Offset(
                                                            1.0,
                                                            1.0,
                                                          ),
                                                          blurRadius: 10.0,
                                                          spreadRadius: 7.0,
                                                        ),
                                                        BoxShadow(color: Colors.white30
                                                            .withOpacity(0.3),
                                                            spreadRadius: 0),
                                                      ]),
                                                      child: state is AudioPlayedState
                                                          ? const Icon(Icons.pause)
                                                          : const Icon(
                                                          Icons.play_arrow_rounded)));
                                            },
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const SkipNext()
                                        ],
                                      ),
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
                              const Flexible(
                                  flex: 4,
                                  child: AllSongsList()
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }));
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        }));
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

