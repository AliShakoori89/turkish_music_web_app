import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/audio_control_bloc.dart';
import '../../../../data/model/album_model.dart';
import '../../../../data/model/save_song_model.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/event.dart';
import '../../../bloc/play_button_state_bloc/bloc.dart';
import '../../../bloc/play_button_state_bloc/event.dart';
import '../../../bloc/recently_play_song_bloc/bloc.dart';
import '../../../bloc/recently_play_song_bloc/event.dart';

class PreviousButton extends StatelessWidget {
  PreviousButton({key,
    required this.albumSongs, required this.songID, required this.albumID, required this.singerName,
    required this.audioFileSec, required this.audioFileMin, required this.audioFilePath, required this.imageFilePath, required this.songName});

  final List<AlbumDataMusicModel> albumSongs;
  final int songID;
  final int albumID;
  final String singerName;
  final String audioFileSec;
  final String audioFileMin;
  final String audioFilePath;
  final String imageFilePath;
  final String songName;


  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {

          context
              .read<AudioControlBloc>()
              .add(PlayPreviousSongEvent(currentAlbum: albumSongs));

          context
              .read<PlayButtonStateBloc>()
              .add(SetPlayButtonStateEvent(playButtonState: true));


          context
              .read<MiniPlayingContainerBloc>()
              .add(WriteSongIDForMiniPlayingSongContainerEvent(
              songID: songID,
              albumID: albumID));

          SaveSongModel recentlyPlayedSongIdModel = SaveSongModel(
              id: songID,
              singerName: singerName,
              audioFileAlbumId: albumID,
              audioFileSec: audioFileSec,
              audioFileMin: audioFileMin,
              audioFilePath: audioFilePath,
              imageFilePath: imageFilePath,
              songName: songName
          );

          context
              .read<RecentlyPlaySongBloc>()
              .add(SavePlayedSongIDToRecentlyPlayedEvent(
              recentlyPlayedSongIdModel: recentlyPlayedSongIdModel));
        },
        icon: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 7.0,
              ),
              BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
            ]),
            child: Icon(
              size: MediaQuery.of(context).size.height / 40,
              Icons.skip_previous_rounded,
              color: Colors.white,)));
  }
}
