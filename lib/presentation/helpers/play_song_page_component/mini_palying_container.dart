import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/previous_button.dart';
import '../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../bloc/mini_playing_container_bloc/event.dart';
import '../widgets/singer_name_trackName_image.dart';
import '../widgets/top_arrow_icon.dart';
import 'next_button.dart';

class MiniPlayingContainer extends StatefulWidget {

  MiniPlayingContainer({super.key,
  required this.visibility});

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
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
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
              BlocBuilder<MiniPlayingContainerBloc, MiniPlayingContainerState>(builder: (context, state) {

                List requirement = state.requirement;

                return Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SingerNameTrackNameImage(
                            singerName: requirement[3],
                            songName: requirement[0],
                            imagePath: requirement[2],
                            align: MainAxisAlignment.start),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            PreviousButton(pageName: requirement[4]),
                            PlayButton(),
                            NextButton(pageName: requirement[4],)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          )),
    )
        : Container();
  }
}
