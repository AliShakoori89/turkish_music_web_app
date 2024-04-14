import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_audio/simple_audio.dart';
import '../../../bloc/music_bloc/bloc.dart';
import '../../../bloc/music_bloc/event.dart';
import '../../../helpers/widgets/home_page/new_music_container.dart';
import '../../../helpers/widgets/header.dart';
import '../../../helpers/widgets/must_listen_contaner.dart';
import '../../../helpers/widgets/home_page/new_album_contaner.dart';
import '../../../helpers/widgets/home_page/famous_artist_container.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.isPlaying, required this.player,
    required this.audioPlayer, required this.playbackState});

  final bool isPlaying;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;
  late PlaybackState playbackState;

  @override
  State<HomePage> createState() => HomePageState(isPlaying, player, audioPlayer, playbackState);
}

class HomePageState extends State<HomePage> {

  HomePageState(this.isPlaying, this.player, this.audioPlayer, this.playbackState);
  final bool isPlaying;
  final SimpleAudio player;
  final AudioPlayer audioPlayer;
  late PlaybackState playbackState;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppHeader(),
                NewMusicContainer(isPlaying: isPlaying, player: player,
                    audioPlayer: audioPlayer, playbackState: playbackState),
                FamousArtistContainer(isPlaying: isPlaying, player: player,
                    audioPlayer: audioPlayer, playbackState: playbackState),
                NewAlbumContainer(),
                MustListenContainer()
              ],
            ),
          ),
        )
      ),
    );
  }
}
