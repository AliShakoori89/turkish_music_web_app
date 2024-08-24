import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';

import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';
import '../../../domain/repositories/new_song_repository.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';

enum SongControlStatus { play, pause }

class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {

  NewSongRepository newSongRepository = NewSongRepository();

  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  StreamSubscription? _audioStream;

  final _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioControlBloc() : super(AudioControlInitial()) {

    // _audioStream = _audioPlayer.onPlayerComplete.listen((event) async{
    //   print("*********************************************************************");
    //   // _audioPlayer.resume();
    // });

    // on<SongCompleted>((event, emit) async {
    //   int i = getCurrentSongIndex(event.songs);
    //   print("iiiiiiiiiiiiiiiii            "+i.toString());
    //   final Source source = UrlSource(event.songs[i].fileSource ?? "");
    //   await _audioPlayer.play(source);
    // });

    on<PlaySong>((event, emit) async {
      final Source source = UrlSource(event.currentSong.fileSource ?? "");
      await _audioPlayer.play(source);
      emit(AudioPlayedState());
    });

    on<PlayNexttSong>((event, emit) async {
      int i = getCurrentSongIndex(event.currentAlbum, event.currentSong);
      print("iiiiiiiiiiiiiiiii            "+i.toString());
      final Source source = UrlSource(event.currentAlbum[i+1].fileSource ?? "");
      await _audioPlayer.play(source);
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
