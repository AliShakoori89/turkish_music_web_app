import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/song_model.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';

enum SongControlStatus { play, pause }

class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {

  SongDataModel? _currentSelectedSong;

  SongDataModel? get currentSelectedSong => _currentSelectedSong;

  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  StreamSubscription? _audioStream;
  final _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioControlBloc() : super(AudioControlInitial()) {
    _audioStream = _audioPlayer.eventStream.listen((event) {
      if (event.position == event.duration) {
        add(SongCompleted());
      }
    });

    on<SongCompleted>((event, emit) async {
      final Source source = UrlSource(event.SongAlbumModel.musics ?? "");
      emit(PlayNextSong());
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

    on<ResumeSong>((event, emit) async {
      await _audioPlayer.resume();
      emit(AudioPlayedState());
    });

    on<PlayNextSong>((event, emit) async{
      emit(AudioLoadingNewSong());
      final SongDataModel nextSong;
      final index = getCurrentSongIndex(event.songs);
      if (index == event.songs.length - 1) {
        nextSong = event.songs.elementAt(0);
      } else {
        nextSong = event.songs.elementAt(index + 1);
      }
      _currentSelectedSong = nextSong;
      emit(SelectedSongFetched(songModel: nextSong));
    });
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
