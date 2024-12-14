import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import '../../../data/model/album_model.dart';
import '../../bloc/play_button_state_bloc/bloc.dart';
import '../../bloc/play_button_state_bloc/event.dart';
import '../../bloc/song_control_bloc/audio_control_bloc.dart';

class PlaySongPage extends StatefulWidget {

  static String routeName = "PlaySongPage";

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

    // Deferring the Bloc event call until after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> data = GoRouterState.of(context).extra as Map<String, dynamic>;
      SongDataModel songDataModel = data['songDataModel'] as SongDataModel;
      List<AlbumDataMusicModel> albumSongList = data['albumSongList'] as List<AlbumDataMusicModel>;

      // Adding the event after the first frame is rendered
      BlocProvider.of<AudioControlBloc>(context).add(
          PlaySongEvent(
            currentSong: songDataModel,
            currentAlbum: albumSongList,
          )
      );

      int songID = data['songID'] as int;
      int albumID = data['albumID'] as int;
      String pageName = data["pageName"] as String;
      int categoryID = data["categoryID"] as int;
      BlocProvider.of<PlaylistBloc>(context).add(SearchSongIDEvent(songID: songID));

      context
          .read<MiniPlayingContainerBloc>()
          .add(WriteSongIDForMiniPlayingSongContainerEvent(songID: songID,
          albumID: albumID, pageName: pageName, categoryID: categoryID));
    });

    BlocProvider.of<MiniPlayingContainerBloc>(context).add(FirstPlayingSongEvent());
    BlocProvider.of<PlayButtonStateBloc>(context).add(SetPlayButtonStateEvent(playButtonState: true));
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> data = GoRouterState.of(context).extra as Map<String, dynamic>;

    String songName = data['songName'] as String;
    int albumID = data['albumID'] as int;
    List<AlbumDataMusicModel> albumSongList = data['albumSongList'] as List<AlbumDataMusicModel>;
    String singerName = data['singerName'] as String;
    String songImage = data['songImage'] as String;
    String pageName = data["pageName"] as String;
    int categoryID = data["categoryID"] as int;

    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Scaffold(
          body: SafeArea(
            child: BlocBuilder<AudioControlBloc, AudioControlState>(
                builder: (context, state) {
            
                  if (state is AudioPlayedState) {
            
                    var songID = state.songModel.id;
            
                    var path = state.songModel.fileSource!.replaceRange(4, 5, "");
            
                    SaveSongModel recentlyPlayedSongIdModel = SaveSongModel(
                        id: songID,
                        singerName: singerName,
                        audioFileAlbumId: albumID,
                        audioFileSec: state.songModel.second,
                        audioFileMin: state.songModel.minute,
                        audioFilePath: path,
                        imageFilePath: songImage,
                        songName: songName
                    );
            
                    BlocProvider.of<RecentlyPlaySongBloc>(context).add(
                        SavePlayedSongIDToRecentlyPlayedEvent(
                            recentlyPlayedSongIdModel: recentlyPlayedSongIdModel));
            
                    return ImagePixels(
                        imageProvider: NetworkImage(state.songModel.imageSource!),
                        builder: (context, img) {
            
                          Orientation orientation = MediaQuery.of(context).orientation;
            
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.05,
                                left: MediaQuery.of(context).size.width * 0.05),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.white, Colors.black, Colors.black],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                              image: DecorationImage(
                                image: NetworkImage(state.songModel.imageSource!,),
                                fit: BoxFit.fitHeight,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                              ),
                            ),
                            child: orientation == Orientation.portrait
                                ? BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
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
                                    SizedBox(height: 50,),
                                    Row(
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
                                              singerName,
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
                                    Container(
                                      height: 500,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
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
                                          Expanded(
                                            flex: 10,
                                            child: Progressbar(
                                              minute: state.songModel.minute!,
                                              second: state.songModel.second!,
                                              songImage: state.songModel.imageSource!,),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                PreviousButton(
                                                    albumSongs: albumSongList,
                                                    songID: songID,
                                                    albumID: albumID,
                                                    singerName: singerName,
                                                    audioFileSec: state.songModel.second!,
                                                    audioFileMin: state.songModel.minute!,
                                                    audioFilePath: path,
                                                    imageFilePath: songImage,
                                                    songName: songName,
                                                    pageName: "PlaySongPage",
                                                    categoryID: categoryID),
                                                PlayButton(),
                                                NextButton(
                                                    albumSongs : albumSongList,
                                                    songID: songID,
                                                    albumID: albumID,
                                                    singerName: singerName,
                                                    audioFileSec: state.songModel.second!,
                                                    audioFileMin: state.songModel.minute!,
                                                    audioFilePath: path,
                                                    imageFilePath: songImage,
                                                    songName: songName,
                                                    pageName: "PlaySongPage",
                                                    categoryID: categoryID
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
                                      categoryAllSongs: albumSongList,
                                      songName: state.songModel.name!,
                                      songID: songID,)
                                  ],
                                ),
                              )
                            )
                                : BackdropFilter(
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
                                                  state.songModel.name!,
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
                                              controller: _controller,
                                              songID: songID!,
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
                                                        songFilePath: state.songModel.fileSource!,
                                                        songName: state.songModel.name!,
                                                        songModel : recentlyPlayedSongIdModel
                                                    ),
                                                    repeatButton()
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                flex: 20,
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
                                                        albumSongs: albumSongList,
                                                        songID: songID,
                                                        albumID: albumID,
                                                        singerName: singerName,
                                                        audioFileSec: state.songModel.second!,
                                                        audioFileMin: state.songModel.minute!,
                                                        audioFilePath: path,
                                                        imageFilePath: songImage,
                                                        songName: songName,
                                                        pageName: pageName,
                                                        categoryID: categoryID
                                                    ),
                                                    PlayButton(),
                                                    NextButton(
                                                        albumSongs : albumSongList,
                                                        songID: songID,
                                                        albumID: albumID,
                                                        singerName: singerName,
                                                        audioFileSec: state.songModel.second!,
                                                        audioFileMin: state.songModel.minute!,
                                                        audioFilePath: path,
                                                        imageFilePath: songImage,
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
                                      categoryAllSongs: albumSongList,
                                      songName: state.songModel.name!,
                                      songID: songID,
                                    ),
                                  ),
                                )
                              ],
                            )),
                          );
                        }
                    );
            
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                }
            ),
          )
      ),
    );
  }


}