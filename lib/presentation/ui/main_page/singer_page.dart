import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/album_bloc/state.dart';

import '../../../data/model/music_model.dart';
import '../../../data/model/singer_model.dart';
import '../../helpers/widgets/custom_app_bar.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key, required this.artistDetail});

  final SingerDataModel artistDetail;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {

  @override
  void initState() {
    BlocProvider.of<AlbumBloc>(context).add(GetSingerAllAlbumEvent(id: widget.artistDetail.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: CustomAppBar(
                title: "Singer Page",
                singerName: widget.artistDetail.name,
                haveMenuButton: false,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Expanded(
              flex: 3,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(
                      widget.artistDetail.imageSource
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Expanded(
              flex: 8,
              child: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {

                List singerAllAlbum = state.singerAllAlbum;

                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: singerAllAlbum.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        leading: const Icon(Icons.list),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text("List item $index"));
                  });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
