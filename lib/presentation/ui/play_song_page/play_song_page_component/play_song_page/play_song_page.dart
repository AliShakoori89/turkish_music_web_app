import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/recently_play_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/recently_play_song_bloc/event.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/container_all_songs_list.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/download_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/favorite.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/loop_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/next_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/play_list_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/previous_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/progressbar.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/repeat_button.dart';

import '../../../../../data/model/album_model.dart';
import '../../../../bloc/play_box_bloc/bloc.dart';
import '../../../../bloc/play_box_bloc/event.dart';
import '../../../../bloc/play_button_state_bloc/bloc.dart';
import '../../../../bloc/play_button_state_bloc/event.dart';
import '../../../../bloc/song_bloc/bloc.dart';
import '../../../../bloc/song_bloc/event.dart';
import '../../../../bloc/song_control_bloc/audio_control_bloc.dart';

class PlaySongPage extends StatefulWidget {

  final String songName;
  final String songFile;
  final int songID;
  final String singerName;
  final String songImage;
  final String pageName;
  final int albumID;
  final SongDataModel songDataModel;

  final List<AlbumDataMusicModel> albumSongList;

  PlaySongPage({super.key, required this.songName,
    required this.songFile, required this.songID,
    required this.albumSongList, required this.singerName,
    required this.songImage, required this.pageName,
    required this.albumID, required this.songDataModel});


  @override
  State<PlaySongPage> createState() => PlaySongPageState();
}

class PlaySongPageState extends State<PlaySongPage> with WidgetsBindingObserver , SingleTickerProviderStateMixin {

  int currentSongIndex = 0;

  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));
    BlocProvider.of<PlaylistBloc>(context).add(SearchSongIDEvent(songID: widget.songID));


    BlocProvider.of<MiniPlayingContainerBloc>(context).add(FirstPlayingSongEvent());
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(WriteSongIDForMiniPlayingSongContainerEvent(
      songID: widget.songID,
      albumID: widget.albumID));

    BlocProvider.of<SongBloc>(context).add(FetchNewSongsEvent());
    BlocProvider.of<SongBloc>(context).add(FetchAllSongsEvent());

    BlocProvider.of<AudioControlBloc>(context).add(
        PlaySongEvent(
            currentSong: widget.songDataModel,
            currentAlbum: widget.albumSongList)
    );

    BlocProvider.of<PlayButtonStateBloc>(context).add(SetPlayButtonStateEvent(playButtonState: true));

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: BlocBuilder<AudioControlBloc, AudioControlState>(
            builder: (context, state) {

              if (state is AudioPlayedState) {

                var songID = state.songModel.id;

                SaveSongModel recentlyPlayedSongIdModel = SaveSongModel(
                    id: widget.songID,
                    singerName: widget.singerName,
                    audioFileAlbumId: widget.albumID,
                    audioFileSec: state.songModel.second,
                    audioFileMin: state.songModel.minute,
                    audioFilePath: widget.songFile,
                    imageFilePath: widget.songImage,
                    songName: widget.songName
                );

                BlocProvider.of<RecentlyPlaySongBloc>(context).add(
                    SavePlayedSongIDToRecentlyPlayedEvent(
                        recentlyPlayedSongIdModel: recentlyPlayedSongIdModel));

                return ImagePixels(
                    imageProvider: NetworkImage(state.songModel.imageSource!),
                    builder: (context, img) {

                      Color topLeftColor = img.pixelColorAt!(50, 50);

                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.05,
                            left: MediaQuery.of(context).size.width * 0.05),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [topLeftColor, Colors.black],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(state.songModel.imageSource!,),
                            fit: BoxFit.fitHeight,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Now Playing",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
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
                                            state.songModel.name!,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height / 60,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            widget.singerName,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.height / 70,
                                                color: Colors.white60),
                                          ),
                                        ],
                                      ),
                                      Spacer(flex: 10,),
                                      FavoriteButton(
                                        controller: _controller,
                                        songID: songID!,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 15,
                                  child: Container(
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
                                                  songFilePath: state.songModel.fileSource!,
                                                  songName: state.songModel.name!,
                                                  songModel : recentlyPlayedSongIdModel
                                              ),
                                              repeatButton()
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 9,
                                          child: Progressbar(
                                            minute: state.songModel.minute!,
                                            second: state.songModel.second!,
                                            songImage: state.songModel.imageSource!,),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PreviousButton(
                                                  albumSongs: widget.albumSongList),
                                              PlayButton(),
                                              NextButton(
                                                  albumSongs : widget.albumSongList
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
                                Flexible(
                                    flex: 4,
                                    child: ContainerAllSongsList(
                                      singerName: widget.singerName,
                                      categoryAllSongs: widget.albumSongList,
                                      songName: state.songModel.name!,)
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );

              } else {
                return const Center(child: Text('Something went wrong'));
              }
            }
        )
    );
  }


}