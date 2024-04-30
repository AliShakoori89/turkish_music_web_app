import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/song_model.dart';
import '../../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../../bloc/play_box_bloc/bloc.dart';
import '../../../../bloc/play_box_bloc/state.dart';
import '../play_song_page.dart';

class AllSongsList extends StatelessWidget {
  const AllSongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBoxBloc, PlayBoxState>(
        builder: (context, state) {

          return ListView.builder(
            itemCount: state.playBoxSong!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,
                int index) {
              return InkWell(

                onTap: (){

                  SongDataModel songDataModel = SongDataModel();
                  songDataModel.id = state.playBoxSong![index].id;
                  songDataModel.name = state.playBoxSong![index].name;
                  songDataModel.imageSource = state.playBoxSong![index].imageSource;
                  songDataModel.fileSource = state.playBoxSong![index]
                      .fileSource.substring(0, 4)
                      + "s"
                      + state.playBoxSong![index]
                          .fileSource.substring(4, state.playBoxSong![index]
                          .fileSource.length);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                                songModel: songDataModel
                            )),
                            child: PlayMusicPage(
                                songName: state.playBoxSong![index]
                                    .name,
                                songFile: state.playBoxSong![index]
                                    .fileSource
                            ),

                          )),
                      ModalRoute.withName("/")
                  );
                },
                child: Container(
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
                                image: NetworkImage(
                                    state.playBoxSong![index]
                                        .imageSource),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        children: [
                          Text(state.playBoxSong![index].name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          Text(state.playBoxSong![index].singer
                              .name,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white54
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
