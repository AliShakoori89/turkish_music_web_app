import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/song_page/song_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/category_model.dart';
import '../../bloc/album_bloc/bloc.dart';
import '../../bloc/album_bloc/event.dart';
import '../../bloc/album_bloc/state.dart';
import '../../bloc/category_bloc/bloc.dart';
import '../../bloc/category_bloc/event.dart';
import '../../bloc/category_bloc/state.dart';
import '../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../bloc/mini_playing_container_bloc/event.dart';
import '../../bloc/mini_playing_container_bloc/state.dart';
import '../../bloc/song_bloc/bloc.dart';
import '../../bloc/song_bloc/event.dart';
import '../../bloc/song_bloc/state.dart';
import '../play_song_page/play_song_page_component/mini_palying_container.dart';

class MainPage extends StatefulWidget {

  static String routeName = "MainPage";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentRoute = 0;
  IconData? icon;

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(ReadSongIDForMiniPlayingSongContainerEvent());


    List myRoutes = [
      Padding(
        padding: EdgeInsets.only(
          // bottom: MediaQuery.of(context).size.height * 0.09 + 50,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.07,
            ),
            child: HomePage(),
          )
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.09 + 50,
        ),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const ProfilePage()
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.09 + 50,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: MusicPage(),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.09,
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SearchPage(),
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: (){
        exit(0);
      },
      child: Scaffold(
          body: Stack(
        children: [
          myRoutes[currentRoute],
          Positioned(
            bottom: 100,
            right: 0,
            child: VerticalNavBar(
              selectedIndex: currentRoute,
              height: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.3
                  : MediaQuery.of(context).size.height * 0.5,
              width: orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.width * 0.12
                  : MediaQuery.of(context).size.width * 0.04,
              backgroundColor: Colors.purple.withOpacity(0.3),
              borderRadius: 15,
              onItemSelected: (value) {
                setState(() {
                  currentRoute = value;
                });
              },
              items: const [
                VerticalNavBarItem(
                  title: Icons.home,
                ),
                VerticalNavBarItem(
                  title: Icons.person,
                ),
                VerticalNavBarItem(
                  title: Icons.music_note,
                ),
                VerticalNavBarItem(
                  title: Icons.search,
                ),
              ],
            ),
          ),
          currentRoute != 3
              ? Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<MiniPlayingContainerBloc, MiniPlayingContainerState>(
                builder: (context, state) {

                  bool visibility = state.visibility;
                  int songID = state.songID;
                  int albumID = state.albumID;
                  int categoryID = state.categoryID;
                  String pageName = state.pageName;

                  BlocProvider.of<AlbumBloc>(context)
                      .add(GetAlbumAllSongsEvent(albumId: albumID));
                  BlocProvider.of<SongBloc>(context)
                      .add(FetchSongEvent(songID: songID));
                  BlocProvider.of<CategoryBloc>(context)
                      .add(GetCategorySongsByIDEvent(categoryID: categoryID));

                  return pageName == "CategorySongPage"
                      ? BlocBuilder<SongBloc, SongState>(
                      builder: (context, state) {

                        AlbumDataMusicModel song = state.song;

                        return BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {

                          List<CategoryMusicsModel>? categoryAllSongs =
                              state.category.musics;

                          // Handle null check
                          if (categoryAllSongs == null) {
                            return Container(); // Return an empty widget if null
                          }

                          // Convert List<CategoryMusicsModel> to List<AlbumDataMusicModel>
                          List<AlbumDataMusicModel> albumDataList = categoryAllSongs.map((categoryMusic) {


                            return AlbumDataMusicModel(
                              id: categoryMusic.id,
                              name: categoryMusic.name,
                              imageSource: categoryMusic.imageSource,
                              fileSource: categoryMusic.fileSource!.substring(0, 4)
                                  + "s"
                                  + categoryMusic.fileSource!
                                      .substring(4,categoryMusic.fileSource!.length),
                              minute: categoryMusic.minute,
                              second: categoryMusic.second,
                              singerName: categoryMusic.singerName, // Fill in appropriate values if available
                              album: null,    // Adjust as per your logic
                              albumId: categoryMusic.albumId,
                              categories: null, // Adjust as per your logic
                            );
                          }).toList();
                          return MiniPlayingContainer(
                            visibility: visibility,
                            song: song,
                            album: albumDataList,
                            pageName: pageName,
                          );
                        });
                            return Container();
                          })
                      : pageName == "NewSong"
                      ? BlocBuilder<SongBloc, SongState>(
                      builder: (context, state) {

                        AlbumDataMusicModel song = state.song;

                        return BlocBuilder<NewSongBloc, NewSongState>(
                            builder: (context, state) {

                              List<NewSongDataModel>? newSongDataModel =
                                  state.newSong;

                              // Convert List<CategoryMusicsModel> to List<AlbumDataMusicModel>
                              List<AlbumDataMusicModel> albumDataList = newSongDataModel.map((categoryMusic) {

                                return AlbumDataMusicModel(
                                  id: categoryMusic.id,
                                  name: categoryMusic.name,
                                  imageSource: categoryMusic.imageSource,
                                  fileSource: categoryMusic.fileSource!.substring(0, 4)
                                      + "s"
                                      + categoryMusic.fileSource!
                                          .substring(4,categoryMusic.fileSource!.length),
                                  minute: categoryMusic.minute,
                                  second: categoryMusic.second,
                                  singerName: categoryMusic.singerName, // Fill in appropriate values if available
                                  album: null,    // Adjust as per your logic
                                  albumId: categoryMusic.albumId,
                                  categories: null, // Adjust as per your logic
                                );
                              }).toList();

                              return MiniPlayingContainer(
                                visibility: visibility,
                                song: song,
                                album: albumDataList,
                                pageName: pageName,
                              );
                            });
                        return Container();
                      })
                      : BlocBuilder<AlbumBloc, AlbumState>(
                      builder: (context, state) {

                        List<AlbumDataMusicModel> album = state.albumAllSongs;

                        if (state.status.isLoading) {
                          return LinearProgressIndicator();
                        } else if (state.status.isSuccess) {
                          return BlocBuilder<SongBloc, SongState>(
                              builder: (context, state) {

                                AlbumDataMusicModel song = state.song;

                                if (state.status.isLoading) {
                                  return LinearProgressIndicator();
                                } else if (state.status.isSuccess) {
                                  return MiniPlayingContainer(
                                      visibility: visibility,
                                      song: song,
                                      album: album,
                                      pageName: pageName
                                  );
                                } else if (state.status.isError) {
                                  return Container();
                                }
                                return Container();
                              });
                        } else if (state.status.isError) {
                          return Container();
                        }
                        return Container();
                      });
                }),
          )
              : Container()
        ],
      )),
    )
    ;
  }
}