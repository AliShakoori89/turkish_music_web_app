import 'package:flutter/material.dart';
import 'package:turkish_music_app/presentation/helpers/featured_container.dart';

import '../const/title.dart';
import '../helpers/playlist_containers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(title: "Playlists"),
                PlaylistContainer(),
                FeaturedContainer()
              ],
            ),
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}