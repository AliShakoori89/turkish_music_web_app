import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import '../../../domain/repositories/new_song_repository.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';

enum SongControlStatus { play, pause }

class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {

  List<AlbumDataMusicModel>? _currentAlbum;

  double currentSongIndex = 0;

  NewSongRepository newSongRepository = NewSongRepository();

  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  StreamSubscription? _audioStream;

  final _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioControlBloc() : super(AudioControlInitial()) {

    _audioStream = _audioPlayer.onPlayerComplete.listen((_) async{
      print("*********************************************************************");
      // _audioPlayer.resume();
      add(SongCompletedEvent());
    });

    // on<SongCompleted>((event, emit) async {
    //   int i = getCurrentSongIndex(event.songs);
    //   print("iiiiiiiiiiiiiiiii            "+i.toString());
    //   final Source source = UrlSource(event.songs[i].fileSource ?? "");
    //   await _audioPlayer.play(source);
    // });

    on<PlaySong>((event, emit) async {
      _currentSelectedSong = event.currentSong;
      _currentAlbum = event.currentAlbum;
      _playCurrentSong(emit);
      emit(AudioPlayedState());
    });

    on<PauseSong>((event, emit) async {
      await _audioPlayer.pause();
      emit(AudioPausedState());
    });

    on<RepeatSong>((event, emit) async {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      emit(AudioRepeatState());
    });

    on<ResumeSong>((event, emit) async {
      await _audioPlayer.resume();
      emit(AudioPlayedState());
    });

    on<StopRepeating>((event, emit) async {
      await _audioPlayer.setReleaseMode(ReleaseMode.stop);
      emit(AudioRepeatState());
    });

    on<initialSong>((event, emit) async {
      emit(AudioControlInitial());
    });

    on<SongCompletedEvent>((event, emit) async {
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        await _playNextSong(emit);
    });

    on<PlayNextSong>((event, emit) async {
      _currentAlbum = event.currentAlbum;
      await _playCurrentSong(emit);
      emit(AudioPlayedState());
    });

  }

  Future<void> _playNextSong(Emitter<AudioControlState> emit) async {
    if (_currentAlbum != null && _currentSelectedSong != null) {
      final int? currentIndex = _getCurrentSongIndex(_currentAlbum!, _currentSelectedSong!);
      print("currentIndex                 "+currentIndex.toString());
      if (currentIndex != null) {
        final int nextIndex = (currentIndex + 1) % _currentAlbum!.length;
        print("nextIndex                 "+nextIndex.toString());
        final nextSong = _currentAlbum![nextIndex];
        print("nextSong                 "+nextSong.name.toString());
        _currentSelectedSong = _mapAlbumDataMusicModelToSongDataModel(nextSong);
        await _playCurrentSong(emit);
      }
    }
  }

  Future<void> _playCurrentSong(Emitter<AudioControlState> emit) async {
    if (_currentSelectedSong != null) {
      print('source              '+_currentSelectedSong!.fileSource.toString());
      final Source source = UrlSource(_currentSelectedSong!.fileSource ?? "");

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
