import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/circular_seekbar.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/like_button.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page_component/media_buttons.dart';
import '../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../bloc/play_box_bloc/bloc.dart';
import '../../../bloc/play_box_bloc/event.dart';
import '../../../bloc/song_control_bloc/bloc/song_control_bloc.dart';
import '../../../helpers/widgets/custom_app_bar.dart';

class PlayMusicPage extends StatelessWidget {

  // final String songName;
  // final String songFile;

  // PlayMusicPage({super.key, required this.songName, required this.songFile});


//   @override
//   State<PlayMusicPage> createState() => PlayMusicPageState();
// }
//
// class PlayMusicPageState extends State<PlayMusicPage> with WidgetsBindingObserver {
// //
//   bool loop = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));
//   }

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
              print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");

              if (state is LoadingNewSong) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SelectedSongFetched) {

                print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");

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
                          CustomCircularSeekBar(
                            songImage: state.songImage,
                          ),
                          // SongSlider(positionDataStream: _positionDataStream,
                          //     player: audioPlayer),
                          // StreamBuilder(
                          //     stream: BlocProvider.of<SongControlBloc>(context).positionStream,
                          //     builder: ((context, snapshot) {
                          //       if (snapshot.hasData) {
                          //         final secondCurrentDuration = (snapshot.data?.inSeconds ?? 0).toStringAsPrecision(2);
                          //         final minuteCurrentDuration = (snapshot.data?.inMinutes ?? 0).toStringAsPrecision(2);
                          //         return Column(
                          //           children: [
                          //             Padding(
                          //                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          //                 child: Row(
                          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Row(
                          //                       children: [
                          //                         Text(minuteCurrentDuration),
                          //                         Text(":"),
                          //                         Text(secondCurrentDuration),
                          //                       ],
                          //                     ),
                          //                     Text("${snapshot.data?.inSeconds}")],
                          //                 )),
                          //             // SliderTheme(
                          //             //   data: SliderTheme.of(context)
                          //             //       .copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5)),
                          //             //   child: Slider(
                          //             //       value: _position.inSeconds.toDouble(),
                          //             //       min: 0.0,
                          //             //       max: _duration.inSeconds.toDouble(),
                          //             //       onChanged: (double value) {
                          //             //         setState(() {
                          //             //           seekToSecond(value.toInt());
                          //             //           value = value;
                          //             //         });}),
                          //             // )
                          //           ],
                          //         );
                          //       } else {
                          //         return const SizedBox();
                          //       }
                          //     })),
                          SizedBox(height: 15,),
                          Flexible(
                              flex: 2,
                              child:
                              MediaButtons(
                                  // player: player,
                                  loop: true)
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