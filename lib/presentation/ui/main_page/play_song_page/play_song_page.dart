import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/circular_seekbar.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/play_box_bloc/bloc.dart';
import '../../../bloc/play_box_bloc/event.dart';
import '../../../bloc/song_bloc/bloc.dart';
import '../../../bloc/song_control_bloc/bloc/audio_control_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
            listener: (context, state) {

              context
                  .read<AudioControlBloc>()
                  .add(PlaySong(currentSong: context.read<CurrentSelectedSongBloc>().currentSelectedSong!));
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
                      image: NetworkImage(state.songModel.imageSource!),
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
                          // Flexible(
                          //   flex: 2,
                          //   child: CustomAppBar(
                          //     title: "Now Playing",
                          //     singerName: state.songModel.album!.singer!.name!,
                          //     haveMenuButton: true,
                          //   ),
                          // ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    state.songModel.name!,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: LikeButton(
                                //     name: state.songModel.songName!,
                                //     isIcon: true,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          CustomCircularSeekBar(
                            songImage: state.songModel.imageSource!,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              BlocBuilder<SongBloc, SongState>(
                              builder: (context, state) {
                                return                               IconButton(
                                    padding: const EdgeInsets.all(1),
                                    // style: AppTheme.lightTheme.iconButtonTheme.style,
                                    onPressed: () {
                                      context
                                          .read<CurrentSelectedSongBloc>()
                                          .add(PlayPreviousSong(songs: state.songDetail!));
                                    },
                                    icon: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            offset: const Offset(
                                              1.0,
                                              1.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 7.0,
                                          ),
                                          const BoxShadow(color: Colors.white, spreadRadius: 0),
                                        ]),
                                        child: const Icon(Icons.skip_previous_rounded)));
                              }),
                              BlocBuilder<AudioControlBloc, AudioControlState>(
                                buildWhen: (previous, current) {
                                  print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");

                                  if (previous is AudioPlayedState && current is AudioPlayedState) {
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
                                          BlocProvider.of<AudioControlBloc>(context).add(ResumeSong());
                                        } else {
                                          BlocProvider.of<AudioControlBloc>(context).add(PauseSong());
                                        }
                                      },
                                      icon: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              offset: const Offset(
                                                1.0,
                                                1.0,
                                              ),
                                              blurRadius: 10.0,
                                              spreadRadius: 7.0,
                                            ),
                                            const BoxShadow(color: Colors.white, spreadRadius: 0),
                                          ]),
                                          child: state is AudioPlayedState
                                              ? const Icon(Icons.pause)
                                              : const Icon(Icons.play_arrow_rounded)));
                                },
                              ),

                              BlocBuilder<SongBloc, SongState>(
                              builder: (context, state) {
                                return IconButton(
                                    padding: const EdgeInsets.all(1),
                                    onPressed: () {
                                      context
                                          .read<CurrentSelectedSongBloc>()
                                          .add(PlayNextSong(songs: state.songDetail ?? []));
                                    },
                                    icon: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            offset: const Offset(
                                              1.0,
                                              1.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 7.0,
                                          ),
                                          const BoxShadow(color: Colors.white, spreadRadius: 0),
                                        ]),
                                        child: const Icon(Icons.skip_next_rounded)));

                              })
                            ],
                          ),
                          SizedBox(height: 15,),
                          const Spacer(),
                          const Flexible(
                              flex: 4, child: AllSongsList())
                        ],
                      ),
                    ),
                  ),
                );
              } else {
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