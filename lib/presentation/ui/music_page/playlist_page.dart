import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/play_list_bloc/bloc.dart';
import '../../bloc/play_list_bloc/state.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaylistBloc, PlaylistState>(builder: (context, state)
    {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        cacheExtent: 1000,
        itemCount: state.playlistSongs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white30.withOpacity(
                    0.1),
                borderRadius: BorderRadius.circular(
                    15)
            ),
            margin: const EdgeInsets.only(
              top: 15,
            ),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(
                      right: 5
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius
                          .circular(15),
                      image: DecorationImage(
                          image: NetworkImage(state.playlistSongs[index].imageSource.toString()),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.playlistSongs[index].name!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
              ],
            ),
          );
        }
      );
    })
    );
  }
}
