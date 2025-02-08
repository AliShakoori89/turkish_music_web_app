import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/new_song_bloc/state.dart';

import '../../../../../../../../data/model/album_model.dart';
import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../../const/generate_new_path.dart';
import '../../../../../../../helpers/widgets/song_card.dart';
import '../../../../../../play_song_page/play_song_page.dart';

class AllNewSongsPage extends StatefulWidget {

  static String routeName = "AllNewSongsPage";

  const AllNewSongsPage({super.key});

  @override
  State<AllNewSongsPage> createState() => _AllNewSongsPageState();
}

class _AllNewSongsPageState extends State<AllNewSongsPage> {

  @override
  void initState() {
    BlocProvider.of<NewSongBloc>(context).add(GetAllNewSongEvent());
    super.initState();
  }

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
                itemCount: state.allNewSong.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){

                      var path = generateNewPath(state.allNewSong[index].fileSource!);

                      var newPath = path.replaceAll(" ", "%20");

                      SongDataModel songDataModel = SongDataModel(
                        id : state.allNewSong[index].id,
                        name: state.allNewSong[index].name,
                        imageSource: state.allNewSong[index].imageSource,
                        fileSource: newPath,
                        minute: state.allNewSong[index].minute,
                        second: state.allNewSong[index].second,
                        singerName: state.allNewSong[index].singerName,
                        album: null,
                        albumId: state.allNewSong[index].albumId,
                        categories: null,
                      );

                      context.push(
                        '/'+PlaySongPage.routeName,
                        extra: {
                          'songName': songDataModel.name,
                          'songFile': newPath,
                          'songID': songDataModel.id!,
                          'singerName': songDataModel.singerName,
                          'songImage': songDataModel.imageSource,
                          'albumID': songDataModel.albumId!,
                          'pageName': "AllNewSongsPage",
                          'albumSongList': state.allNewSong.map((categoryMusic) => AlbumDataMusicModel.fromNewSongDataModel(categoryMusic))
                              .toList(),
                          'songDataModel': songDataModel,
                          'categoryID': 0
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
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  left: 15
                                ),
                                child: Text((index+1).toString()),
                              )),
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
                                          color: Colors.purple.withValues(alpha: 0.5),
                                      )
                                    ]
                                ),
                                child: SongCard(
                                    songName: state.allNewSong[index].name!,
                                    imgPath: state.allNewSong[index].imageSource!,
                                    singerName: state.allNewSong[index].singerName!)
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
