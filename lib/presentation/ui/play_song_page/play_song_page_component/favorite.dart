import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/play_list_bloc/bloc.dart';
import '../../../bloc/play_list_bloc/event.dart';
import '../../../bloc/play_list_bloc/state.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.controller, required this.songID});

  final AnimationController controller;
  final int songID;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaylistBloc, PlaylistState>(
        listener: (context, state){
          if(state.status.isSuccess){
            if(isFavorite){
              Fluttertoast.showToast(
                  msg: "Add to playlist ...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 3,
                  backgroundColor: const Color(
                      0xFF00B01E).withOpacity(0.2),
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }else{
              Fluttertoast.showToast(
                  msg: "Remove from playlist ...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 3,
                  backgroundColor: const Color(
                      0xFF00B01E).withOpacity(0.2),
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }

          }else if(state.status.isError){
            Fluttertoast.showToast(
                msg: "Something with wrong ...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 3,
                backgroundColor: const Color(
                    0xFFC20808).withOpacity(0.2),
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (context, state) {
          isFavorite = state.isFavorite;
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
                    BlocProvider.of<PlaylistBloc>(context).add(AddMusicToPlaylistEvent(songID: widget.songID));
                    BlocProvider.of<PlaylistBloc>(context).add(SaveSongIDEvent(songID: widget.songID));
                    print("true");
                  }else{
                    BlocProvider.of<PlaylistBloc>(context).add(RemoveMusicFromPlaylistEvent(musicID: widget.songID));
                    BlocProvider.of<PlaylistBloc>(context).add(RemoveSongIDEvent(songID: widget.songID));
                    print("false");
                  }
                },
                child: ScaleTransition(
                    scale: Tween(begin: 0.7, end: 1.0).animate(
                        CurvedAnimation(parent: widget.controller, curve: Curves.easeOut)),
                    child: isFavorite
                        ? Icon(
                      Icons.bookmark_border,
                      size: MediaQuery.of(context).size.height / 30,
                      color: Colors.red,
                    )
                        : Icon(
                      Icons.bookmark_border,
                      size: MediaQuery.of(context).size.height / 30,
                    )


                ),
              )
          );});
  }
}
