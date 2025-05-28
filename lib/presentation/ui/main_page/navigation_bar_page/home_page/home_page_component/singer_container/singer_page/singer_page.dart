import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/main_page.dart';
import 'package:turkish_music_app/presentation/ui/main_page/navigation_bar_page/home_page/home_page.dart';
import '../../../../../../../../data/model/singer_model.dart';
import '../../../../../../../../data/model/song_model.dart';
import '../../../../../../../const/generate_new_path.dart';
import '../../../../../../../const/shimmer_container/singer_page_shimmer_container.dart';
import '../../../../../../../helpers/widgets/back_button_if_ios_web.dart';
import '../../../../../../play_song_page/play_song_page.dart';

class SingerPage extends StatefulWidget {

  static String routeName = "SingerPage";
  final SingerDataModel artistDetail;

  const SingerPage({super.key, required this.artistDetail});

  @override
  State<SingerPage> createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AlbumBloc>(context).add(ResetAlbumStateEvent()); // Reset state on navigation.
    BlocProvider.of<AlbumBloc>(context).add(GetSingerAllAlbumEvent(id: widget.artistDetail.id));
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return WillPopScope(
      onWillPop: () async {

          context.replace(HomePage.routeName); // یا context.pop();
          return true; // یعنی نذار خود Flutter بره عقب

      },
      child: Scaffold(
          body: orientation == Orientation.portrait
              ? BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

            var singerAllAlbum = state.singerAllAlbum;

            return Container(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: buildBackButtonIfIosWeb(),
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
                          placeholderFadeInDuration: Duration(milliseconds: 1),
                          fadeInDuration: Duration(milliseconds: 1),
                          useOldImageOnUrlChange: false,
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
                    delegate: SliverChildBuilderDelegate((context, index) {

                      if(state.status.isLoading){
                        return SingerPageShimmerContainer();
                      }else if(state.status.isSuccess){
                        return GestureDetector(
                          onTap: (){

                            var newPath = state.singerAllAlbum[index].musics![0].fileSource!.replaceAll(" ", "%20");

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

                            context.push(
                              '/'+PlaySongPage.routeName,
                              extra: {
                                'songName': songDataModel.name,
                                'songFile': newPath,
                                'songID': songDataModel.id!,
                                'singerName': widget.artistDetail.name,
                                'songImage': state.singerAllAlbum[index].imageSource,
                                'albumID': songDataModel.albumId!,
                                'pageName': "SingerPage",
                                'albumSongList': state.singerAllAlbum[index].musics!,
                                'songDataModel': songDataModel,
                                'categoryID': 0
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: CachedNetworkImage(
                                    useOldImageOnUrlChange: false,
                                    imageUrl: singerAllAlbum[index]
                                        .imageSource!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          height: MediaQuery.of(context).size.width * 0.6,
                                          decoration: BoxDecoration(
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
                                    child: Text(singerAllAlbum[index].name!,
                                      maxLines: 1,))
                              ],
                            ),
                          ),
                        );
                      }else if(state.status.isError){
                        return Center(child: Text("error"),);
                      }
                      return Container();
                    },
                        childCount: singerAllAlbum.length

                    ),

                  )
                ],
              ),
            );;
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
                      return GestureDetector(
                        onTap: (){
                          var newPath = state.singerAllAlbum[index].musics![0].fileSource!.replaceAll(" ", "%20");

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

                          context.push(
                            '/'+PlaySongPage.routeName,
                            extra: {
                              'songName': songDataModel.name,
                              'songFile': newPath,
                              'songID': songDataModel.id!,
                              'singerName': widget.artistDetail.name,
                              'songImage': state.singerAllAlbum[index].imageSource,
                              'albumID': songDataModel.albumId!,
                              'pageName': "SingerPage",
                              'albumSongList': state.singerAllAlbum[index].musics!,
                              'songDataModel': songDataModel,
                              'categoryID': 0
                            },
                          );
                        },
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
                      );
                    });
              })
          )
      ),
    );
  }
}
