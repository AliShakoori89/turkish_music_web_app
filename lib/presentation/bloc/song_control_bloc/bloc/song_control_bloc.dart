import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'song_control_event.dart';
part 'song_control_state.dart';

enum SongControlStatus { play, pause }

class SongControlBloc extends Bloc<SongControlEvent, SongControlState> {
  Stream<Duration> get positionStream => _audioPlayer.onPositionChanged;

  StreamSubscription? _audioStream;
  final _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  SongControlBloc() : super(SongControlInitial()) {

    on<SongCompleted>((event, emit) async {
      emit(SongPausedState());
    });

    on<PlaySong>((event, emit) async {
      final Source source = UrlSource(event.songFile ?? "");
      await _audioPlayer.play(source);
      emit(SongPlayedState());
    });

    on<PauseSong>((event, emit) async {
      await _audioPlayer.pause();
      emit(SongPausedState());
    });

    on<ResumeSong>((event, emit) async {
      await _audioPlayer.resume();
      emit(SongPlayedState());
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
}
