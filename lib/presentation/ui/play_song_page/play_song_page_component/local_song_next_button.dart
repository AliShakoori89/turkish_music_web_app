import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/song_control_bloc/audio_control_bloc.dart';


class LocalSongNextButton extends StatelessWidget {
  LocalSongNextButton({super.key, required this.albumSongs});

  final List<FileSystemEntity> albumSongs;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context
              .read<AudioControlBloc>()
              .add(PlayNextLocalSongEvent(
              currentAlbum: albumSongs));
        },
        icon: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 7.0,
              ),
              BoxShadow(color: Colors.white.withValues(alpha: 0.2),
                  spreadRadius: 0),
            ]),
            child: Icon(
              size: MediaQuery.of(context).size.height / 40,
              Icons.skip_next_rounded,
              color: Colors.white,)));
  }
}
