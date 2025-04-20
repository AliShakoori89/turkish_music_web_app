import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/miniplayer_model.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import '../../../domain/repositories/mini_playing_container_repository.dart';
import '../../helpers/audio_handler.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';

enum SongControlStatus { play, pause }

class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {

  List<MediaItem> queue = [];

  List<AlbumDataMusicModel>? _currentAlbum;

  double currentSongIndex = 0;

  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  Stream<Duration> get positionStream => audioHandler.playbackState
      .map((state) => state.position)
      .distinct();

  StreamSubscription? _audioStream;

  final MyAudioHandler audioHandler;

  AudioControlBloc({required this.audioHandler}) : super(AudioControlInitial()) {

    _audioStream = audioHandler.playbackState.listen((playbackState) {
      if (playbackState.processingState == AudioProcessingState.completed) {
        add(SongCompletedEvent());
      }
    });


    on<PlaySongEvent>((event, emit) async {

      _currentSelectedSong = event.currentSong;
      _currentAlbum = event.currentAlbum;
      _playCurrentSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlaySelectedSongEvent>((event, emit) async {
      _currentSelectedSong = event.currentSong;
      _currentAlbum = event.currentAlbum;
      _playCurrentSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PauseSongEvent>((event, emit) async {
      await audioHandler.pause();
    });

    on<RepeatSongEvent>((event, emit) async {
      await audioHandler.setRepeatMode(AudioServiceRepeatMode.one); // حالت تکرار یک آهنگ
    });

    on<ResumeSongEvent>((event, emit) async {
      await audioHandler.play();
    });

    on<StopRepeatingEvent>((event, emit) async {
      await audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
    });


    on<initialSongEvent>((event, emit) async {
      emit(AudioControlInitial());
    });

    on<SongCompletedEvent>((event, emit) async {

      await _playNextSong(emit);
      await saveCurrentSongData(_currentSelectedSong!);
      await readCurrentSongData();
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayNextSongEvent>((event, emit) async {
      _currentAlbum = event.currentAlbum;
      await _playNextSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayNextLocalSongEvent>((event, emit) async {
      await _playNextSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayPreviousSongEvent>((event, emit) async {
      _currentAlbum = event.currentAlbum;
      await _playPreviousSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayPreviousLocalSongEvent>((event, emit) async {
      await _playPreviousSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<AudioPlayDisposeEvent>((event, emit) async {
      await audioHandler.stop();
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

  }

  Future<void> saveCurrentSongData(SongDataModel songDataModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('songID', songDataModel.id!);
    await prefs.setInt('albumID', songDataModel.albumId!);
  }

  FutureOr<List> readCurrentSongData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int songID = prefs.getInt('songID')!;
    final int albumID = prefs.getInt('albumID')!;
    List requirement = [songID, albumID];
    return requirement;
  }

  Future<void> _playNextSong(Emitter<AudioControlState> emit) async {
    if (_currentAlbum != null && _currentSelectedSong != null) {
      late int? currentIndex = _getCurrentSongIndex(_currentAlbum!, _currentSelectedSong!);
      if(currentIndex! < _currentAlbum!.length-1){
        final nextSong = _currentAlbum![currentIndex+1];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);

        MiniPlayerModel song = MiniPlayerModel(
            songID: _currentSelectedSong!.id,
            songName: _currentSelectedSong!.name,
            songsSingerName: _currentSelectedSong!.singerName,
            songImagePath: _currentSelectedSong!.imageSource,
            songFilePath: _currentSelectedSong!.fileSource,
            minute: _currentSelectedSong!.minute,
            second: _currentSelectedSong!.second,
            categoryID: 0,
            albumID: _currentSelectedSong!.albumId,
            songList: _currentAlbum);

        MiniPlayerRepo().saveToMiniPlayer(song);

        await _playCurrentSong(emit);
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();
      }else{
        currentIndex = 0;
        final nextSong = _currentAlbum![currentIndex];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);

        MiniPlayerModel song = MiniPlayerModel(
            songID: _currentSelectedSong!.id,
            songName: _currentSelectedSong!.name,
            songsSingerName: _currentSelectedSong!.singerName,
            songImagePath: _currentSelectedSong!.imageSource,
            songFilePath: _currentSelectedSong!.fileSource,
            minute: _currentSelectedSong!.minute,
            second: _currentSelectedSong!.second,
            categoryID: 0,
            albumID: _currentSelectedSong!.albumId,
            songList: _currentAlbum);

        MiniPlayerRepo().saveToMiniPlayer(song);

        await _playCurrentSong(emit);
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();
      }
      // }
    }
  }

  Future<void> _playPreviousSong(Emitter<AudioControlState> emit) async {
    if (_currentAlbum != null && _currentSelectedSong != null) {
      late int? currentIndex = _getCurrentSongIndex(_currentAlbum!, _currentSelectedSong!);
      if(currentIndex! > 0){
        final nextSong = _currentAlbum![currentIndex-1];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);

        MiniPlayerModel song = MiniPlayerModel(
            songID: _currentSelectedSong!.id,
            songName: _currentSelectedSong!.name,
            songsSingerName: _currentSelectedSong!.singerName,
            songImagePath: _currentSelectedSong!.imageSource,
            songFilePath: _currentSelectedSong!.fileSource,
            minute: _currentSelectedSong!.minute,
            second: _currentSelectedSong!.second,
            categoryID: 0,
            albumID: _currentSelectedSong!.albumId,
            songList: _currentAlbum);

        MiniPlayerRepo().saveToMiniPlayer(song);

        await _playCurrentSong(emit);
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();

      }else{

        currentIndex = _currentAlbum!.length-1;
        final nextSong = _currentAlbum![currentIndex];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);

        MiniPlayerModel song = MiniPlayerModel(
            songID: _currentSelectedSong!.id,
            songName: _currentSelectedSong!.name,
            songsSingerName: _currentSelectedSong!.singerName,
            songImagePath: _currentSelectedSong!.imageSource,
            songFilePath: _currentSelectedSong!.fileSource,
            minute: _currentSelectedSong!.minute,
            second: _currentSelectedSong!.second,
            categoryID: 0,
            albumID: _currentSelectedSong!.albumId,
            songList: _currentAlbum);

        MiniPlayerRepo().saveToMiniPlayer(song);

        await _playCurrentSong(emit);
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();

      }
    }
  }

  Future<void> _playCurrentSong(Emitter<AudioControlState> emit) async {
    if (_currentSelectedSong == null) return;

    List<MediaItem> queue = [];
    int nowCurrentIndex = 0;

    for (int i = 0; i < _currentAlbum!.length; i++) {

      // String songUrl = _currentAlbum![i].fileSource!.replaceAll("]", "").trim();

      final mediaItem = MediaItem(
        id: _currentAlbum![i].id.toString(),
        album: _currentAlbum![i].album,
        title: _currentAlbum![i].name!,
        artist: _currentAlbum![i].singerName,
        artUri: Uri.parse(_currentAlbum![i].imageSource!),
        duration: Duration(minutes: int.parse(_currentAlbum![i].minute!), seconds: int.parse(_currentAlbum![i].second!)),
        extras: {'url': _currentAlbum![i].fileSource!, 'albumID': _currentAlbum![i].albumId},
      );

      queue.add(mediaItem);
    }

    for (int i = 0; i < _currentAlbum!.length; i++) {
      if (_currentAlbum![i].name == _currentSelectedSong!.name) {
        print("Current Index: $i");
        nowCurrentIndex = i;
      }
    }

    try {
      await audioHandler.setQueue(queue , nowCurrentIndex);
      await audioHandler.customAction('setUrl', {'url': _currentSelectedSong!.fileSource!});
      await audioHandler.play();
    } catch (e) {
      print("🚨 Error in _playCurrentSong: $e");
    }
  }



  SongDataModel _mapAlbumDataMusicModelToSongDataModel(AlbumDataMusicModel song) {
    return SongDataModel(
      id: song.id,
      name: song.name,
      imageSource: song.imageSource,
      fileSource: song.fileSource!.replaceFirst('http', 'https'),
      singerName: song.singerName,
      minute: song.minute,
      second: song.second,
      albumId: song.albumId,
    );
  }

  int? _getCurrentSongIndex(List<AlbumDataMusicModel> songs, SongDataModel song) {
    for(int i = 0; i < songs.length; i++){
      if(songs[i].name == song.name){
        return i;
      }
    }
    return songs.indexWhere((s) => s.id == song.id);
  }

  stopAudio() async {
    await audioHandler.stop();
  }

  seekTo(Duration position) async {
    await audioHandler.seek(position);
  }

  @override
  Future<void> close() async {
    if (_audioStream != null) {
      await _audioStream!.cancel(); // Use await to ensure it finishes
      _audioStream = null; // Optionally set to null for safety
    }
    await audioHandler.stop(); // Use await for proper disposal
    return super.close();
  }

  getCurrentSongIndex(List<AlbumDataMusicModel> songs, SongDataModel song) {
    for(int i = 0 ; i < songs.length ; i++){
      if(song.id == songs[i].id){
        return i;
      }
    }
  }
}