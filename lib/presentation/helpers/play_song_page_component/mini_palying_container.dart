import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/previous_button.dart';
import '../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../bloc/mini_playing_container_bloc/event.dart';
import '../widgets/singer_name_trackName_image.dart';
import '../widgets/top_arrow_icon.dart';
import 'next_button.dart';

class MiniPlayingContainer extends StatefulWidget {
  const MiniPlayingContainer({super.key, required this.visibility});

  final bool visibility;

  @override
  State<MiniPlayingContainer> createState() => _MiniPlayingContainerState();
}

class _MiniPlayingContainerState extends State<MiniPlayingContainer> {

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(CheckPlayingSongEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.visibility == true
        ? Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.black, Colors.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) =>
                  //       PlayMusicPage(
                  //         imagePath: state.singerImage,
                  //         singerName: state.singerName,
                  //         musicFile: state.musicFile,
                  //         musicFiles: [],
                  //       )),
                  // );
                },
                child: const TopArrow(),
              ),
              Container(
                margin: EdgeInsets.only(left: 45, right: 45),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          SingerNameTrackNameImage(
                              singerName: "Tarkan",
                              songName: "MoOooooOoch",
                              imagePath: "assets/images/tarkan.png",
                              align: MainAxisAlignment.start),
                        ]),
                    Row(
                      children: [
                        PreviousButton(),
                        PlayButton(),
                        NextButton()
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    )
        : Container();
  }
}
