import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/model/album_model.dart';
import '../../../bloc/current_selected_song/current_selected_song_bloc.dart';

class NextButton extends StatelessWidget {
  NextButton({super.key, required this.pageName, required this.categoryAllSongs,
    required this.songID, required this.albumID});

  final String pageName;
  final List<AlbumDataMusicModel> categoryAllSongs;
  final int songID;
  final int albumID;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context
              .read<CurrentSelectedSongBloc>()
              .add(PlayNextSongEvent(songs: categoryAllSongs));
        },
        icon: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 7.0,
              ),
              BoxShadow(color: Colors.white.withOpacity(0.2),
                  spreadRadius: 0),
            ]),
            child: Icon(
              size: MediaQuery.of(context).size.height / 40,
              Icons.skip_next_rounded,
              color: Colors.white,)));
  }
}
