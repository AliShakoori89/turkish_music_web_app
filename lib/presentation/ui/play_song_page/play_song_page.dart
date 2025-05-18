import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:turkish_music_app/data/model/miniplayer_model.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/domain/repositories/mini_playing_container_repository.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import 'package:turkish_music_app/presentation/ui/component/landscape/landscape_play_song_page.dart';
import '../../../data/model/album_model.dart';
import '../../bloc/play_button_state_bloc/bloc.dart';
import '../../bloc/play_button_state_bloc/event.dart';
import '../../bloc/song_control_bloc/audio_control_bloc.dart';
import '../component/portrait/portrait_play_song_page.dart';

class PlaySongPage extends StatefulWidget {

  static String routeName = "PlaySongPage";

  final String songName;
  final int songID;
  final String singerName;
  final String songImage;
  final String songFile;
  final int categoryID;
  final int albumID;
  final List<AlbumDataMusicModel> SongList;
  final SongDataModel songDataModel;

  const PlaySongPage({super.key, required this.songName, required this.songID, required this.singerName, required this.songImage, required this.songFile, required this.categoryID, required this.albumID, required this.SongList, required this.songDataModel});



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

    BlocProvider.of<AudioControlBloc>(context).add(
        PlaySongEvent(
          currentSong: widget.songDataModel,
          currentAlbum: widget.SongList,
        )
    );


    BlocProvider.of<PlaylistBloc>(context).add(SearchSongIDEvent(songID: widget.songID));

    MiniPlayerModel song = MiniPlayerModel(
        songID: widget.songID,
        songName: widget.songName,
        songsSingerName: widget.singerName,
        songImagePath: widget.songImage,
        songFilePath: widget.songFile,
        minute: widget.songDataModel.minute,
        second: widget.songDataModel.second,
        categoryID: widget.categoryID,
        albumID: widget.albumID,
        songList: widget.SongList
    );

    MiniPlayerRepo().saveToMiniPlayer(song);


    BlocProvider.of<PlayButtonStateBloc>(context).add(SetPlayButtonStateEvent(playButtonState: true));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: BlocBuilder<AudioControlBloc, AudioControlState>(
              builder: (context, state) {

                if (state is AudioPlayedState) {

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
                                  Colors.black.withValues(alpha: 0.2),
                                  BlendMode.dstATop),
                            ),
                          ),
                          child: orientation == Orientation.portrait
                              ? PortraitPlaySongPage(
                            controller: _controller,
                            songID: state.songModel.id!,
                            songName: state.songModel.name!,
                            singerName: state.songModel.singerName ?? "",
                            songFilePath: state.songModel.fileSource!,
                            minute: state.songModel.minute!,
                            second: state.songModel.second!,
                            songImagePath: state.songModel.imageSource!,
                            albumAllSongsList: widget.SongList,
                            albumID: widget.albumID,
                            categoryID: widget.categoryID,
                          )
                              : LandscapePlaySongPage(
                              controller: _controller,
                              songID: state.songModel.id!,
                              songName: state.songModel.name!,
                              singerName: state.songModel.singerName ?? "",
                              songFilePath: state.songModel.fileSource!,
                              minute: state.songModel.minute!,
                              second: state.songModel.second!,
                              songImagePath: state.songModel.imageSource!,
                              albumAllSongsList: widget.SongList,
                              albumID: widget.albumID,
                              categoryID: widget.categoryID,
                              orientation: orientation),
                        );
                      }
                  );

                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              }
          ),
        )
    );
  }


}