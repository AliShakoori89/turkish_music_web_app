import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/song_card.dart';
import '../../../../../data/model/album_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../bloc/play_list_bloc/bloc.dart';
import '../../../../bloc/play_list_bloc/state.dart';
import '../../../../const/custom_indicator.dart';
import '../../../../const/generate_new_path.dart';
import '../../../play_song_page/play_song_page.dart';


class PlaylistPage extends StatefulWidget {

  static String routeName = "PlaylistPage";

  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {

  @override
  void initState() {
    super.initState();
    context.read<PlaylistBloc>().add(GetAllMusicInPlaylistEvent());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Playlist"),
        centerTitle: true,
      ),
        body: Container(
          margin: EdgeInsets.only(
            left: 5,
            right: 5
          ),
          child: BlocBuilder<PlaylistBloc, PlaylistState>(builder: (context, state) {

            if(state.status.isLoading){
              return CustomIndicator();
            }else if(state.status.isSuccess){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  cacheExtent: 1000,
                  itemCount: state.playlistSongs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){

                        var newPath = state.playlistSongs[index].fileSource!.replaceAll(" ", "%20");

                        SongDataModel songDataModel = SongDataModel(
                          id : state.playlistSongs[index].id,
                          name: state.playlistSongs[index].name,
                          imageSource: state.playlistSongs[index].imageSource,
                          fileSource: newPath,
                          minute: state.playlistSongs[index].minute,
                          second: state.playlistSongs[index].second,
                          singerName: state.playlistSongs[index].singerName,
                          album: null,
                          albumId: state.playlistSongs[index].albumId,
                          categories: null,
                        );

                        List<AlbumDataMusicModel> playListSongs = [];
                        for(int i = 0 ; i < state.playlistSongs.length; i++){

                          AlbumDataMusicModel albumDataMusicModel = AlbumDataMusicModel(
                              id: state.playlistSongs[i].id,
                              name: state.playlistSongs[i].name,
                              imageSource: state.playlistSongs[i].imageSource,
                              fileSource: state.playlistSongs[i].fileSource!.replaceAll(" ", "%20"),
                              singerName: state.playlistSongs[i].singerName,
                              categories: null,
                              album: null,
                              albumId: state.playlistSongs[i].albumId,
                              second: state.playlistSongs[i].second,
                              minute:state.playlistSongs[i].minute
                          );

                          playListSongs.add(albumDataMusicModel);
                        }



                        context.push(
                          '/'+PlaySongPage.routeName,
                          extra: {
                            'songName': songDataModel.name,
                            'songFile': songDataModel.fileSource,
                            'songID': songDataModel.id!,
                            'singerName': songDataModel.singerName,
                            'songImage': songDataModel.imageSource!,
                            'albumID': songDataModel.albumId!,
                            'pageName': "PlaylistPage",
                            'albumSongList': playListSongs,
                            'songDataModel': songDataModel,
                            'categoryID': 0
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black87,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0.5),
                                  color: Colors.purple.withValues(alpha: 0.5),
                              )
                            ]),
                        margin: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Stack(
                          children: [
                            SongCard(
                              songName: state.playlistSongs[index].name!,
                              imgPath: state.playlistSongs[index].imageSource!,
                              singerName: state.playlistSongs[index].singerName!,),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: (){
                                    BlocProvider.of<PlaylistBloc>(context).add(
                                        RemoveMusicFromPlaylistEvent(musicID: state.playlistSongs[index].id!));
                                    BlocProvider.of<PlaylistBloc>(context).add(RemoveSongIDEvent(songID: state.playlistSongs[index].id!));
                                  },
                                  icon: Icon(Icons.close,
                                    size: 15,)),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }else if(state.status.isError){
              return Center(
                child: Text("Error"),
              );
            }
            return Container();
          }),
        )
    );
  }
}
