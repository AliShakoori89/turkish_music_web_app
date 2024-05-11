import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_song_page/play_song_page.dart';
import '../../../data/model/singer_model.dart';
import '../../../data/model/song_model.dart';
import '../../bloc/current_selected_song/bloc/current_selected_song_bloc.dart';

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
    return Scaffold(
      body: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

      var singerAllAlbum = state.singerAllAlbum;

      return Container(
        child: CustomScrollView(
          cacheExtent: 2000,
          slivers: [
            SliverAppBar(
              title: Text(widget.artistDetail.name),
              backgroundColor: Colors.black,
              expandedHeight: 250,
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
                background: Image.network(
                  widget.artistDetail.imageSource,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,),
              delegate: SliverChildBuilderDelegate((context, index) =>
                  GestureDetector(
                    onTap: (){
        
                      var path = state.singerAllAlbum[index].musics![index].fileSource!.substring(0, 4)
                          + "s"
                          + state.singerAllAlbum[index].musics![index].fileSource!.substring(4, state.singerAllAlbum[index].musics![index].fileSource?.length);
        
                      var newPath = path.replaceAll(" ", "%20");
        
        
                      SongDataModel songDataModel = SongDataModel(
                          id : state.singerAllAlbum[index].musics![index].id,
                          name: state.singerAllAlbum[index].musics![index].name,
                          imageSource: state.singerAllAlbum[index].musics![index].imageSource,
                          fileSource: newPath,
                          minute: state.singerAllAlbum[index].musics![index].minute,
                          second: state.singerAllAlbum[index].musics![index].second,
                          album: null,
                          albumId: null,
                          categories: null
                      );
        
        
        
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => CurrentSelectedSongBloc()..add(SelectSong(
                                    songModel: songDataModel
                                )),
                                child: PlayMusicPage(
                                    songName: state.singerAllAlbum[index].musics![index].name!,
                                    songFile: newPath
                                ),
        
                              )));
                    },
                    child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.02,
                          top: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Column(
                          children: [
                            Flexible(
                              flex: 5,
                              child: Container(
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
                                      image: NetworkImage(singerAllAlbum[index].imageSource.toString()),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Flexible(
                                flex: 1,
                                child: Text(singerAllAlbum[index].name!))
                          ],
                        )),
                  ),
                  childCount: singerAllAlbum.length
              ),
        
            )
          ],
        ),
      );
      })
    );
  }
}
