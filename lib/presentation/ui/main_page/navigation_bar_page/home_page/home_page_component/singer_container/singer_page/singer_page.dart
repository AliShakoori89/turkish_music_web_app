import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/custom_indicator.dart';
import '../../../../../../../../data/model/singer_model.dart';
import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../../const/shimmer_container/singer_page_shimmer_container.dart';
import '../../../../../../play_song_page/play_song_page_component/play_song_page/play_song_page.dart';

class SingerPage extends StatefulWidget {

  SingerPage({super.key, required this.artistDetail});

  final SingerDataModel artistDetail;

  @override
  State<SingerPage> createState() => _SingerPageState(artistDetail);
}

class _SingerPageState extends State<SingerPage> {

  final SingerDataModel artistDetail;
  _SingerPageState(this.artistDetail);

  @override
  void initState() {
    BlocProvider.of<AlbumBloc>(context).add(GetSingerAllAlbumEvent(id: widget.artistDetail.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop){
        if (kDebugMode) {
          Navigator.of(context).pushNamed('/');
        }
      },
      child: Scaffold(
        body: orientation == Orientation.portrait
            ? BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

          var singerAllAlbum = state.singerAllAlbum;

          if(state.status.isLoading){
            return CustomIndicator();
          }
          else if(state.status.isSuccess){
            return Container(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(widget.artistDetail.name),
                    backgroundColor: Colors.black,
                    expandedHeight: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height / 4.2
                        : MediaQuery.of(context).size.height / 1.5,
                    stretch: true,
                    stretchTriggerOffset: 40,
                    pinned: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: CachedNetworkImage(
                          imageUrl: widget.artistDetail.imageSource,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      widget.artistDetail.imageSource,
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                            margin: EdgeInsets.only(
                                left: 50,
                                right: 50,
                                top: 40,
                                bottom: 10
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                    ),

                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: MediaQuery.of(context).size.width / 1.5,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 1.0,
                        mainAxisExtent: MediaQuery.of(context).size.width / 2),
                    delegate: SliverChildBuilderDelegate((context, index) =>
                        GestureDetector(
                          onTap: (){

                            var path = state.singerAllAlbum[index].musics![0].fileSource!.substring(0, 4)
                                + "s"
                                + state.singerAllAlbum[index].musics![0].fileSource!.substring(4, state.singerAllAlbum[index].musics![0].fileSource?.length);

                            var newPath = path.replaceAll(" ", "%20");

                            SongDataModel songDataModel = SongDataModel(
                                id : state.singerAllAlbum[index].musics![0].id,
                                name: state.singerAllAlbum[index].musics![0].name,
                                imageSource: state.singerAllAlbum[index].musics![0].imageSource,
                                fileSource: newPath,
                                minute: state.singerAllAlbum[index].musics![0].minute,
                                second: state.singerAllAlbum[index].musics![0].second,
                                singerName: widget.artistDetail.name,
                                album: null,
                                albumId: state.singerAllAlbum[index].id,
                                categories: null,
                            );

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlaySongPage(
                                  songName: state.singerAllAlbum[index].name!,
                                  songFile: newPath,
                                  songID: songDataModel.id!,
                                  singerName: widget.artistDetail.name,
                                  songImage: state.singerAllAlbum[index].imageSource!,
                                  albumID: songDataModel.albumId!,
                                  pageName: "SingerPage",
                                  albumSongList: state.singerAllAlbum[index].musics!,
                                  songDataModel: songDataModel,
                                )
                              ),
                            );

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BlocProvider(
                            //           create: (context) => AudioControlBloc()..add(PlaySongEvent(
                            //             currentSong: songDataModel,
                            //             currentAlbum: state.singerAllAlbum[index].musics!
                            //           )),
                            //           child: PlaySongPage(
                            //             songName: state.singerAllAlbum[index].name!,
                            //             songFile: newPath,
                            //             songID: songDataModel.id!,
                            //             singerName: widget.artistDetail.name,
                            //             songImage: state.singerAllAlbum[index].imageSource!,
                            //             albumID: songDataModel.albumId!,
                            //             pageName: "SingerPage",
                            //             albumSongList: state.singerAllAlbum[index].musics!,
                            //             orientation: widget.orientation,
                            //           ),
                            //
                            //         )));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              // bottom: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: CachedNetworkImage(
                                    imageUrl: singerAllAlbum[index]
                                        .imageSource!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          height: MediaQuery.of(context).size.width * 0.6,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.purple.withOpacity(0.5),
                                                  blurRadius: 20,
                                                ),
                                              ],
                                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    singerAllAlbum[index]
                                                        .imageSource!),
                                                fit: BoxFit.fill,
                                              )
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        SingerPageShimmerContainer(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Text(singerAllAlbum[index].name!))
                              ],
                            ),
                          ),
                        ),
                        childCount: singerAllAlbum.length
                    ),

                  )
                ],
              ),
            );
          }
          else if(state.status.isError){
            return Container();
          }
          return Container();
        })
            : Container(
          margin: EdgeInsets.all(15),
          child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state){
            var singerAllAlbum = state.singerAllAlbum;
            return GridView.builder(
              itemCount: singerAllAlbum.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                crossAxisSpacing: 30,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
                  mainAxisExtent: size.width / 3
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Flexible(
                        flex: 5,
                        child: CachedNetworkImage(
                          imageUrl: singerAllAlbum[index]
                              .imageSource!,
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.6,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.purple.withOpacity(0.5),
                                        blurRadius: 20,
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          singerAllAlbum[index]
                                              .imageSource!),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ),
                          placeholder: (context, url) =>
                              SingerPageShimmerContainer(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Flexible(
                          flex: 1,
                          child: Text(singerAllAlbum[index].name!))
                    ],
                  );
              });
          })
        )
      )
    );
  }
}
