import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/play_list_bloc/event.dart';
import '../bloc/play_list_bloc/bloc.dart';
import '../bloc/play_list_bloc/state.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<PlaylistBloc>(context).add(GetAllMusicInPlaylistEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text("Playlist"),
        centerTitle: true,
      ),
        body: BlocBuilder<PlaylistBloc, PlaylistState>(builder: (context, state) {

          return ListView.builder(
              scrollDirection: Axis.vertical,
              cacheExtent: 1000,
              itemCount: state.playlistSongs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white30.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(state
                                        .playlistSongs[index].imageSource
                                        .toString()),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.playlistSongs[index].name!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                state.playlistSongs[index].singerName!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white54
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: (){
                            BlocProvider.of<PlaylistBloc>(context).add(
                                RemoveMusicFromPlaylistEvent(musicID: state.playlistSongs[index].id!));
                            BlocProvider.of<PlaylistBloc>(context).add(RemoveSongIDEvent(songID: state.playlistSongs[index].id!));
                          },
                          icon: Icon(Icons.close,
                          size: 15,))
                    ],
                  ),
                );
              });
        })
    );
  }
}
