import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/music_progress_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/normalize_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_back_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/stop_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/volume_button.dart';
import 'package:turkish_music_app/presentation/helpers/my_music_page_card.dart';
import 'dart:io';
import 'dart:math';

import 'package:turkish_music_app/presentation/helpers/singer_name_trackName_image.dart';
import 'package:turkish_music_app/presentation/helpers/top_arrow_icon.dart';
import 'package:turkish_music_app/presentation/ui/detail_page.dart';

class MusicPage extends StatelessWidget {
  MusicPage({super.key});

  List customIcon = [
    Icons.playlist_play_outlined,
    Icons.mic_none_rounded,
    Icons.album,
    Icons.favorite,
    Icons.download,
    Icons.podcasts
  ];
  List title = [
    "Playlists",
    "Artists",
    "Albums",
    "Favorites",
    "Downloads",
    "Podcasts"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.033,
              left: MediaQuery.of(context).size.width * 0.033,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1
                    ),
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return MyMusicPageCard(
                          customIcon: customIcon[index],
                          title: title[index],
                        );
                      },
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Recently Playlist",
                            style: TextStyle(
                              color: Colors.grey
                            ),
                          )
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 8,
                        child: DetailPage(
                          songName: 'Okadar',
                          singerName: "Tarkan",
                          singerImage: "assets/images/tarkan.png",
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Column(
                      children: [
                        const TopArrow(),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.10 + 15,
                            right: MediaQuery.of(context).size.width * 0.10 + 15,
                            // top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              const SingerNameTrackNameImage(
                                  songName: "Tarkan",
                                  singerName: "MoOooooOoch",
                                  imagePath: "assets/images/tarkan.png",
                                  align: MainAxisAlignment.start),
                              PlayButton()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.onPressed,
    required this.child,
    this.size = 35,
    this.color = Colors.blue,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            canRequestFocus: false,
            onTap: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}