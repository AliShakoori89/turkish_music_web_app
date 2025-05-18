import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';
import 'package:turkish_music_app/presentation/const/no_image.dart';
import '../../../../../data/model/album_model.dart';
import '../../../../../data/model/song_model.dart';
import '../../../bloc/play_button_state_bloc/bloc.dart';
import '../../../bloc/play_button_state_bloc/event.dart';
import '../../../bloc/song_control_bloc/audio_control_bloc.dart';
import '../../../const/generate_new_path.dart';
import '../../../const/shimmer_container/playing_page_album_song_list_shimmer.dart';

class ContainerAllSongsList extends StatelessWidget {

  final List<AlbumDataMusicModel> categoryAllSongs;
  final String songName;
  final String singerName;
  final int songID;


  ContainerAllSongsList({super.key, required this.categoryAllSongs, required this.songName,
    required this.singerName, required this.songID});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: categoryAllSongs.length,
      cacheExtent: 1000,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

        return InkWell(
          onTap: (){

            var newPath = categoryAllSongs[index].fileSource!.replaceAll(" ", "%20");

            SongDataModel songDataModel = SongDataModel(
              id : categoryAllSongs[index].id,
              name: categoryAllSongs[index].name,
              imageSource: categoryAllSongs[index].imageSource,
              fileSource: newPath,
              minute: categoryAllSongs[index].minute,
              second: categoryAllSongs[index].second,
              singerName: singerName,
              album: null,
              albumId: categoryAllSongs[index].albumId,
              categories: null,
            );

            context
                .read<AudioControlBloc>()
                .add(PlaySelectedSongEvent(
                currentSong: songDataModel,
                currentAlbum: categoryAllSongs,
            ));

            context
                .read<PlayButtonStateBloc>()
                .add(SetPlayButtonStateEvent(playButtonState: true));

            },
          child: Container(
            decoration: BoxDecoration(
                color: categoryAllSongs[index].name == songName
                    ? Colors.white30.withValues(alpha: 0.5)
                    : Colors.white30.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15)
            ),
            margin: const EdgeInsets.only(
              top: 15,
            ),
            child: Container(
              margin: const EdgeInsets.only(
                right: 20,
                left: 10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Row(
                      children: [
                        categoryAllSongs.length != 1
                            ? categoryAllSongs.first.name == categoryAllSongs[1].name &&
                            categoryAllSongs.first.singerName == categoryAllSongs.last.singerName
                            ? Container(
                          height: 50,
                        )
                            : Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            width: 40,
                            margin: const EdgeInsets.only(right: 5),
                            child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: categoryAllSongs[index].imageSource!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    PlayingPageAlbumSongListShimmer(),
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
                          flex: 1,
                          child: Container(
                            height: 50,
                            width: 40,
                            margin: const EdgeInsets.only(right: 5),
                            child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: categoryAllSongs[index].imageSource!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    PlayingPageAlbumSongListShimmer(),
                                errorWidget: (context, url, error) => NoImage()),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        categoryAllSongs[index]
                                            .imageSource!),
                                    fit: BoxFit.cover)),
                          ),
                        ) ,
                        const SizedBox(width: 5,),
                        categoryAllSongs.length != 1 ?
                          categoryAllSongs.isNotEmpty &&
                          categoryAllSongs.first.name != categoryAllSongs[1].name &&
                          categoryAllSongs.first.name != categoryAllSongs.last.name
                            ? Expanded(
                          flex: 4,
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
                          flex: 4,
                          child: OverflowTextAnimated(
                            text: categoryAllSongs[index].name!,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                        )
                            : Expanded(
                          flex: 4,
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
                      flex: 1,
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
