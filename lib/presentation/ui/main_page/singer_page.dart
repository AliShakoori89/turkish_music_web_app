import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import '../../../data/model/singer_model.dart';

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

      return CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.artistDetail.name),
            backgroundColor: Colors.purple,
            expandedHeight: 250,
            stretch: true,
            stretchTriggerOffset: 40,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
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
                  // onTap: (){
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => PlayMusicPage(
                  //             imagePath: singerAllAlbum[index].imageSource!,
                  //             musicFiles: singerAllAlbum[index].musics!,
                  //             singerName: singerAllAlbum[index].name!,
                  //             musicFile: singerAllAlbum[index].,
                  //           ))
                  //   );
                  // },
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
      );
      })
    );
  }
}
