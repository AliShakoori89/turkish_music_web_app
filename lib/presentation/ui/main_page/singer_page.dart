import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaky_animated_listview/widgets/animated_gridview.dart';
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
            image: DecorationImage(
                image: NetworkImage(
                    widget.artistDetail.imageSource
                ),
                fit: BoxFit.fitHeight,
              opacity: 0.3
            )
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
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
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
                      left: MediaQuery.of(context).size.width * 0.09,
                      right: MediaQuery.of(context).size.width * 0.09
                    ),
                    child: AnimatedGridView(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                        crossAxisSpacing: 1,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      // itemCount: singerAllAlbum.length,
                        // itemExtent: 120.0,
                        children: List.generate(
                            singerAllAlbum.length,
                                (index) => GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayMusicPage(
                                      imagePath: singerAllAlbum[index].imageSource!,
                                      musicFiles: singerAllAlbum[index].musics,
                                      singerName: singerAllAlbum[index].name!,
                                    ))
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 8,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple.withOpacity(0.5),
                                            blurRadius: 10,
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
                                )
                        )
                    ),
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
