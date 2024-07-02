import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../bloc/song_bloc/bloc/song_bloc.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {
          return IconButton(
              padding: const EdgeInsets.all(1),
              onPressed: () {
                context
                    .read<CurrentSelectedSongBloc>()
                    .add(PlayNextSong(songs: BlocProvider.of<SongBloc>(context).songs));
              },
              icon: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    BoxShadow(color: Colors.white.withOpacity(0.2), spreadRadius: 0),
                  ]),
                  child: const Icon(Icons.skip_next_rounded,
                    color: Colors.white,)));

        });
  }
}
