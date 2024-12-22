import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class DownloadPage extends StatefulWidget {

  static String routeName = "DownloadPage";

  const DownloadPage({Key? key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<FileSystemEntity>? audioFiles;
  late AudioPlayer player = AudioPlayer();

  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  // AudioPlayer get player => player;

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermissionAndFetchFiles();

    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
        _duration = value;
      }),
    );
    player.getCurrentPosition().then(
          (value) => setState(() {
        _position = value;
      }),
    );
    _initStreams();
  }

  @override
  void dispose() {
    player.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
          (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
          setState(() {
            _playerState = state;
          });
        });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  Future<void> _requestPermissionAndFetchFiles() async {
    _fetchAudioFiles();
  }

  // Fetch audio files from the Music directory
  Future<void> _fetchAudioFiles() async {

    Directory musicDirectory = Directory("/storage/emulated/0/Music");

    // Filter files by audio extensions
    List<FileSystemEntity> files = musicDirectory
        .listSync()
        .where((file) =>
    file is File &&
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
                          color:
                          Colors.purple.withOpacity(0.5),
                          blurRadius: 10.0,
                        ),
                      ]
                  ),
                  margin: EdgeInsets.only(
                  ),
                  child: ListTile(
                    selectedColor: Colors.purple,
                    leading: Icon(Icons.audiotrack),
                    title: Text(file.path.split('/').last),
                    onTap: () async{

                      String uriPath = Uri.file(file.path).toString();

                      // Set the release mode to keep the source after playback has completed.
                      player.setReleaseMode(ReleaseMode.stop);

                      // Start the player as soon as the app is displayed.
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await player.play(UrlSource(uriPath));
                        await player.resume();
                      });
                    },
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
                    onPressed: _isPlaying ? null : _play,
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