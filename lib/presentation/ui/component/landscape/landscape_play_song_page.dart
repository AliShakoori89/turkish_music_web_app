import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../data/model/album_model.dart';
import '../../../../data/model/save_song_model.dart';
import '../../play_song_page/play_song_page_component/container_all_songs_list.dart';
import '../../play_song_page/play_song_page_component/download_button.dart';
import '../../play_song_page/play_song_page_component/favorite.dart';
import '../../play_song_page/play_song_page_component/loop_button.dart';
import '../../play_song_page/play_song_page_component/next_button.dart';
import '../../play_song_page/play_song_page_component/play_button.dart';
import '../../play_song_page/play_song_page_component/play_list_button.dart';
import '../../play_song_page/play_song_page_component/previous_button.dart';
import '../../play_song_page/play_song_page_component/progressbar.dart';
import '../../play_song_page/play_song_page_component/repeat_button.dart';

class LandscapePlaySongPage extends StatelessWidget {
  const LandscapePlaySongPage({super.key, required this.songName, required this.singerName, required this.songFilePath, required this.songImagePath, required this.minute, required this.second, required this.saveSongModel, required this.songID, required this.albumID, required this.controller, required this.categoryID, required this.albumAllSongsList, required this.orientation, required this.pageName});

  final String songName;
  final String singerName;
  final String songFilePath;
  final String songImagePath;
  final String minute;
  final String second;
  final String pageName;
  final SaveSongModel saveSongModel;
  final int songID;
  final int albumID;
  final AnimationController controller;
  final int categoryID;
  final Orientation orientation;
  final List<AlbumDataMusicModel> albumAllSongsList;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          "Now Playing",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: orientation == Orientation.portrait
                                ? 16
                                : 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
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
                                  fontSize: orientation == Orientation.portrait
                                      ? MediaQuery.of(context).size.height / 30
                                      : MediaQuery.of(context).size.height / 40,
                                  color: Colors.white),
                            ),
                            Text(
                              singerName,
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? MediaQuery.of(context).size.height / 35
                                      : MediaQuery.of(context).size.height / 45,
                                  color: Colors.white60),
                            ),
                          ],
                        ),
                        Spacer(),
                        FavoriteButton(
                          controller: controller,
                          songID: songID,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.2,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DownloadButton(
                                    songFilePath: songFilePath,
                                    songName: songName,
                                    songModel : saveSongModel
                                ),
                                repeatButton()
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 20,
                            child: Progressbar(
                              minute: minute,
                              second: second,
                              songImage: songImagePath,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PreviousButton(
                                    albumSongs: albumAllSongsList,
                                    songID: songID,
                                    albumID: albumID,
                                    singerName: singerName,
                                    audioFileSec: second,
                                    audioFileMin: minute,
                                    audioFilePath: songFilePath,
                                    imageFilePath: songImagePath,
                                    songName: songName,
                                    pageName: pageName,
                                    categoryID: categoryID
                                ),
                                PlayButton(),
                                NextButton(
                                    albumSongs : albumAllSongsList,
                                    songID: songID,
                                    albumID: albumID,
                                    singerName: singerName,
                                    audioFileSec: second,
                                    audioFileMin: minute,
                                    audioFilePath: songFilePath,
                                    imageFilePath: songImagePath,
                                    songName: songName,
                                    pageName: pageName,
                                    categoryID: categoryID
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
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
                  ),
                ],
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ContainerAllSongsList(
                  singerName: singerName,
                  categoryAllSongs: albumAllSongsList,
                  songName: songName,
                  songID: songID,
                ),
              ),
            )
          ],
        ));
  }
}
