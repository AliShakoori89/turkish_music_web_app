import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_audio/simple_audio.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/music_progress_bar.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/normalize_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_back_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/play_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/stop_button.dart';
import 'package:turkish_music_app/presentation/helpers/music_player_component/volume_button.dart';
import 'package:turkish_music_app/presentation/helpers/my_music_page_card.dart';
import 'dart:io';
import 'dart:math';

import 'package:turkish_music_app/presentation/helpers/singer_name_trackName_image.dart';
import 'package:turkish_music_app/presentation/helpers/top_arrow_icon.dart';

class MusicPage extends StatelessWidget {
  MusicPage({super.key});

  List customIcon = [
    Icons.playlist_play_outlined,
    Icons.mic_none_rounded,
    Icons.album,
    Icons.favorite,
    Icons.download,
    Icons.podcasts
  ];
  List title = [
    "Playlists",
    "Artists",
    "Albums",
    "Favorites",
    "Downloads",
    "Podcasts"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              right: MediaQuery.of(context).size.width * 0.033,
              left: MediaQuery.of(context).size.width * 0.033,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1
                    ),
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return MyMusicPageCard(
                          customIcon: customIcon[index],
                          title: title[index],
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Column(
                      children: [

                        const TopArrow(),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.10 + 15,
                            right: MediaQuery.of(context).size.width * 0.10 + 15,
                            // top: MediaQuery.of(context).size.height * 0.03,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              const SingerNameTrackNameImage(
                                  songName: "Tarkan",
                                  singerName: "MoOooooOoch",
                                  imagePath: "assets/images/tarkan.png",
                                  align: MainAxisAlignment.start),
                              PlayButton()
                              // const MusicProgressBar(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     const SizedBox(
                              //       width: 1,
                              //     ),
                              //     const PlayBackButton(),
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         // Stop button.
                              //         StopButton(),
                              //         const SizedBox(width: 10),
                              //
                              //         // Play/pause button.
                              //         PlayButton(),
                              //         const SizedBox(width: 10),
                              //
                              //         // Toggle mute button.
                              //         const VolumeButton()
                              //       ],
                              //     ),
                              //     NormalizeButton(),
                              //     const SizedBox(
                              //       width: 1,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // if (Platform.isAndroid || Platform.isIOS) ...{
        //     //   Builder(
        //     //     builder: (context) => ElevatedButton(
        //     //       child: const Text("Get Storage Perms"),
        //     //       onPressed: () async {
        //     //         PermissionStatus status =
        //     //         await Permission.storage.request();
        //     //
        //     //         if (!mounted) return;
        //     //         ScaffoldMessenger.of(context).showSnackBar(
        //     //           SnackBar(
        //     //             content: Text("Storage Permissions: ${status.name}"),
        //     //           ),
        //     //         );
        //     //       },
        //     //     ),
        //     //   ),
        //     // },
        //     // const SizedBox(height: 5),
        //     // ElevatedButton(
        //     //   child: const Text("Open File"),
        //     //   onPressed: () async {
        //     //     String path = await pickFile();
        //     //
        //     //     await player.setMetadata(
        //     //       const Metadata(
        //     //         title: "Title",
        //     //         artist: "Artist",
        //     //         album: "Album",
        //     //         artUri: "https://picsum.photos/200",
        //     //       ),
        //     //     );
        //     //     await player.stop();
        //     //     await player.open(path);
        //     //   },
        //     // ),
        //     // const SizedBox(height: 10),
        //     // Row(
        //     //   mainAxisAlignment: MainAxisAlignment.center,
        //     //   children: [
        //     //     ElevatedButton(
        //     //       child: const Text("Preload File"),
        //     //       onPressed: () async {
        //     //         String path = await pickFile();
        //     //         await player.preload(path);
        //     //       },
        //     //     ),
        //     //     const SizedBox(width: 5),
        //     //     ElevatedButton(
        //     //       child: const Text("Play Preload"),
        //     //       onPressed: () async {
        //     //         if (!await player.hasPreloaded) {
        //     //           debugPrint("No preloaded file to play!");
        //     //           return;
        //     //         }
        //     //
        //     //         debugPrint("Playing preloaded file.");
        //     //         await player.stop();
        //     //         await player.playPreload();
        //     //       },
        //     //     ),
        //     //     const SizedBox(width: 5),
        //     //     ElevatedButton(
        //     //       child: const Text("Clear Preload"),
        //     //       onPressed: () async {
        //     //         if (!await player.hasPreloaded) {
        //     //           debugPrint("No preloaded file to clear!");
        //     //           return;
        //     //         }
        //     //
        //     //         debugPrint("Cleared preloaded file.");
        //     //         await player.clearPreload();
        //     //       },
        //     //     ),
        //     //   ],
        //     // ),
        //     const SizedBox(height: 30),
        //
        //     // Toggle volume normalization
        //     // Row(
        //     //   mainAxisAlignment: MainAxisAlignment.center,
        //     //   children: [
        //     //     Checkbox(
        //     //       value: normalize,
        //     //       onChanged: (value) {
        //     //         setState(() => normalize = value!);
        //     //         player.normalizeVolume(normalize);
        //     //       },
        //     //     ),
        //     //     const Text("Normalize Volume"),
        //     //   ],
        //     // ),
        //
        //     // Progress bar with time.
        //
        //   ],
        // ),
        );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.onPressed,
    required this.child,
    this.size = 35,
    this.color = Colors.blue,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            canRequestFocus: false,
            onTap: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}