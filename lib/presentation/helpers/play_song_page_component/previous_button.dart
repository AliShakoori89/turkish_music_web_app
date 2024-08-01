import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import '../../../data/model/album_model.dart';
import '../../bloc/album_bloc/bloc.dart';
import '../../bloc/album_bloc/event.dart';
import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../bloc/song_bloc/bloc.dart';
import '../../bloc/song_bloc/state.dart';

class PreviousButton extends StatelessWidget {
  PreviousButton({key, required this.pageName, required this.albumSongs});

  final String pageName;
  final List<AlbumDataMusicModel> albumSongs;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.all(1),
        // style: AppTheme.lightTheme.iconButtonTheme.style,
        onPressed: () {

          // if(pageName == "SingerPage"){
            context
                .read<CurrentSelectedSongBloc>()
                .add(PlayPreviousSong(songs: albumSongs));
          // }else{
          //   context
          //       .read<CurrentSelectedSongBloc>()
          //       .add(PlayPreviousSong(songs: songDataModel));
          // }
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
            child: const Icon(Icons.skip_previous_rounded,
              color: Colors.white,)));
  }
}
