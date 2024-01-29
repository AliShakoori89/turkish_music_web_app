import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_audio/simple_audio.dart';
import 'dart:io';
import 'dart:math';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {

  final SimpleAudio player = SimpleAudio(
    onSkipNext: (_) => debugPrint("Next"),
    onSkipPrevious: (_) => debugPrint("Prev"),
    onNetworkStreamError: (player, error) {
      debugPrint("Network Stream Error: $error");
      player.stop();
    },
    onDecodeError: (player, error) {
      debugPrint("Decode Error: $error");
      player.stop();
    },
  );

  PlaybackState playbackState = PlaybackState.stop;
  bool get isPlaying =>
      playbackState == PlaybackState.play ||
          playbackState == PlaybackState.preloadPlayed;

  bool get isMuted => volume == 0;
  double trueVolume = 1;
  double volume = 1;
  bool normalize = false;
  bool loop = false;

  double position = 0;
  double duration = 0;

  String convertSecondsToReadableString(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;

    return "$m:${s > 9 ? s : "0$s"}";
  }

  Future<String> pickFile() async {
    FilePickerResult? file = await FilePicker.platform
        .pickFiles(dialogTitle: "Pick file to play.", type: FileType.audio);

    final PlatformFile pickedFile = file!.files.single;
    return pickedFile.path!;
  }

  @override
  void initState() {
    super.initState();

    player.playbackStateStream.listen((event) async {
      setState(() => playbackState = event);
    });

    player.progressStateStream.listen((event) {
      setState(() {
        position = event.position.toDouble();
        duration = event.duration.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Audio Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (Platform.isAndroid || Platform.isIOS) ...{
              Builder(
                builder: (context) => ElevatedButton(
                  child: const Text("Get Storage Perms"),
                  onPressed: () async {
                    PermissionStatus status =
                    await Permission.storage.request();

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Storage Permissions: ${status.name}"),
                      ),
                    );
                  },
                ),
              ),
            },
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text("Open File"),
              onPressed: () async {
                String path = await pickFile();

                await player.setMetadata(
                  const Metadata(
                    title: "Title",
                    artist: "Artist",
                    album: "Album",
                    artUri: "https://picsum.photos/200",
                  ),
                );
                await player.stop();
                await player.open(path);
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Preload File"),
                  onPressed: () async {
                    String path = await pickFile();
                    await player.preload(path);
                  },
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  child: const Text("Play Preload"),
                  onPressed: () async {
                    if (!await player.hasPreloaded) {
                      debugPrint("No preloaded file to play!");
                      return;
                    }

                    debugPrint("Playing preloaded file.");
                    await player.stop();
                    await player.playPreload();
                  },
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  child: const Text("Clear Preload"),
                  onPressed: () async {
                    if (!await player.hasPreloaded) {
                      debugPrint("No preloaded file to clear!");
                      return;
                    }

                    debugPrint("Cleared preloaded file.");
                    await player.clearPreload();
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Toggle volume normalization
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: normalize,
                  onChanged: (value) {
                    setState(() => normalize = value!);
                    player.normalizeVolume(normalize);
                  },
                ),
                const Text("Normalize Volume"),
              ],
            ),

            // Progress bar with time.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(convertSecondsToReadableString(position.floor())),
                  Flexible(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: Slider(
                        value: min(position, duration),
                        max: duration,
                        onChanged: (value) {
                          player.seek(value.floor());
                        },
                      ),
                    ),
                  ),
                  Text(convertSecondsToReadableString(duration.floor())),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 1,),
                Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loop = !loop;
                          player.loopPlayback(loop);
                        });
                      },
                      child: Container(
                        width: 25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: loop ? Colors.white : Colors.white30.withOpacity(0.2)),
                        padding: const EdgeInsets.all(5),
                        child: loop
                            ? const Icon(
                          Icons.repeat,
                          size: 15.0,
                          color: Colors.black,
                        )
                            : const Icon(
                          Icons.repeat,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Stop button.
                    CircleButton(
                      color: Colors.white30.withOpacity(0.2),
                      size: 35,
                      onPressed: playbackState != PlaybackState.done
                          ? player.stop
                          : null,
                      child: const Icon(Icons.stop, color: Colors.white),
                    ),
                    const SizedBox(width: 10),

                    // Play/pause button.
                    CircleButton(
                      color: Colors.white30.withOpacity(0.2),
                      size: 40,
                      onPressed: () {
                        if (isPlaying) {
                          player.pause();
                        } else {
                          player.play();
                        }
                      },
                      child: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Toggle mute button.
                    CircleButton(
                      color: Colors.white30.withOpacity(0.2),
                      size: 35,
                      onPressed: () {
                        if (!isMuted) {
                          player.setVolume(0);
                          setState(() => volume = 0);
                        } else {
                          player.setVolume(trueVolume);
                          setState(() => volume = trueVolume);
                        }
                      },
                      child: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                CircleButton(
                  color: Colors.white30.withOpacity(0.2),
                  size: 25,
                  onPressed: playbackState != PlaybackState.done
                      ? player.stop
                      : null,
                  child: const Icon(Icons.stop, color: Colors.white,
                  size: 15),
                ),
                Center(
                    child: Container(
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: normalize ? Colors.white : Colors.white30.withOpacity(0.2),
                      ),
                      child: Transform.scale(
                          scale: 2,
                          child: IconButton(
                            icon: ImageIcon(
                              normalize
                                  ? AssetImage('assets/custom_icons/normalize.png')
                                  : AssetImage("assets/custom_icons/normalize_off.png")
                              ),
                            onPressed: () {
                              setState(() {
                                normalize = !normalize;
                                player.normalizeVolume(normalize);
                              });
                            },
                          )),
                    )
                ),
                const SizedBox(width: 1,),
              ],
            ),
          ],
        ),
      ),
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