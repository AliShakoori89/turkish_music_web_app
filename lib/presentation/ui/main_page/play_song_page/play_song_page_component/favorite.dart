import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/play_list_bloc/bloc.dart';
import '../../../../bloc/play_list_bloc/event.dart';
import '../../../../bloc/play_list_bloc/state.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.controller, required this.songID});

  final AnimationController controller;
  final int songID;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          bool isFavorite = state.isFavorite;
          return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  widget.controller
                      .reverse()
                      .then((value) => widget.controller.forward());

                  if(isFavorite){
                    BlocProvider.of<PlaylistBloc>(context).add(AddMusicToPlaylistEvent(songID: widget.songID!));
                    BlocProvider.of<PlaylistBloc>(context).add(SaveSongIDEvent(songID: widget.songID));
                    print("true");
                  }else{
                    BlocProvider.of<PlaylistBloc>(context).add(RemoveMusicFromPlaylistEvent(musicID: widget.songID!));
                    BlocProvider.of<PlaylistBloc>(context).add(RemoveSongIDEvent(songID: widget.songID));
                    print("false");
                  }
                },
                child: ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.0).animate(
                        CurvedAnimation(parent: widget.controller, curve: Curves.easeOut)),
                    child: isFavorite
                        ? const Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    )
                        : const Icon(
                      Icons.favorite_border,
                      size: 30,
                    )


                ),
              )
          );});
  }
}
