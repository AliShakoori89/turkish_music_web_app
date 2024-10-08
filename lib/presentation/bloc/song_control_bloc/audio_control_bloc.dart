import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import 'package:turkish_music_app/domain/repositories/recently_play_song_repository.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import '../../../domain/repositories/new_song_repository.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';

enum SongControlStatus { play, pause }

class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {

  List<AlbumDataMusicModel>? _currentAlbum;
  String? _singerName;

  double currentSongIndex = 0;

  RecentlyPlaySongRepository recentlyPlaySongRepository = RecentlyPlaySongRepository();

  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  StreamSubscription? _audioStream;

  final _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioControlBloc() : super(AudioControlInitial()) {

    _audioStream = _audioPlayer.onPlayerComplete.listen((_) async{
      add(SongCompletedEvent());
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
      await _audioPlayer.pause();
    });

    on<RepeatSongEvent>((event, emit) async {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    });

    on<ResumeSongEvent>((event, emit) async {
      await _audioPlayer.resume();
    });

    on<StopRepeatingEvent>((event, emit) async {
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
    });

    on<initialSongEvent>((event, emit) async {
      emit(AudioControlInitial());
    });

    on<SongCompletedEvent>((event, emit) async {

      await _playNextSong(emit);
      await _saveCurrentSongData(_currentSelectedSong!);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayNextSongEvent>((event, emit) async {
      _currentAlbum = event.currentAlbum;
      _singerName =  event.singerName;
      await _saveCurrentSongData(_currentSelectedSong!);
      await _playNextSong(emit);

      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayNextLocalSongEvent>((event, emit) async {
      await _playNextSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayPreviousSongEvent>((event, emit) async {
      _currentAlbum = event.currentAlbum;
      _singerName =  event.singerName;
      await _saveCurrentSongData(_currentSelectedSong!);
      await _playPreviousSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<PlayPreviousLocalSongEvent>((event, emit) async {
      await _playPreviousSong(emit);
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

    on<AudioPlayDisposeEvent>((event, emit) async {
      await _audioPlayer.dispose();
      emit(AudioPlayedState(songModel: _currentSelectedSong!));
    });

  }

  Future<void> _saveCurrentSongData(SongDataModel songDataModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('songID', songDataModel.id!);
    await prefs.setInt('albumID', songDataModel.albumId!);
  }

  Future<void> _playNextSong(Emitter<AudioControlState> emit) async {
    if (_currentAlbum != null && _currentSelectedSong != null) {
      late int? currentIndex = _getCurrentSongIndex(_currentAlbum!, _currentSelectedSong!);
      if(currentIndex! < _currentAlbum!.length-1){
        final nextSong = _currentAlbum![currentIndex+1];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);

        SaveSongModel saveSongModel = SaveSongModel(
          id: _currentSelectedSong!.id,
          singerName: _singerName,
          audioFileAlbumId: _currentSelectedSong!.albumId,
          audioFileMin: _currentSelectedSong!.minute,
          audioFilePath: _currentSelectedSong!.fileSource,
          audioFileSec: _currentSelectedSong!.second,
          imageFilePath: _currentSelectedSong!.imageSource,
          songName: _currentSelectedSong!.name
        );
        await recentlyPlaySongRepository.saveRecentlyPlayedSong(saveSongModel);
        await _playCurrentSong(emit);
      }else{
        currentIndex = 0;
        final nextSong = _currentAlbum![currentIndex];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);
        SaveSongModel saveSongModel = SaveSongModel(
            id: _currentSelectedSong!.id,
            singerName: _singerName,
            audioFileAlbumId: _currentSelectedSong!.albumId,
            audioFileMin: _currentSelectedSong!.minute,
            audioFilePath: _currentSelectedSong!.fileSource,
            audioFileSec: _currentSelectedSong!.second,
            imageFilePath: _currentSelectedSong!.imageSource,
            songName: _currentSelectedSong!.name
        );
        await recentlyPlaySongRepository.saveRecentlyPlayedSong(saveSongModel);
        await _playCurrentSong(emit);
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
        SaveSongModel saveSongModel = SaveSongModel(
            id: _currentSelectedSong!.id,
            singerName: _singerName,
            audioFileAlbumId: _currentSelectedSong!.albumId,
            audioFileMin: _currentSelectedSong!.minute,
            audioFilePath: _currentSelectedSong!.fileSource,
            audioFileSec: _currentSelectedSong!.second,
            imageFilePath: _currentSelectedSong!.imageSource,
            songName: _currentSelectedSong!.name
        );
        await recentlyPlaySongRepository.saveRecentlyPlayedSong(saveSongModel);
        await _playCurrentSong(emit);
      }else{
        currentIndex = _currentAlbum!.length-1;
        final nextSong = _currentAlbum![currentIndex];
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);
        SaveSongModel saveSongModel = SaveSongModel(
            id: _currentSelectedSong!.id,
            singerName: _singerName,
            audioFileAlbumId: _currentSelectedSong!.albumId,
            audioFileMin: _currentSelectedSong!.minute,
            audioFilePath: _currentSelectedSong!.fileSource,
            audioFileSec: _currentSelectedSong!.second,
            imageFilePath: _currentSelectedSong!.imageSource,
            songName: _currentSelectedSong!.name
        );
        await recentlyPlaySongRepository.saveRecentlyPlayedSong(saveSongModel);
        await _playCurrentSong(emit);
      }
      // }
    }
  }

  Future<void> _playCurrentSong(Emitter<AudioControlState> emit) async {
    if (_currentSelectedSong != null) {
      final String modifiedUrl = _currentSelectedSong!.fileSource!.replaceAll("%20", " ");
      final Source source = UrlSource(modifiedUrl ?? "");
      SaveSongModel saveSongModel = SaveSongModel(
          id: _currentSelectedSong!.id,
          singerName: _currentSelectedSong!.singerName,
          audioFileAlbumId: _currentSelectedSong!.albumId,
          audioFileMin: _currentSelectedSong!.minute,
          audioFilePath: _currentSelectedSong!.fileSource,
          audioFileSec: _currentSelectedSong!.second,
          imageFilePath: _currentSelectedSong!.imageSource,
          songName: _currentSelectedSong!.name
      );
      await recentlyPlaySongRepository.saveRecentlyPlayedSong(saveSongModel);
      await _audioPlayer.play(source);
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
    // return songs.indexWhere((s) => s.id == song.id);
  }

  stopAudio() async {
    await _audioPlayer.stop();
  }

  seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> close() async {
    if (_audioStream != null) {
      await _audioStream!.cancel(); // Use await to ensure it finishes
      _audioStream = null; // Optionally set to null for safety
    }
    await _audioPlayer.dispose(); // Use await for proper disposal
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
