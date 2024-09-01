import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/const/title.dart';
import 'package:turkish_music_app/presentation/helpers/widgets/under_image_singar_and_song_name.dart';
import '../../../../../../data/model/song_model.dart';
import '../../../../../bloc/album_bloc/event.dart';
import '../../../../../bloc/current_selected_song/current_selected_song_bloc.dart';
import '../../../../../const/shimmer_container/new_music_shimmer_container.dart';
import '../../../../play_song_page/play_song_page.dart';

class NewAlbumContainer extends StatefulWidget {
  const NewAlbumContainer({super.key, required this.orientation});

  final Orientation orientation;

  @override
  State<NewAlbumContainer> createState() => _NewAlbumContainerState();
}

class _NewAlbumContainerState extends State<NewAlbumContainer> {

  @override
  void initState() {
    BlocProvider.of<AlbumBloc>(context).add(GetNewAlbumEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        TitleText(title: "New Album", haveSeeAll: false, orientation: widget.orientation,),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.09,
            right: MediaQuery.of(context).size.width * 0.09,
          ),
          child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

            var newAlbum = state.newAlbum;

            return SizedBox(
              height: widget.orientation == Orientation.portrait
                  ? height < 650
                  ? MediaQuery.of(context).size.height * 0.6
                  : MediaQuery.of(context).size.height * 0.55
                  : MediaQuery.of(context).size.height / 5,
              child: widget.orientation == Orientation.portrait
                  ? AnimatedGridView(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  crossAxisSpacing: 50,
                  cacheExtent: 1000,
                  children: List.generate(
                      newAlbum.data!.length,
                          (index) {
                        return GestureDetector(
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
                                singerName: newAlbum.data![index].singer!.name!,
                                album: null,
                                albumId: state.singerAllAlbum[index].id,
                                categories: null
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => CurrentSelectedSongBloc()..add(SelectSongEvent(
                                          songModel: songDataModel
                                      )),
                                      child: PlaySongPage(
                                        songName: state.singerAllAlbum[index].name!,
                                        songFile: newPath,
                                        songID: songDataModel.id!,
                                        singerName: songDataModel.singerName!,
                                        songImage: state.singerAllAlbum[index].imageSource!,
                                        albumID: songDataModel.albumId!,
                                        pageName: "SingerPage",
                                        albumSongList: state.singerAllAlbum[index].musics!,
                                        orientation: widget.orientation,
                                      ),

                                    )));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: CachedNetworkImage(
                                    imageUrl: newAlbum.data![index].imageSource!,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                              Colors.purple.withOpacity(0.5),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(newAlbum
                                                  .data![index].imageSource!),
                                              fit: BoxFit.fill)),
                                      width: double.infinity,
                                    ),
                                    placeholder: (context, url) => NewSongShimmerContainer(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )),
                              Expanded(
                                flex: 2,
                                child: UnderImageSingerAndSongName(
                                    singerName: newAlbum.data![index].singer?.name,
                                    albumName: newAlbum.data![index].name,
                                    isArtist: true),
                              ),
                            ],
                          ),
                        );
                      }
                  )
              )
                  : AnimatedGridView(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  mainAxisExtent: 220,
                  crossAxisSpacing: 50,
                  cacheExtent: 1000,
                  children: List.generate(
                      newAlbum.data!.length,
                          (index) {
                        return GestureDetector(
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
                                singerName: newAlbum.data![index].singer!.name!,
                                album: null,
                                albumId: state.singerAllAlbum[index].id,
                                categories: null
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => CurrentSelectedSongBloc()..add(SelectSongEvent(
                                          songModel: songDataModel
                                      )),
                                      child: PlaySongPage(
                                        songName: state.singerAllAlbum[index].name!,
                                        songFile: newPath,
                                        songID: songDataModel.id!,
                                        singerName: songDataModel.singerName!,
                                        songImage: state.singerAllAlbum[index].imageSource!,
                                        albumID: songDataModel.albumId!,
                                        pageName: "SingerPage",
                                        albumSongList: state.singerAllAlbum[index].musics!,
                                        orientation: widget.orientation,
                                      ),

                                    )));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: CachedNetworkImage(
                                    imageUrl: newAlbum.data![index].imageSource!,
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                              Colors.purple.withOpacity(0.5),
                                              blurRadius: 10.0,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(newAlbum
                                                  .data![index].imageSource!),
                                              fit: BoxFit.fill)),
                                      width: double.infinity,
                                    ),
                                    placeholder: (context, url) => NewSongShimmerContainer(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )),
                              Expanded(
                                flex: 2,
                                child: UnderImageSingerAndSongName(
                                    singerName: newAlbum.data![index].singer?.name,
                                    albumName: newAlbum.data![index].name,
                                    isArtist: true),
                              ),
                            ],
                          ),
                        );
                      }
                  )
              ),
            );
          })
        ),
      ],
    );
  }
}
