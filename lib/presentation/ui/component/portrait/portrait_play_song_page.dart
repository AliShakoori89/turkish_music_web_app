import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../data/model/album_model.dart';
import '../../../helpers/widgets/back_button_if_ios_web.dart';
import '../../play_song_page/play_song_page_component/container_all_songs_list.dart';
import '../../play_song_page/play_song_page_component/favorite.dart';
import '../../play_song_page/play_song_page_component/loop_button.dart';
import '../../play_song_page/play_song_page_component/next_button.dart';
import '../../play_song_page/play_song_page_component/play_button.dart';
import '../../play_song_page/play_song_page_component/play_list_button.dart';
import '../../play_song_page/play_song_page_component/previous_button.dart';
import '../../play_song_page/play_song_page_component/progressbar.dart';
import '../title.dart';



class PortraitPlaySongPage extends StatelessWidget {
  PortraitPlaySongPage({super.key, required this.songName, required this.singerName,
    required this.songID, required this.controller, required this.songFilePath,
    required this.minute, required this.second,
    required this.songImagePath, required this.albumAllSongsList,
    required this.albumID, required this.categoryID});

  final String songName;
  final String singerName;
  final String songFilePath;
  final String songImagePath;
  final String minute;
  final String second;
  final int songID;
  final int albumID;
  final AnimationController controller;
  final int categoryID;
  final List<AlbumDataMusicModel> albumAllSongsList;




  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTitle(
                title: "Now Playing",
                heightSize: 50,
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          songName,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 60,
                              color: Colors.white),
                        ),
                        Text(
                          singerName,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 70,
                              color: Colors.white60),
                        ),
                      ],
                    ),
                    Spacer(flex: 10,),
                    FavoriteButton(
                      controller: controller,
                      songID: songID,
                    ),
                  ],
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   flex: 1,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       // DownloadButton(
                    //       //     songFilePath: songFilePath,
                    //       //     songName: songName,
                    //       // ),
                    //       repeatButton()
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      flex: 10,
                      child: Progressbar(
                        minute: minute,
                        second: second,
                        songImage: songImagePath,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PreviousButton(
                              albumSongs: albumAllSongsList,
                              songID: songID,
                              singerName: singerName),
                          PlayButton(),
                          NextButton(
                            albumSongs : albumAllSongsList,
                            songID: songID,
                            singerName: singerName,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 15
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PlayListButton(),
                            loopButton()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ContainerAllSongsList(
                singerName: singerName,
                categoryAllSongs: albumAllSongsList,
                songName: songName,
                songID: songID,)
            ],
          ),
        )
    );
  }
}