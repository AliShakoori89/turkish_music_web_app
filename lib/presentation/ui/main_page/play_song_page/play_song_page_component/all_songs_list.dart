import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/model/album_model.dart';
import '../../../../../data/model/new-song_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../../../bloc/play_box_bloc/bloc.dart';
import '../../../../bloc/play_box_bloc/state.dart';
import '../play_song_page.dart';

class AllSongsList extends StatelessWidget {

  List<SongDataModel>? songList;
  List<NewSongDataModel>? newSongList;
  List<AlbumDataMusicModel>? albumSongList;


  AllSongsList({super.key, this.songList, this.newSongList, this.albumSongList});

  @override
  Widget build(BuildContext context) {

    print("%%%%%%%%%%%              "+albumSongList!.length.toString());
    return
      // BlocBuilder<PlayBoxBloc, PlayBoxState>(
      //   builder: (context, state)

          // return
            ListView.builder(
            itemCount: songList != null ? songList!.length : newSongList != null ? newSongList!.length : albumSongList!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            cacheExtent: 1000,
            itemBuilder: (BuildContext context, int index) {

              print(index);
              return InkWell(

                onTap: (){

                  print(index);

                  var path = songList != null
                      ? songList![index]
                      .fileSource!.substring(0, 4)
                      + "s"
                      + songList![index]
                          .fileSource!.substring(4, songList![index]
                          .fileSource!.length)
                      : newSongList != null ? newSongList![index]
                      .fileSource.substring(0, 4)
                      + "s"
                      + newSongList![index]
                          .fileSource.substring(4, newSongList![index]
                          .fileSource.length)
                      : albumSongList![index].fileSource!
                      .substring(0, 4)
                      + "s"
                      + albumSongList![index].fileSource!.substring(4, albumSongList![index].fileSource!.length);

                  var newPath = path.replaceAll(" ", "%20");

                  print("fileSource              "+newPath);

                  SongDataModel songDataModel = SongDataModel(
                  id: songList != null ? songList![index].id : newSongList != null ? newSongList![index].id : albumSongList![index].id,
                  name: songList != null ? songList![index].name : newSongList != null ? newSongList![index].name : albumSongList![index].name,
                  imageSource: songList != null ? songList![index].imageSource : newSongList != null ? newSongList![index].imageSource : albumSongList![index].imageSource,
                  fileSource: newPath,
                  second: songList != null ? songList![index].second : newSongList != null ? newSongList![index].second : albumSongList![index].second,
                  minute:  songList != null ? songList![index].minute : newSongList != null ? newSongList![index].minute : albumSongList![index].minute,
                  categories: null,
                  albumId: null,
                  album: null);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                                songModel: songDataModel
                            )),
                            child: PlayMusicPage(
                              songName: songList != null
                                  ? songList![index].name!
                                  : newSongList != null ? newSongList![index].name
                                  : albumSongList![index].name!,
                              songFile: songList != null
                                  ? songList![index].fileSource!
                                  : newSongList != null ? newSongList![index].fileSource
                                  : albumSongList![index].fileSource!,
                              songList: songList,
                              newSongList: newSongList,
                              albumSongList: albumSongList,
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
                                  songList != null
                                      ? songList![index].imageSource!
                                      : newSongList != null
                                      ? newSongList![index].imageSource
                                      : albumSongList![0].imageSource!),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        children: [
                          Text(songList != null
                              ? songList![index].name!
                              : newSongList != null
                              ? newSongList![index].name
                              : albumSongList![index].name!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          songList != null 
                              ? Text(songList != null
                              ? songList![index].album!.singer!.name!
                              : newSongList != null ? newSongList![index].singer.name
                              : "",
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white54
                            ),)
                              : Text("")
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        // });
  }
}
