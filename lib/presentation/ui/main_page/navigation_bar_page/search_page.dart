import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_page/search_page.dart';
import 'package:searchfield/searchfield.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import '../../../../data/model/search_model.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/song_bloc/bloc.dart';
import '../../../bloc/song_bloc/event.dart';
import '../../../bloc/song_bloc/state.dart';
import '../../../bloc/song_control_bloc/audio_control_bloc.dart';
import '../../play_song_page/play_song_page.dart';

class SearchPage extends StatefulWidget {

  static String routeName = "SearchPage";

  @override
  State<SearchPage> createState() => _searchPageState();
}

class _searchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{

  final songCharController = TextEditingController();
  final albumCharController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent(char: ""));
    BlocProvider.of<AlbumBloc>(context).add(GetAllAlbumEvent(char: ""));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {

          List<SongDataModel> allSong = state.allSongList;
          Orientation orientation = MediaQuery.of(context).orientation;

          return BlocBuilder<AlbumBloc, AlbumState>(
              builder: (context, state) {

                List<AlbumDataModel> allAlbum = state.allAlbum;

                List<SearchFieldListItem<dynamic>> combinedList = [
                  ...allAlbum.map((album) => SearchFieldListItem<dynamic>(
                    album.name!,
                    item: album,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {

                          var path = album.musics![0].fileSource!.substring(0, 4)
                              + "s"
                              + album.musics![0].fileSource!.substring(4, album.musics![0].fileSource?.length);

                          var newPath = path.replaceAll(" ", "%20");

                          // print(album.imageSource);
                          // print("https://api.turkishmusicapi.ir/TurkishMusicFiles/"+newPath);
                          // print(album.musics![0].id);
                          // print(album.musics![0].name);
                          // print(album.musics![0].minute);
                          // print(album.musics![0].second);
                          // print(album.singer!.name);

                          SongDataModel songDataModel = SongDataModel(
                            id : album.musics![0].id,
                            name: album.musics![0].name,
                            imageSource: album.imageSource,
                            fileSource: newPath,
                            minute: album.musics![0].minute,
                            second: album.musics![0].second,
                            singerName: album.singer!.name,
                            album: null,
                            albumId: album.id,
                            categories: null,
                          );

                          context.push(
                            '/'+PlaySongPage.routeName,
                            extra: {
                              'songName': songDataModel.name,
                              'songFile': newPath,
                              'songID': songDataModel.id!,
                              'singerName': songDataModel.singerName,
                              'songImage': album.imageSource,
                              'albumID': songDataModel.albumId!,
                              'pageName': "SingerPage",
                              'albumSongList': album.musics!,
                              'songDataModel': songDataModel,
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                album.imageSource != null
                                    ? CircleAvatar(backgroundImage: NetworkImage(album.imageSource!))
                                    : Image.asset("assets/images/no-image.png"),
                                SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 1, child: Text(album.name!)),
                                    Expanded(
                                      flex: 1,
                                      child: Text(album.singer!.name!, style: TextStyle(color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text("Album",
                            style: TextStyle(
                              color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                  ...allSong.map((song) => SearchFieldListItem<dynamic>(
                    song.name!,
                    item: song,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          var path = song.fileSource!.substring(0, 4)
                              + "s"
                              + song.fileSource!.substring(4, song.fileSource!.length);

                          var newPath = path.replaceAll(" ", "%20");

                          print(song.fileSource!);
                          print(newPath);
                          print(song.imageSource);

                          // SongDataModel songDataModel = SongDataModel(
                          //   id : song.id,
                          //   name: song.name,
                          //   imageSource: song.imageSource,
                          //   fileSource: newPath,
                          //   minute: song.minute,
                          //   second: song.second,
                          //   singerName: song.singerName,
                          //   album: null,
                          //   albumId: song.id,
                          //   categories: null,
                          // );
                          //
                          // context.push(
                          //   '/'+PlaySongPage.routeName,
                          //   extra: {
                          //     'songName': songDataModel.name,
                          //     'songFile': newPath,
                          //     'songID': songDataModel.id!,
                          //     'singerName': songDataModel.singerName,
                          //     'songImage': songDataModel.imageSource!,
                          //     'albumID': songDataModel.albumId!,
                          //     'pageName': "SearchPage",
                          //     'albumSongList': <AlbumDataMusicModel>[],
                          //     'songDataModel': songDataModel,
                          //   },
                          // );
                        },
                        child: Row(
                          children: [
                            song.imageSource != null
                                ? CircleAvatar(backgroundImage: NetworkImage(song.imageSource!))
                                : Image.asset("assets/images/no-image.png"),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 1, child: Text(song.name!)),
                                Expanded(
                                  flex: 1,
                                  child: Text(song.singerName!, style: TextStyle(color: Colors.grey)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ];

                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text('Search Page',
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                  ),
                  body: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20
                        ),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: SearchField(
                              controller: songCharController,
                              hint: "Enter song or album name",
                              itemHeight: 70,
                              scrollbarDecoration: ScrollbarDecoration(
                                thumbColor: Colors.purple
                              ),
                              suggestions: combinedList,
                            )
                        ),
                      )
                  ),
                );
            }
          );

        });
  }
}