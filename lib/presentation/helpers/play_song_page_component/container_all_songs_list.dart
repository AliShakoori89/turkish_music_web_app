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

  final List<AlbumDataMusicModel> categoryAllSongs;
  final String songName;
  final String singerName;


  ContainerAllSongsList({super.key, required this.categoryAllSongs, required this.songName, required this.singerName});

  @override
  Widget build(BuildContext context) {

    // print("Singer Name                            "+categoryAllSongs[0].singerName!);

    return ListView.builder(
            itemCount: categoryAllSongs.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            cacheExtent: 1000,
            itemBuilder: (BuildContext context, int index) {

              return InkWell(
                onTap: (){

                  var path = categoryAllSongs[index].fileSource!
                      .substring(0, 4)
                      + "s"
                      + categoryAllSongs[index].fileSource!.substring(4, categoryAllSongs[index].fileSource!.length);

                  var newPath = path.replaceAll(" ", "%20");

                  SongDataModel songDataModel = SongDataModel(
                    id : categoryAllSongs[index].id,
                    name: categoryAllSongs[index].name,
                    imageSource: categoryAllSongs[index].imageSource,
                    fileSource: categoryAllSongs[index].fileSource!.substring(0, 4)
                        + "s"
                        + categoryAllSongs[index].fileSource!.substring(4, categoryAllSongs[index].fileSource!.length),
                    singerName: singerName,
                    minute: categoryAllSongs[index].minute,
                    second: categoryAllSongs[index].second,
                    albumId: categoryAllSongs[index].albumId,
                  );

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                                songModel: songDataModel
                            )),
                            child: PlaySongPage(
                              songName: categoryAllSongs[index].name!,
                              songFile: newPath,
                              albumSongList: categoryAllSongs,
                              songID: categoryAllSongs[index].id!,
                              songImage: categoryAllSongs[index].imageSource!,
                              singerName: singerName,
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
                                imageUrl: categoryAllSongs![index].imageSource!,
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
                                      image: NetworkImage(categoryAllSongs![index].imageSource!),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            const SizedBox(width: 5,),
                            categoryAllSongs == null
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(categoryAllSongs![index].name!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text(categoryAllSongs![index].singerName!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white54
                                  ),)

                              ],
                            )
                                : Text(categoryAllSongs![index].name!,)
                          ],
                        ),
                        categoryAllSongs![index].name == songName
                            ? PlayingSongAnimation()
                            : Container()
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
