import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';
import 'package:turkish_music_app/presentation/ui/main_page/play_music_page.dart';

import '../../../data/model/music_model.dart';
import '../../../data/model/singer_model.dart';
import '../../helpers/widgets/custom_app_bar.dart';

class SingerPage extends StatefulWidget {
  const SingerPage({super.key, required this.artistDetail});

  final SingerDataModel artistDetail;

  @override
  State<SingerPage> createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {

  @override
  void initState() {
    BlocProvider.of<AlbumBloc>(context).add(GetSingerAllAlbumEvent(id: widget.artistDetail.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.purple.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.009),
              Expanded(
                flex: 2,
                child: CustomAppBar(
                  title: "Singer Page",
                  singerName: widget.artistDetail.name,
                  haveMenuButton: false,
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            widget.artistDetail.imageSource
                        ),
                        fit: BoxFit.fill
                      )
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Expanded(
                flex: 12,
                child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

                  var singerAllAlbum = state.singerAllAlbum;

                  return Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.01
                    ),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: singerAllAlbum.length,
                        itemExtent: 120.0,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayMusicPage(
                                      imagePath: singerAllAlbum[index].imageSource.toString(),
                                      musicFile: singerAllAlbum[index].musics![0].fileSource.toString(),
                                      singerName: ,
                                    ))
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.02
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height: MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      image: DecorationImage(
                                        image: NetworkImage(singerAllAlbum[index].imageSource.toString()),
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(singerAllAlbum[index].name!)
                              ],
                            )),
                        );
                      }),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
