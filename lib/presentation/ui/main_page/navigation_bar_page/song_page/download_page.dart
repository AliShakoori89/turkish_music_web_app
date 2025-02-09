import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DownloadPage extends StatefulWidget {
  static String routeName = "DownloadPage";

  const DownloadPage({Key? key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<FileSystemEntity>? audioFiles;
  late AudioPlayer player;

  bool _isPlaying = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _requestPermissionAndFetchFiles();
    _initListeners();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void _initListeners() {
    player.durationStream.listen((duration) {
    });

    player.positionStream.listen((position) {
    });

    player.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
        _isPaused = state.processingState == ProcessingState.ready && !state.playing;
      });
    });
  }

  Future<void> _play(String filePath) async {
    try {
      await player.setFilePath(filePath);
      await player.play();
    } catch (e) {
      print("Error playing file: $e");
    }
  }

  Future<void> _pause() async {
    await player.pause();
  }

  Future<void> _stop() async {
    await player.stop();
  }

  Future<void> _requestPermissionAndFetchFiles() async {
    _fetchAudioFiles();
  }

  Future<void> _fetchAudioFiles() async {
    Directory musicDirectory = Directory("/storage/emulated/0/Music");
    List<FileSystemEntity> files = musicDirectory
        .listSync()
        .where((file) => file is File &&
        (file.path.endsWith(".mp3") || file.path.endsWith(".wav") || file.path.endsWith(".flac")))
        .toList();

    setState(() {
      audioFiles = files;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Download Songs"),
        centerTitle: true,
      ),
      body: audioFiles == null
          ? Center(child: CircularProgressIndicator())
          : audioFiles!.isEmpty
          ? Center(child: Text("No audio files found in the Music folder"))
          : Stack(
        children: [
          ListView.builder(
              itemCount: audioFiles!.length,
              itemBuilder: (context, index) {
                File file = audioFiles![index] as File;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.5),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(),
                  child: ListTile(
                    leading: Icon(Icons.audiotrack),
                    title: Text(file.path.split('/').last),
                    onTap: () => _play(file.path),
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.purple.withOpacity(0.4),
              width: size.width,
              height: size.height / 14,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    key: const Key('play_button'),
                    onPressed: _isPlaying ? null : () => player.play(),
                    iconSize: MediaQuery.of(context).size.height / 30,
                    icon: const Icon(Icons.play_arrow),
                    color: Colors.white,
                  ),
                  IconButton(
                    key: const Key('pause_button'),
                    onPressed: _isPlaying ? _pause : null,
                    iconSize: MediaQuery.of(context).size.height / 30,
                    icon: const Icon(Icons.pause),
                    color: Colors.white,
                  ),
                  IconButton(
                    key: const Key('stop_button'),
                    onPressed: _isPlaying || _isPaused ? _stop : null,
                    iconSize: MediaQuery.of(context).size.height / 30,
                    icon: const Icon(Icons.stop),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
