import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/audio_control_bloc.dart';
import '../../../../data/model/album_model.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/event.dart';
import '../../../bloc/play_button_state_bloc/bloc.dart';
import '../../../bloc/play_button_state_bloc/event.dart';

class PreviousButton extends StatefulWidget {
  PreviousButton({key,
    required this.albumSongs, required this.songID, required this.albumID});

  final List<AlbumDataMusicModel> albumSongs;
  final int songID;
  final int albumID;

  @override
  State<PreviousButton> createState() => _PreviousButtonState();
}

class _PreviousButtonState extends State<PreviousButton> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {

          print("widget.songID                   "+widget.songID.toString());
            context
                .read<AudioControlBloc>()
                .add(PlayPreviousSongEvent(currentAlbum: widget.albumSongs));
            context
                .read<PlayButtonStateBloc>()
                .add(SetPlayButtonStateEvent(playButtonState: true));

            context
                .read<MiniPlayingContainerBloc>()
                .add(WriteSongIDForMiniPlayingSongContainerEvent(
                songID: widget.songID,
                albumID: widget.albumID));
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
