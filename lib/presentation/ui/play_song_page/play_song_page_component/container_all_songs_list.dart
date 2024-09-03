import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turkish_music_app/presentation/const/no_image.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/playing_song_animation.dart';
import '../../../../../data/model/album_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../../../generated/assets.dart';
import '../../../bloc/current_selected_song/current_selected_song_bloc.dart';
import '../play_song_page.dart';

class ContainerAllSongsList extends StatelessWidget {

  final List<AlbumDataMusicModel> categoryAllSongs;
  final String songName;
  final String singerName;
  final Orientation orientation;


  ContainerAllSongsList({super.key, required this.categoryAllSongs, required this.songName, required this.singerName, required this.orientation});

  @override
  Widget build(BuildContext context) {

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
                      create: (context) => CurrentSelectedSongBloc()..add(SelectSongEvent(
                          songModel: songDataModel
                      )),
                      child: PlaySongPage(
                        songName: categoryAllSongs[index].name!,
                        songFile: newPath,
                        albumID: songDataModel.albumId!,
                        albumSongList: categoryAllSongs,
                        songID: categoryAllSongs[index].id!,
                        songImage: categoryAllSongs[index].imageSource!,
                        singerName: singerName,
                        pageName: "ContainerAllSongsList",
                        orientation: orientation,
                      ),

                    )),
                ModalRoute.withName("/")
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white30.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15)
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
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        categoryAllSongs[0].singerName != categoryAllSongs[1].singerName
                            ? Expanded(
                          flex: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.width / 13,
                            width: MediaQuery.of(context).size.width / 12,
                            margin: const EdgeInsets.only(right: 5),
                            child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: categoryAllSongs[index].imageSource!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.black12,
                                      highlightColor: Colors.grey[400]!,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.black12,
                                              shape: BoxShape.circle),
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.width * 0.2),
                                    ),
                                errorWidget: (context, url, error) => NoImage()),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        categoryAllSongs[index]
                                            .imageSource!),
                                    fit: BoxFit.cover)),
                          ),
                        )
                            : Expanded(
                            flex: 0,
                            child: Container()),
                        const SizedBox(width: 5,),
                        categoryAllSongs.isEmpty
                            ? Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OverflowTextAnimated(
                                text: categoryAllSongs[index].name!,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                              Text(categoryAllSongs[index].singerName!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white54
                                ),)
                            ],
                          ),
                        )
                            : Expanded(
                          flex: 2,
                          child: OverflowTextAnimated(
                            text: categoryAllSongs[index].name!,
                            style: TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  categoryAllSongs[index].name == songName
                      ? Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 50,
                          child: Icon(Icons.play_arrow)))
                      : Expanded(
                      flex: 0,
                      child: Container())
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
