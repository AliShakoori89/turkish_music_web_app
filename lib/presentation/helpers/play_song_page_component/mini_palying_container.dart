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
import '../../../data/model/song_model.dart';
import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
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
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(CheckPlayingSongEvent());
    BlocProvider.of<AlbumBloc>(context).add(GetAlbumAllSongsEvent(albumId: widget.albumID));
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(ReadSongIDForMiniPlayingSongContainerEvent());
    BlocProvider.of<SongBloc>(context).add(FetchSongEvent(songID: widget.songID));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.visibility == true
        ? Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Colors.purple, ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child:
        // BlocBuilder<MiniPlayingContainerBloc, MiniPlayingContainerState>(
        //   builder: (context, state) {

        // int songID = state.songID;
        // print("int songID          "+songID.toString());
        // BlocProvider.of<SongBloc>(context).add(FetchSongEvent(songID: songID));
        // return
        BlocBuilder<AlbumBloc, AlbumState>(
            builder: (context, state) {

              List<AlbumDataMusicModel> album = state.albumAllSongs;

              return BlocBuilder<SongBloc, SongState>(
                  builder: (context, state) {

                    if (state.status.isLoading){
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: LinearProgressIndicator(
                          minHeight: .5,
                        ),
                      );
                    }else
                    if(state.status.isSuccess){
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {

                              SongDataModel songDataModel = SongDataModel(
                                  id : state.song.id!,
                                  name: state.song.name!,
                                  imageSource: state.song.imageSource!,
                                  fileSource: state.song.fileSource!,
                                  minute: state.song.minute,
                                  second: state.song.second,
                                  singerName: state.song.singerName!,
                                  album: null,
                                  albumId: state.song.albumId,
                                  categories: null
                              );

                              Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                    type: PageTransitionType.bottomToTop,
                                    reverseDuration: Duration(milliseconds: 500),
                                    child: Builder(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                          CurrentSelectedSongBloc()
                                            ..add(SelectSong(
                                                songModel:
                                                songDataModel)),
                                          child: PlaySongPage(
                                            songName: songDataModel.name!,
                                            songFile:
                                            songDataModel.fileSource!,
                                            songID: songDataModel.id!,
                                            singerName:
                                            songDataModel.singerName!,
                                            songImage:
                                            songDataModel.imageSource!,
                                            albumID: songDataModel.albumId!,
                                            albumSongList: album,
                                            pageName: "",
                                          ),
                                        )),
                                  ));
                            },
                            child: const TopArrow(),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SingerNameTrackNameImage(
                                      singerName: state.song.singerName!,
                                      songName: state.song.name!,
                                      imagePath: state.song.imageSource!,
                                      align: MainAxisAlignment.start),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: PlayButton(),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }else if(state.status.isError){
                      return Center(
                        child: Text("error"),
                      );
                    }
                    return Center(
                      child: Text("error"),
                    );
                  }
              );
            }
          // );}
        )
    )
        : CircularProgressIndicator();
  }
}
