import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turkish_music_app/data/model/save_song_model.dart';
import 'package:turkish_music_app/domain/repositories/recently_play_song_repository.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import 'package:just_audio/just_audio.dart';

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

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  StreamSubscription? _audioStream;

  final _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioControlBloc() : super(AudioControlInitial()) {

    _audioStream = _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
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
      await _audioPlayer.pause();
    });

    on<RepeatSongEvent>((event, emit) async {
      await _audioPlayer.setLoopMode(LoopMode.one);
    });

    on<ResumeSongEvent>((event, emit) async {
      await _audioPlayer.play();
    });

    on<StopRepeatingEvent>((event, emit) async {
      await _audioPlayer.setLoopMode(LoopMode.off);
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
      _singerName =  event.singerName;
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
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();
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
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();
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
        await saveCurrentSongData(_currentSelectedSong!);
        await readCurrentSongData();
      }
      // }
    }
  }

  Future<void> _playCurrentSong(Emitter<AudioControlState> emit) async {
    if (_currentSelectedSong != null) {
      final String modifiedUrl = _currentSelectedSong!.fileSource!.replaceAll("%20", " ");

      SaveSongModel saveSongModel = SaveSongModel(
        id: _currentSelectedSong!.id,
        singerName: _currentSelectedSong!.singerName,
        audioFileAlbumId: _currentSelectedSong!.albumId,
        audioFileMin: _currentSelectedSong!.minute,
        audioFilePath: _currentSelectedSong!.fileSource,
        audioFileSec: _currentSelectedSong!.second,
        imageFilePath: _currentSelectedSong!.imageSource,
        songName: _currentSelectedSong!.name,
      );

      await recentlyPlaySongRepository.saveRecentlyPlayedSong(saveSongModel);

      try {
        await _audioPlayer.setUrl(modifiedUrl);
        await _audioPlayer.play();
      } catch (e) {
        print("Error playing audio: $e");
      }
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