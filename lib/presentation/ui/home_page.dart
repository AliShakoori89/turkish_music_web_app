import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/featured_container.dart';
import 'package:turkish_music_app/presentation/helpers/new_song_contaner.dart';
import '../const/custom_icon/music_icons.dart';
import '../helpers/header.dart';
import '../helpers/must_listen_contaner.dart';
import '../helpers/playlist_container.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottomNavigationBar(),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(),
                  PlaylistContainer(),
                  FeaturedContainer(),
                  NewSong(),
                  MustListenContainer()
                ],
              ),
            ),
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  BottomNavigationBar customBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(MusicIcon.music, size: 18),
          label: 'My Music',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}