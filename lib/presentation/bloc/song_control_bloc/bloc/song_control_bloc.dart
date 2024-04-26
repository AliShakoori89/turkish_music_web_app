// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';
// part 'song_control_event.dart';
// part 'song_control_state.dart';
//
// enum SongControlStatus { play, pause }
//
// class SongControlBloc extends Bloc<SongControlEvent, SongControlState> {
//   Stream<Duration> get positionStream => _audioPlayer.positionStream;
//
//   StreamSubscription? _audioStream;
//   final _audioPlayer = AudioPlayer();
//
//   AudioPlayer get audioPlayer => _audioPlayer;
//
//   SongControlBloc() : super(SongControlInitial()) {
//
//     on<SongCompleted>((event, emit) async {
//       emit(SongPausedState());
//     });
//
//     on<PlaySong>((event, emit) async {
//       await _audioPlayer.play();
//       emit(SongPlayedState());
//     });
//
//     on<PauseSong>((event, emit) async {
//       await _audioPlayer.pause();
//       emit(SongPausedState());
//     });
//
//     // on<ResumeSong>((event, emit) async {
//     //   await _audioPlayer.resume();
//     //   emit(SongPlayedState());
//     // });
//   }
//
//   stopAudio() async {
//     await _audioPlayer.stop();
//   }
//
//   seekTo(Duration position) async {
//     await _audioPlayer.seek(position);
//   }
//
//   @override
//   Future<void> close() {
//     _audioStream?.cancel();
//     _audioPlayer.dispose();
//     return super.close();
//   }
// }
