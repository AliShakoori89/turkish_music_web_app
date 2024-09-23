import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/play_button_state_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/song_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/event.dart';
import '../../../bloc/play_button_state_bloc/event.dart';
import '../../../helpers/widgets/singer_name_trackName_image.dart';
import '../../../helpers/widgets/top_arrow_icon.dart';

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
    BlocProvider.of<PlayButtonStateBloc>(context).add(GetPlayButtonStateEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return widget.visibility == true
        ? Container(
        width: double.infinity,
        // height: widget.orientation == Orientation.portrait
        //     ? MediaQuery.of(context).size.height * 0.1
        //     : width < 700
        //     ? MediaQuery.of(context).size.height / 5.07
        //     : MediaQuery.of(context).size.height / 6.5,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Colors.purple, ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: BlocBuilder<AlbumBloc, AlbumState>(
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

                              var path = state.song.fileSource!.substring(0, 4)
                                  + "s"
                                  + state.song.fileSource!.substring(4, state.song.fileSource?.length);

                              SongDataModel songDataModel = SongDataModel(
                                id : state.song.id,
                                name: state.song.name,
                                imageSource: state.song.imageSource,
                                fileSource: path,
                                minute: state.song.minute,
                                second: state.song.second,
                                singerName: state.song.singerName,
                                album: null,
                                albumId: state.song.albumId,
                                categories: null,
                              );

                              context.push(
                                '/'+PlaySongPage.routeName,
                                extra: {
                                  'songName': songDataModel.name,
                                  'songFile': path,
                                  'songID': songDataModel.id!,
                                  'singerName': songDataModel.singerName,
                                  'songImage': songDataModel.imageSource!,
                                  'albumID': songDataModel.albumId!,
                                  'pageName': "SingerPage",
                                  'albumSongList': album,
                                  'songDataModel': songDataModel,
                                },
                              );

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
                                    align: MainAxisAlignment.start,
                                  ),
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
        : Container();
  }
}
