import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/audio_control_bloc.dart';
import '../../../../data/model/album_model.dart';

class PreviousButton extends StatelessWidget {
  PreviousButton({key, required this.pageName, required this.albumSongs,
    required this.songID, required this.albumID, required this.album});

  final String pageName;
  final List<AlbumDataMusicModel> albumSongs;
  final int songID;
  final int albumID;
  final List<AlbumDataMusicModel> album;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
            context
                .read<AudioControlBloc>()
                .add(PlayPreviousSongEvent(currentAlbum: albumSongs));
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
