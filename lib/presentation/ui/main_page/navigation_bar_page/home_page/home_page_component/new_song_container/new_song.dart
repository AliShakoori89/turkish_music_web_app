import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../data/model/album_model.dart';
import '../../../../../../../data/model/new-song_model.dart';
import '../../../../../../../data/model/song_model.dart';
import '../../../../../../bloc/new_song_bloc/bloc.dart';
import '../../../../../../bloc/new_song_bloc/event.dart';
import '../../../../../../bloc/new_song_bloc/state.dart';
import '../../../../../../const/generate_new_path.dart';
import '../../../../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../../../play_song_page/play_song_page.dart';

class NewSong extends StatefulWidget {

  @override
  State<NewSong> createState() => _NewSongState();
}

class _NewSongState extends State<NewSong>{

  @override
  void initState() {
    BlocProvider.of<NewSongBloc>(context).add(GetNewSongEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;

    return BlocBuilder<NewSongBloc, NewSongState>(builder: (context, state) {

      List<NewSongDataModel> newSong = state.newSong;

      return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CarouselSlider(
              options: CarouselOptions(
                height: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height / 3
                    : width < 700
                        ? MediaQuery.of(context).size.height / 2
                        : MediaQuery.of(context).size.height / 2.5,
                viewportFraction:
                    orientation == Orientation.portrait ? 0.7 : 0.5,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                clipBehavior: Clip. hardEdge,
                autoPlay: false,
                enlargeCenterPage: true,
                pageSnapping: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) {
                  setState(() {});
                },
              ),
              items: List.generate(newSong.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {

                      var newPath = state.newSong[index].fileSource!.replaceAll(" ", "%20");

                      SongDataModel songDataModel = SongDataModel(
                        id: state.newSong[index].id,
                        name: state.newSong[index].name,
                        imageSource: state.newSong[index].imageSource,
                        fileSource: newPath,
                        minute: state.newSong[index].minute,
                        second: state.newSong[index].second,
                        singerName: state.newSong[index].singerName,
                        album: null,
                        albumId: state.newSong[index].albumId,
                        categories: null,
                      );

                      context.push(
                        '/' + PlaySongPage.routeName,
                        extra: {
                          'songName': songDataModel.name,
                          'songFile': newPath,
                          'songID': songDataModel.id!,
                          'singerName': songDataModel.singerName,
                          'songImage': songDataModel.imageSource,
                          'albumID': songDataModel.albumId!,
                          'pageName': "NewSong",
                          'albumSongList': state.newSong
                              .map((categoryMusic) =>
                                  AlbumDataMusicModel.fromNewSongDataModel(
                                      categoryMusic))
                              .toList(),
                          'songDataModel': songDataModel,
                          'categoryID': 0
                        },
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: newSong[index].imageSource!,
                      imageBuilder: (context, imageProvider) => Container(
                          width: orientation == Orientation.portrait
                              ? null
                              : MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.purple.withValues(alpha: 0.5),
                                  strokeAlign: BorderSide.strokeAlignOutside),
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                filterQuality: FilterQuality.low,
                                  image: NetworkImage(newSong[index].imageSource!),
                                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.multiply),
                                  fit: BoxFit.fitWidth)),
                          child: CachedNetworkImage(
                              imageUrl: newSong[index].imageSource!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0),
                                        image: DecorationImage(
                                      image: NetworkImage(
                                          newSong[index].imageSource!),
                                      fit: BoxFit.contain,
                                    )),
                                  ))),
                      placeholder: (context, url) => NewSongShimmerContainer(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              })));
    });
  }
}
