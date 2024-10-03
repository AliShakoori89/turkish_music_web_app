import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/music_page/music_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';
import '../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../bloc/mini_playing_container_bloc/event.dart';
import '../../bloc/mini_playing_container_bloc/state.dart';
import '../../const/custom_icon/music_icons.dart';
import '../play_song_page/play_song_page_component/mini_palying_container.dart';

class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentRoute = 0;
  IconData? icon;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Orientation orientation = MediaQuery.of(context).orientation;
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(ReadSongIDForMiniPlayingSongContainerEvent());

    void navigateRoutes(int selectedIndex) {
      setState(() {
        currentRoute = selectedIndex;
      });
    }

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
          child: searchPage(),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  VerticalNavBar(
                    selectedIndex: currentRoute,
                    height: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.3
                        : MediaQuery.of(context).size.height * 0.3,
                    width: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.12
                        : MediaQuery.of(context).size.width * 0.04,
                    backgroundColor: Colors.purple.withOpacity(0.7),
                    borderRadius: 15,
                    onItemSelected: (value) {
                      setState(() {
                        navigateRoutes(value);
                      });
                    },
                    items: const [
                      VerticalNavBarItem(
                          customIcon: Icons.home,
                          iconSize: 25
                      ),
                      VerticalNavBarItem(
                          customIcon: Icons.person,
                          iconSize: 25
                      ),
                      VerticalNavBarItem(
                          customIcon: MusicIcon.music,
                          iconSize: 20
                      ),
                      VerticalNavBarItem(
                          customIcon: Icons.search,
                          iconSize: 25
                      ),
                    ],
                  ),
                  BlocBuilder<MiniPlayingContainerBloc,
                      MiniPlayingContainerState>(
                      builder: (context , state) {
                        bool visibility = state.visibility;
                        int songID = state.songID;
                        int albumID = state.albumID;

                        return MiniPlayingContainer(
                          visibility: visibility,
                          songID: songID,
                          albumID: albumID,
                        );
                      }
                  ),
                ],
              )
            ],
          )
      ),
    )
    ;
  }
}