import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/mini_playing_container_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import '../../data/model/album_model.dart';
import '../../data/model/new-song_model.dart';
import '../../data/model/song_model.dart';
import '../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../bloc/play_box_bloc/bloc.dart';
import '../bloc/play_box_bloc/event.dart';
import '../bloc/song_bloc/bloc.dart';
import '../bloc/song_bloc/event.dart';
import '../bloc/song_control_bloc/audio_control_bloc.dart';
import '../helpers/play_song_page_component/circular_seekbar.dart';
import '../helpers/play_song_page_component/container_all_songs_list.dart';
import '../helpers/play_song_page_component/download_button.dart';
import '../helpers/play_song_page_component/favorite.dart';
import '../helpers/play_song_page_component/next_button.dart';
import '../helpers/play_song_page_component/normalize_button.dart';
import '../helpers/play_song_page_component/play_button.dart';
import '../helpers/play_song_page_component/play_list_button.dart';
import '../helpers/play_song_page_component/previous_button.dart';
import '../helpers/play_song_page_component/progressbar.dart';
import '../helpers/play_song_page_component/repeat_button.dart';

class PlaySongPage extends StatefulWidget {

  final String songName;
  final String songFile;
  final int songID;
  final String singerName;
  final String songImage;
  final String pageName;
  final int albumID;
  List<SongDataModel>? songList;
  List<NewSongDataModel>? newSongList;
  List<AlbumDataMusicModel>? albumSongList;

  PlaySongPage({super.key, required this.songName,
    required this.songFile, required this.songID, this.songList,
    this.newSongList, this.albumSongList, required this.singerName,
    required this.songImage, required this.pageName, required this.albumID});


  @override
  State<PlaySongPage> createState() => PlaySongPageState();
}

class PlaySongPageState extends State<PlaySongPage> with WidgetsBindingObserver , SingleTickerProviderStateMixin {

  bool loop = false;
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlayBoxBloc>(context).add(PlayBoxListEvent(songName: widget.songName));
    BlocProvider.of<PlaylistBloc>(context).add(SearchSongIDEvent(songID: widget.songID));
    BlocProvider.of<AudioControlBloc>(context).add(
        PlaySong(currentSong: context.read<CurrentSelectedSongBloc>().currentSelectedSong!));

    BlocProvider.of<MiniPlayingContainerBloc>(context).add(FirstPlayingSongEvent());
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(WriteRequirementForMiniPlayingSongContainerEvent(
        songName: widget.songName,
        songFile: widget.songFile,
        songImage: widget.songImage,
        singerName: widget.singerName,
        pageName: widget.pageName));

    BlocProvider.of<SongBloc>(context).add(FetchNewSongs());
    BlocProvider.of<SongBloc>(context).add(FetchAllSongs());
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        if(widget.pageName == "NewSong" || widget.pageName == "searchPage" || widget.pageName == "ContainerAllSongsList"){
          Navigator.of(context).pushNamed('/home');
          return true;
        }else{
          Navigator.of(context).pop();
          return false;
        }
      },
      child: Scaffold(
          body: BlocConsumer<CurrentSelectedSongBloc, CurrentSelectedSongState>(
              listener: (context, state) {
                context
                    .read<AudioControlBloc>()
                    .add(PlaySong(currentSong: context.read<CurrentSelectedSongBloc>().currentSelectedSong!));
              },
              builder: (context, state) {

                if (state is LoadingNewSong) {
                  return const Center(child: CircularProgressIndicator());
                }
                else if (state is SelectedSongFetched) {

                  var songID = state.songModel.id;

                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(state.songModel.imageSource!,),
                        fit: BoxFit.fitHeight,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.dstATop),
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
                              flex: 1,
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
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                      Text(
                                        widget.singerName,
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white60),
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
                            CustomCircularSeekBar(
                              songImage: state.songModel.imageSource!,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: 20,
                                left: 20
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      DownloadButton(
                                          songFilePath: state.songModel.fileSource!,
                                          songName: state.songModel.name!
                                      ),
                                      NormalizeButton()
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      PreviousButton(
                                        pageName: widget.pageName,),
                                      PlayButton(),
                                      NextButton(
                                        pageName: widget.pageName,
                                        albumID: widget.albumID,
                                        )
                                    ],
                                  ),
                                  Progressbar(
                                      minute: state.songModel.minute!,
                                      second: state.songModel.second!),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      PlayListButton(),
                                      RepeatButton(loop: loop)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15,),
                            const Spacer(),
                          widget.newSongList == null
                              && widget.songList == null
                              && widget.albumSongList == null
                              ? Container()
                              : Flexible(
                                flex: 4,
                                child: ContainerAllSongsList(
                                  newSongList: widget.newSongList,
                                  songList: widget.songList,
                                  albumSongList: widget.albumSongList,
                                  songName: state.songModel.name!
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              }
          )
      ),
    );
  }


}