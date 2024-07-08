import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turkish_music_app/presentation/helpers/play_song_page_component/playing_song_animation.dart';
import '../../../../../data/model/album_model.dart';
import '../../../../../data/model/new-song_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../../generated/assets.dart';
import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';
import '../../ui/play_song_page.dart';

class ContainerAllSongsList extends StatelessWidget {

  List<SongDataModel>? songList;
  List<NewSongDataModel>? newSongList;
  List<AlbumDataMusicModel>? albumSongList;
  final String songName;


  ContainerAllSongsList({super.key, this.songList, this.newSongList, this.albumSongList, required this.songName});

  @override
  Widget build(BuildContext context) {

    print("songName             "+songName);


    return ListView.builder(
            itemCount: songList != null
                ? songList!.length
                : newSongList != null
                ? newSongList!.length
                : albumSongList!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            cacheExtent: 1000,
            itemBuilder: (BuildContext context, int index) {

              return InkWell(
                onTap: (){

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
                            child: PlaySongPage(
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
                              songID: songList != null
                                  ? songList![index].id!
                                  : newSongList != null ? newSongList![index].id
                                  : albumSongList![index].id!,
                              songImage: songList != null
                                  ? songList![index].imageSource!
                                  : newSongList != null ? newSongList![index].imageSource
                                  : albumSongList![index].imageSource!,
                              singerName: songList != null
                                  ? songList![index].singerName!
                                  : newSongList != null ? newSongList![index].singer.name
                                  : "",
                              pageName: "ContainerAllSongsList",
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
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              margin: const EdgeInsets.only(
                                  right: 5
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: songList != null
                                    ? songList![index].imageSource!
                                    : newSongList != null
                                    ? newSongList![index].imageSource
                                    : albumSongList![0].imageSource!,
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.grey[400]!,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          shape: BoxShape.circle),
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.width * 0.2
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(Assets.imagesNoImage)
                                        ),
                                        color: Colors.black12,
                                        shape: BoxShape.circle),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.width * 0.2
                                )
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
                            albumSongList == null
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(songList != null
                                    ? songList![index].name!
                                    : newSongList![index].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text(songList != null
                                    ? songList![index].album!.singer!.name!
                                    : newSongList![index].singer.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white54
                                  ),)

                              ],
                            )
                                : Text(albumSongList![index].name!,)
                          ],
                        ),
                        albumSongList != null
                            ? albumSongList![index].name == songName
                                ? PlayingSongAnimation()
                                : Container()
                        : newSongList != null
                            ? newSongList![index].name == songName
                                ? PlayingSongAnimation()
                                : Container()
                            : Container(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        // });
  }
}
