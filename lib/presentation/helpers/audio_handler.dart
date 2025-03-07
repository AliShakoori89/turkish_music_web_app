import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/model/album_model.dart';
import '../../data/model/miniplayer_model.dart';
import '../../data/model/song_model.dart';
import '../../domain/repositories/mini_playing_container_repository.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {

  SongDataModel? _currentSelectedSong;

  final _player = AudioPlayer(
    handleAudioSessionActivation: true, // Helps with media session handling
  );

  List<MediaItem> _queue = [];  // Keep track of the queue (list of songs)
  int _currentIndex = 0;         // Track the current song index

  MyAudioHandler() {
    _player.playerStateStream.listen((state) {
      print("Player state changed: $state");
      playbackState.add(
        PlaybackState(
          controls: [
            MediaControl.play,
            MediaControl.pause,
            MediaControl.stop,
            MediaControl.skipToPrevious,
            MediaControl.skipToNext,
          ],
          systemActions: const {
            MediaAction.seek,
            MediaAction.seekForward,
            MediaAction.seekBackward,
          },
          playing: state.playing,
          processingState: _convertProcessingState(state.processingState),
        ),
      );
    });

    _player.positionStream.listen((position) {
      final currentState = playbackState.value;
      playbackState.add(
        currentState.copyWith(
          updatePosition: position,
          bufferedPosition: _player.bufferedPosition,
        ),
      );
    });

  }


  @override
  Future<dynamic> customAction(String name, [Map<String, dynamic>? extras]) async {
    if (name == 'setUrl' && extras?['url'] != null) {
      final String url = extras!['url'];
      print("🎵 Setting new URL: $url");

      try {
        await _player.setUrl(url);
      } catch (e) {
        print("🚨 Error setting URL in AudioHandler: $e");
      }
    }
  }


  @override
  Future<void> skipToPrevious() async {
    print("⏮ Skipping to previous song");

    if (_queue.isEmpty) return;

    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = _queue.length - 1;
    }

    mediaItem.add(_queue[_currentIndex]);

    await _player.setUrl(_queue[_currentIndex].extras!['url']);

    List<AlbumDataMusicModel> albumSongs = _queue.map((mediaItem){
      return AlbumDataMusicModel(
        id: int.parse(mediaItem.id),
        name: mediaItem.title,
        singerName: mediaItem.artist,
        imageSource: mediaItem.artUri.toString(),
        minute: mediaItem.duration!.inMinutes.toString(),
        second: (mediaItem.duration!.inSeconds % 60).toString(),
      );
    }).toList();

    MiniPlayerModel song = MiniPlayerModel(
        songID: int.parse(_queue[_currentIndex].id),
        songName:  _queue[_currentIndex].title,
        songsSingerName: _queue[_currentIndex].artist,
        songImagePath: _queue[_currentIndex].artUri.toString(),
        songFilePath: _queue[_currentIndex].extras!['url'],
        minute: _queue[_currentIndex].duration!.inMinutes.toString(),
        second: _queue[_currentIndex].duration!.inSeconds.toString(),
        categoryID: 0,
        albumID: _queue[_currentIndex].extras!['albumID'],
        songList: albumSongs);

    MiniPlayerRepo().saveToMiniPlayer(song);

    await play();
  }

  @override
  Future<void> skipToNext() async {
    print("⏭ Skipping to next song");

    if (_queue.isEmpty) return;

    if (_currentIndex < _queue.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }

    mediaItem.add(_queue[_currentIndex]);

    await _player.setUrl(_queue[_currentIndex].extras!['url']);

    List<AlbumDataMusicModel> albumSongs = _queue.map((mediaItem){
      return AlbumDataMusicModel(
        id: int.parse(mediaItem.id),
        name: mediaItem.title,
        singerName: mediaItem.artist,
        imageSource: mediaItem.artUri.toString(),
        minute: mediaItem.duration!.inMinutes.toString(),
        second: (mediaItem.duration!.inSeconds % 60).toString(),
        album: mediaItem.album,
        albumId: mediaItem.extras!['albumID'],
        fileSource: mediaItem.extras!['url'],
        categories: null
      );
    }).toList();

    MiniPlayerModel song = MiniPlayerModel(
        songID: int.parse(_queue[_currentIndex].id),
        songName:  _queue[_currentIndex].title,
        songsSingerName: _queue[_currentIndex].artist,
        songImagePath: _queue[_currentIndex].artUri.toString(),
        songFilePath: _queue[_currentIndex].extras!['url'],
        minute: _queue[_currentIndex].duration!.inMinutes.toString(),
        second: _queue[_currentIndex].duration!.inSeconds.toString(),
        categoryID: 0,
        albumID: _queue[_currentIndex].extras!['albumID'],
        songList: albumSongs);

    MiniPlayerRepo().saveToMiniPlayer(song);

    await play();
  }


  @override
  Future<void> play() async {
    print("Play method called");
    await _player.play();
  }

  @override
  Future<void> pause() async {
    print("Pause method called");
    await _player.pause();
  }

  @override
  Future<void> stop() async {
    print("Stop method called");
    await _player.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    print("Seek method called with position: $position");
    await _player.seek(position);
  }

  Future<void> setQueue(List<MediaItem> songs, int currentIndex) async {
    _queue.clear();
    _queue.addAll(songs);
    _currentIndex = currentIndex;

    if (_queue.isNotEmpty) {
      mediaItem.add(_queue[_currentIndex]);
    }
    updateQueue(_queue);
  }

  AudioProcessingState _convertProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return AudioProcessingState.loading;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      }
  }

}
