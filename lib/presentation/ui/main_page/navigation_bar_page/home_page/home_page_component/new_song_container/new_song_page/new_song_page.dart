import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/state.dart';

import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../../helpers/widgets/song_card.dart';
import '../../../../../../play_song_page/play_song_page.dart';

class NewSongPage extends StatelessWidget {

  static String routeName = "NewSongPage";

  const NewSongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Songs'),
        centerTitle: true,
      ),
      body: BlocBuilder<NewSongBloc, NewSongState>(

          builder: (context, state) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: state.newSong.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){

                      var path = state.newSong[index].fileSource!.substring(0, 4)
                          + "s"
                          + state.newSong[index].fileSource!
                              .substring(4, state.newSong[index].fileSource!.length);

                      var newPath = path.replaceAll(" ", "%20");

                      SongDataModel songDataModel = SongDataModel(
                        id : state.newSong[index].id,
                        name: state.newSong[index].name,
                        imageSource: state.newSong[index].imageSource,
                        fileSource: newPath,
                        minute: state.newSong[index].minute,
                        second: state.newSong[index].second,
                        singerName: "",
                        album: null,
                        albumId: state.newSong[index].albumId,
                        categories: null,
                      );

                      context.push(
                        '/'+PlaySongPage.routeName,
                        extra: {
                          'songName': songDataModel.name,
                          'songFile': songDataModel.fileSource,
                          'songID': songDataModel.id!,
                          'singerName': "",
                          'songImage': "http://194.5.195.145/TurkishMusicFiles/MusicPhotos/2024-10-02-08-33-30-Sibel-Can-Bu-Devirde-1997.jpg",
                          'albumID': songDataModel.albumId!,
                          'pageName': "RecentlyPlaylist",
                          'albumSongList': state.newSong[index],
                          'songDataModel': songDataModel,
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 15
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Expanded(
                                flex: 1,
                                child: Text((index+1).toString())),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 15,
                            child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 1,
                                          offset: Offset(0, 2),
                                          color: Colors.purple.withOpacity(0.5)
                                      )
                                    ]
                                ),
                                child: SongCard(
                                    songName: state.newSong[index].name!,
                                    imgPath: state.newSong[index].imageSource!,
                                    singerName: state.newSong[index].singerName!)
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          })

    );
  }
}
