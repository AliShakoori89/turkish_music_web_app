import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';

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
    _audioStream = _audioPlayer.onPlayerComplete.listen((event) async{
      List<NewSongDataModel> songs = await newSongRepository.getNewMusic();
      SongDataModel songDataModel = SongDataModel(
        id: NewSongDataModel[].id,
        name: ,
        singerName: ,
        album: ,
        albumId: ,
        fileSource: ,
        imageSource: ,
        minute: ,
        second: ,
      );
      add(SongCompleted(songs: songs));
    });

    on<SongCompleted>((event, emit) async {
      int i = getCurrentSongIndex(event.songs)+1;
      print("iiiiiiiiiiiiiiiiiiiii                          "+i.toString());
      final Source source = UrlSource(event.songs[i].fileSource ?? "");
      await _audioPlayer.play(source);
      emit(AudioCompleteState());
    });

    on<PlaySong>((event, emit) async {
      final Source source = UrlSource(event.currentSong.fileSource ?? "");
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

    // on<PlayNextSong>((event, emit) {
    //   emit(AudioLoadingNewSong());
    //   final SongDataModel nextSong;
    //   final index = getCurrentSongIndex(event.songs);
    //   if (index == event.songs.length - 1) {
    //     nextSong = event.songs.elementAt(0);
    //   } else {
    //     nextSong = event.songs.elementAt(index + 1);
    //   }
    //   _currentSelectedSong = nextSong;
    //   emit(AudioSelectedSongFetched(songModel: nextSong));
    // });

  }

  stopAudio() async {
    await _audioPlayer.stop();
  }

  seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _audioStream?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }

  getCurrentSongIndex(List<SongDataModel> songs) {
    final currentSongIndex = songs.indexWhere((element) => element.id == _currentSelectedSong?.id);
    return currentSongIndex;
  }
}
