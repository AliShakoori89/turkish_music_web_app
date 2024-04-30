import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'package:turkish_music_app/presentation/bloc/song_control_bloc/bloc/song_control_bloc.dart';

import '../../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../../bloc/song_bloc/bloc.dart';

class ControlButtons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
            padding: const EdgeInsets.all(1),
            // style: AppTheme.lightTheme.iconButtonTheme.style,
            onPressed: () {
              //pass song list here
              // context
              //     .read<CurrentSelectedSongBloc>()
              //     .add(PlayPreviousSong(songs: BlocProvider.of<SongBloc>(context).songs));
            },
            icon: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 7.0,
                  ),
                  const BoxShadow(color: Colors.white, spreadRadius: 0),
                ]),
                child: const Icon(Icons.skip_previous_rounded))),

        BlocBuilder<SongControlBloc, SongControlState>(
          buildWhen: (previous, current) {

            if (previous is SongPlayedState && current is SongPlayedState) {
              return false;
            } else {
              return true;
            }
          },
          builder: (context, state) {
            return IconButton(
                padding: const EdgeInsets.all(1),
                onPressed: () async {
                  if (state is SongPausedState) {
                    BlocProvider.of<SongControlBloc>(context).add(ResumeSong());
                  } else {
                    BlocProvider.of<SongControlBloc>(context).add(PauseSong());
                  }
                  },
                icon: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 7.0,
                      ),
                      const BoxShadow(color: Colors.white, spreadRadius: 0),
                    ]),
                    child: state is SongPlayedState
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow_rounded)));
          },
        ),
        // Opens speed slider dialog
        IconButton(
            padding: const EdgeInsets.all(1),
            onPressed: () {
              // context
              //     .read<CurrentSelectedSongBloc>()
              //     .add(PlayNextSong(songs: BlocProvider.of<SongBloc>(context).songs));
            },
            icon: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(
                      1.0,
                      1.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 7.0,
                  ),
                  const BoxShadow(color: Colors.white, spreadRadius: 0),
                ]),
                child: const Icon(Icons.skip_next_rounded)))
      ],
    );
  }
}