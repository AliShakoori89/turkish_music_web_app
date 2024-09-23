import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import '../../../../../data/model/album_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../bloc/play_list_bloc/bloc.dart';
import '../../../../bloc/play_list_bloc/state.dart';
import '../../../play_song_page/play_song_page.dart';


class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<PlaylistBloc>(context).add(GetAllMusicInPlaylistEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
        centerTitle: true,
      ),
        body: BlocBuilder<PlaylistBloc, PlaylistState>(builder: (context, state) {

          return ListView.builder(
              scrollDirection: Axis.vertical,
              cacheExtent: 1000,
              itemCount: state.playlistSongs.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){

                    var path = state.playlistSongs[index].fileSource!.substring(0, 4)
                        + "s"
                        + state.playlistSongs[index].fileSource!.substring(4, state.playlistSongs[index].fileSource!.length);

                    // var newPath = path.replaceAll(" ", "%20");

                    print("newPath             "+path);

                    SongDataModel songDataModel = SongDataModel(
                      id : state.playlistSongs[index].id,
                      name: state.playlistSongs[index].name,
                      imageSource: state.playlistSongs[index].imageSource,
                      fileSource: path,
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
                          fileSource: path,
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
                        'pageName': "SingerPage",
                        'albumSongList': playListSongs,
                        'songDataModel': songDataModel,
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white30.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(state
                                          .playlistSongs[index].imageSource
                                          .toString()),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.playlistSongs[index].name!,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.playlistSongs[index].singerName!,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white54
                                    )
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: (){
                              BlocProvider.of<PlaylistBloc>(context).add(
                                  RemoveMusicFromPlaylistEvent(musicID: state.playlistSongs[index].id!));
                              BlocProvider.of<PlaylistBloc>(context).add(RemoveSongIDEvent(songID: state.playlistSongs[index].id!));
                            },
                            icon: Icon(Icons.close,
                            size: 15,))
                      ],
                    ),
                  ),
                );
              });
        })
    );
  }
}
