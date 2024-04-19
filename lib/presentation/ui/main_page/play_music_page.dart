import 'dart:ui';
import 'package:audio_duration/audio_duration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_box_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/custom_app_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/like_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/random_play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_next_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/skip_previous_button.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/new-song_model.dart';
import '../../bloc/audio_control/bloc/audio_control_bloc.dart';
import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../bloc/is_playing_music_bloc/bloc.dart';
import '../../bloc/is_playing_music_bloc/event.dart';
import '../../bloc/play_box_bloc/event.dart';
import '../../helpers/music_player_component/download_button.dart';
import '../../helpers/widgets/circle_button.dart';

class PlayMusicPage extends StatefulWidget {

  const PlayMusicPage({super.key});

  @override
  State<PlayMusicPage> createState() => PlayMusicPageState();
}

class PlayMusicPageState extends State<PlayMusicPage> {

  bool normalize = false;
  bool loop = false;

  @override
  Widget build(BuildContext context) {

    AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
        body: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
            listener: (context, state) {
              context.read<AudioControlBloc>().add(PlaySong(
                  songId:
                  context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongId!,
                  songFile:
                  context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongFile!,
                  songImage:
                  context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongImage!,
                  songName: context
                      .read<CurrentSelectedSongBloc>()
                      .currentSelectedSongName!));
            }, builder: (context, state) {
          if (state is LoadingNewSong) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SelectedSongFetched) {

            var songName = state.songName;

            BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: songName));

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
                        flex: 6,
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
                      StreamBuilder(
                          stream: BlocProvider.of<AudioControlBloc>(context).positionStream,
                          builder: ((context, snapshot) {

                            AudioPlayer audioPlayer = AudioPlayer();

                            if (snapshot.hasData) {
                              // final currrentDuration = ((state.songFile. ?? 0)).toStringAsPrecision(1);
                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text(AudioDuration.getAudioDuration(state.songFile).toString()), const Text("0.30")],
                                      )),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          })),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Text(
                      //         convertSecondsToReadableString(position.floor())),
                      //     Text(
                      //         convertSecondsToReadableString(duration.floor())),
                      //   ],
                      // ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const RandomPlayButton(),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                splashRadius: 24,
                                onPressed: () {

                                },
                                icon: loop
                                    ? const Icon(
                                  CupertinoIcons.arrow_2_circlepath,
                                  color: Colors.white,
                                  size: 20,
                                )
                                    : const Icon(
                                    CupertinoIcons.arrow_2_circlepath,
                                    color: Colors.grey, size: 20),
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
                          )),
                      Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.08,
                              left: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.08),
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
                      const Spacer(),
                      Flexible(
                          flex: 4,
                          child: BlocBuilder<
                              PlayBoxBloc,
                              PlayBoxState>(
                              builder: (context, state) {

                                return ListView.builder(
                                  itemCount: state.playBoxSong!.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white30.withOpacity(
                                              0.1),
                                          borderRadius: BorderRadius.circular(
                                              15)
                                      ),
                                      margin: const EdgeInsets.only(
                                        top: 15,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            margin: const EdgeInsets.only(
                                                right: 5
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(15),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        state.playBoxSong![index]
                                                            .imageSource),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                          const SizedBox(width: 5,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(state.playBoxSong![index].name,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              Text(state.playBoxSong![index].singer
                                                  .name,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white54
                                                ),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              })

                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        }));
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

