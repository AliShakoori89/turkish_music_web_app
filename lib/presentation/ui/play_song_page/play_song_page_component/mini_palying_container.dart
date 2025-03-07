import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turkish_music_app/domain/repositories/mini_playing_container_repository.dart';
import 'package:turkish_music_app/presentation/ui/play_song_page/play_song_page_component/play_button.dart';
import '../../../../data/model/song_model.dart';
import '../../../helpers/widgets/singer_name_trackName_image.dart';
import '../../../helpers/widgets/top_arrow_icon.dart';
import '../play_song_page.dart';

class MiniPlayingContainer extends StatefulWidget {
  const MiniPlayingContainer({super.key});

  @override
  State<MiniPlayingContainer> createState() => _MiniPlayingContainerState();
}

class _MiniPlayingContainerState extends State<MiniPlayingContainer> {

  final MiniPlayerRepo currentSong = MiniPlayerRepo();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: currentSong.getMiniPlayerStream(),
        builder: ((context, snapshot) =>
            Container(
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

                                  print(currentSong.song!.songID);
                                  print(currentSong.song!.songName);
                                  print(currentSong.song!.songImagePath);
                                  print(currentSong.song!.songFilePath);
                                  print(currentSong.song!.minute);
                                  print(currentSong.song!.second);
                                  print(currentSong.song!.songsSingerName);
                                  print(currentSong.song!.albumID);

                                  SongDataModel songDataModel = SongDataModel(
                                    id : currentSong.song!.songID,
                                    name: currentSong.song!.songName,
                                    imageSource: currentSong.song!.songImagePath,
                                    fileSource: currentSong.song!.songFilePath,
                                    minute: currentSong.song!.minute,
                                    second: currentSong.song!.second,
                                    singerName: currentSong.song!.songsSingerName,
                                    album: null,
                                    albumId: currentSong.song!.albumID,
                                    categories: null,
                                  );

                                  context.push(
                                    '/'+PlaySongPage.routeName,
                                    extra: {
                                      'songName': songDataModel.name,
                                      'songFile': songDataModel.fileSource,
                                      'songID': songDataModel.id!,
                                      'singerName': songDataModel.singerName,
                                      'songImage': songDataModel.imageSource!,
                                      'albumID': songDataModel.albumId!,
                                      'pageName': '',
                                      'albumSongList': currentSong.song!.songList,
                                      'songDataModel': songDataModel,
                                      'categoryID': currentSong.song!.categoryID
                                    },
                                  );

                                },
                                child: SingerNameTrackNameImage(
                                  songName: currentSong.song!.songName ?? "",
                                  singerName: currentSong.song!.songsSingerName ?? "",
                                  imagePath: currentSong.song!.songImagePath ?? "",
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

            )));
  }
}
