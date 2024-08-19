import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/state.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/previous_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page.dart';
import '../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../bloc/mini_playing_container_bloc/event.dart';
import '../widgets/singer_name_trackName_image.dart';
import '../widgets/top_arrow_icon.dart';
import 'next_button.dart';

class MiniPlayingContainer extends StatefulWidget {

  MiniPlayingContainer({super.key,
  required this.visibility, required this.songID, required this.albumID});

  final bool visibility;
  final int songID ;
  final int albumID ;

  @override
  State<MiniPlayingContainer> createState() => _MiniPlayingContainerState();
}

class _MiniPlayingContainerState extends State<MiniPlayingContainer> {

  @override
  void initState() {
    // TODO: implement initState
    print("#############              "+widget.songID.toString());
    print("#############              "+widget.albumID.toString());
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(CheckPlayingSongEvent());
    BlocProvider.of<SongBloc>(context).add(FetchSongEvent(songID: widget.songID));
    BlocProvider.of<AlbumBloc>(context).add(GetAlbumAllSongsEvent(albumId: widget.albumID));
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
          child: BlocBuilder<AlbumBloc, AlbumState>(
              builder: (context, state) {

                List<AlbumDataMusicModel> album = state.albumAllSongs;

                return BlocBuilder<SongBloc, SongState>(
                    builder: (context, state) {

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.linear,
                                  type: PageTransitionType.bottomToTop,
                                  child: PlaySongPage(
                                    singerName: state.song.singerName!,
                                    songFile: state.song.fileSource!,
                                    songID: state.song.id!,
                                    songImage: state.song.imageSource!,
                                    songName: state.song.name!,
                                    albumID: album[0].id,
                                    albumSongList: album,
                                    pageName: '',
                                  ),
                                ),
                              );
                            },
                            child: const TopArrow(),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Expanded(
                                //   flex: 1,
                                //   child: SingerNameTrackNameImage(
                                //       singerName: "",
                                //       songName: state.song.name!,
                                //       imagePath: state.song.imageSource!,
                                //       align: MainAxisAlignment.start),
                                // ),
                                Expanded(
                                  flex: 1,
                                  child: PlayButton(),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                );
              }
          )))
        : Container();
  }
}
