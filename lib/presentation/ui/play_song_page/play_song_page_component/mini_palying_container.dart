import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
import 'package:turkish_music_app/presentation/bloc/play_button_state_bloc/bloc.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/play_button.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page.dart';
import '../../../../data/model/song_model.dart';
import '../../../bloc/mini_playing_container_bloc/bloc.dart';
import '../../../bloc/mini_playing_container_bloc/event.dart';
import '../../../bloc/play_button_state_bloc/event.dart';
import '../../../const/generate_new_path.dart';
import '../../../helpers/widgets/singer_name_trackName_image.dart';
import '../../../helpers/widgets/top_arrow_icon.dart';

class MiniPlayingContainer extends StatefulWidget {

  MiniPlayingContainer({super.key,
  required this.visibility, required this.song, required this.album, required this.pageName});

  final bool visibility;
  final AlbumDataMusicModel song;
  final List<AlbumDataMusicModel> album ;
  final String pageName ;

  @override
  State<MiniPlayingContainer> createState() => _MiniPlayingContainerState();
}

class _MiniPlayingContainerState extends State<MiniPlayingContainer> {

  @override
  void initState() {
    BlocProvider.of<MiniPlayingContainerBloc>(context).add(CheckPlayingSongEvent());
    BlocProvider.of<PlayButtonStateBloc>(context).add(GetPlayButtonStateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return widget.visibility == true
        ? Container(
        width: double.infinity,
        height: (size.width / size.height) < 1.5
            ? size.height / 12
            : size.height / 7,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Colors.purple, ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: const TopArrow()),
            Expanded(
              flex: 15,
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {

                          // var path = generateNewPath(widget.song.fileSource!);

                          var newPath = widget.song.fileSource!.replaceAll(" ", "%20");

                          print("CCCCCCCCCCCC            "+widget.song.name!);

                          SongDataModel songDataModel = SongDataModel(
                            id : widget.song.id,
                            name: widget.song.name,
                            imageSource: widget.song.imageSource,
                            fileSource: newPath,
                            minute: widget.song.minute,
                            second: widget.song.second,
                            singerName: widget.song.singerName,
                            album: null,
                            albumId: widget.song.albumId,
                            categories: null,
                          );

                          context.push(
                            '/'+PlaySongPage.routeName,
                            extra: {
                              'songName': songDataModel.name,
                              'songFile': newPath,
                              'songID': songDataModel.id!,
                              'singerName': songDataModel.singerName,
                              'songImage': songDataModel.imageSource!,
                              'albumID': songDataModel.albumId!,
                              'pageName': widget.pageName,
                              'albumSongList': widget.album,
                              'songDataModel': songDataModel,
                              'categoryID': 0
                            },
                          );

                        },
                        child: SingerNameTrackNameImage(
                          songName: widget.song.name ?? "",
                          singerName: widget.song.singerName ?? "",
                          imagePath: widget.song.imageSource ?? "",
                          align: MainAxisAlignment.start,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PlayButton(),
                    ),
                  ],
                ),
              ),
            )
          ],
        )

    )
        : Container(width: double.infinity,
      height: (size.width / size.height) < 1.5
          ? size.height / 12
          : size.height / 7,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.black, Colors.purple, ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(15),
      ),);
  }
}
