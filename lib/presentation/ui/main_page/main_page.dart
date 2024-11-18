import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/song_page/song_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';
import '../../../data/model/album_model.dart';
import '../../bloc/album_bloc/bloc.dart';
import '../../bloc/album_bloc/event.dart';
import '../../bloc/album_bloc/state.dart';
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
  void initState() {
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(ReadSongIDForMiniPlayingSongContainerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;

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
                  : MediaQuery.of(context).size.height * 0.4,
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
                  title: "Home",
                ),
                VerticalNavBarItem(
                  title: "profile",
                ),
                VerticalNavBarItem(
                  title: "music",
                ),
                VerticalNavBarItem(
                  title: "search",
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<MiniPlayingContainerBloc, MiniPlayingContainerState>(
                builder: (context, state) {
                  bool visibility = state.visibility;
                  int songID = state.songID;
                  int albumID = state.albumID;

                  BlocProvider.of<SongBloc>(context)
                      .add(FetchSongEvent(songID: songID));
                  BlocProvider.of<AlbumBloc>(context)
                      .add(GetAlbumAllSongsEvent(albumId: albumID));
                  // return Container();
                  return BlocBuilder<AlbumBloc, AlbumState>(
                      builder: (context, state) {
                        List<AlbumDataMusicModel> album = state.albumAllSongs;
                        return BlocBuilder<SongBloc, SongState>(
                            builder: (context, state) {
                              if (state.status.isLoading) {
                                return LinearProgressIndicator();
                              } else if (state.status.isSuccess) {
                                return MiniPlayingContainer(
                                  visibility: visibility,
                                  song: state.song,
                                  album: album,
                                );
                              } else if (state.status.isError) {
                                return Text("Error");
                              }
                              return Card();
                            });
                      });
                }),
          )
        ],
      )),
    )
    ;
  }
}