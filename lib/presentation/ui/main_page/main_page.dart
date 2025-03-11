import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/mini_playing_container_repository.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/song_page/song_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/profile_page/profile_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/search_page/search_page.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/mini_palying_container.dart';
import 'package:vertical_nav_bar/vertical_nav_bar.dart';
import '../../bloc/new_song_bloc/event.dart';

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
    BlocProvider.of<NewSongBloc>(context).add(GetAllNewSongEvent());

    List myRoutes = [
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.07,
            ),
            child: HomePage(),
          )
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
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
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
                    backgroundColor: Colors.purple.withValues(alpha: 0.3),
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
                MiniPlayerRepo().song != null
                    ? currentRoute != 3
                    ? Align(
                    alignment: Alignment.bottomCenter,
                    child: MiniPlayingContainer()
                )
                    : Center()
                    : Center()
              ],
            ),
          )),
    )
    ;
  }
}