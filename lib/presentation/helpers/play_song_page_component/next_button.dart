import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/new-song_model.dart';
import '../../../data/model/song_model.dart';
import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../bloc/song_bloc/bloc.dart';
import '../../bloc/song_bloc/event.dart';
import '../../bloc/song_bloc/state.dart';

class NextButton extends StatefulWidget {
  NextButton({super.key, required this.pageName, this.albumSongList,
  this.newSongList, this.songList, required this.albumID});

  final String pageName;
  final int albumID;
  List<SongDataModel>? songList;
  List<NewSongDataModel>? newSongList;
  List<AlbumDataMusicModel>? albumSongList;

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  
  @override
  void initState() {
    print("album id:                                                       "+widget.pageName);
    print("album id:                                                       "+widget.albumID.toString());
    BlocProvider.of<SongBloc>(context).add(FetchAllSongs());
    BlocProvider.of<SongBloc>(context).add(FetchAlbumSongs(id: widget.albumID));
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(builder: (context, state) {

      return IconButton(
          padding: const EdgeInsets.all(1),
          onPressed: () {
            if (widget.pageName == "SingerPage") {
              context
                  .read<CurrentSelectedSongBloc>()
                  .add(PlayPreviousSong(songs: state.albumSongList));
            } else {
              context
                  .read<CurrentSelectedSongBloc>()
                  .add(PlayPreviousSong(songs: state.newSongList));
            }
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
              child: const Icon(Icons.skip_next_rounded,
                color: Colors.white,)));
    });
  }
}
