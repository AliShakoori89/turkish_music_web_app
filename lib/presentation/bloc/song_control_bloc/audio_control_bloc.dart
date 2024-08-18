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
    //   List<NewSongDataModel> songs = await newSongRepository.getNewMusic();
      // SongDataModel songDataModel = SongDataModel(
      //   id: songs[0].id,
      //   name: songs[0].id,
      //   singerName: songs[0].id,
      //   album: songs[0].id,
      //   albumId: songs[0].id,
      //   fileSource: songs[0].id,
      //   imageSource: songs[0].id,
      //   minute: songs[0].id,
      //   second: songs[0].id,
      // );
      // add(SongCompleted(songs: songDataModel));
    // });

    // on<SongCompleted>((event, emit) async {
    //   int i = getCurrentSongIndex(event.songs)+1;
    //   final Source source = UrlSource(event.songs[i].fileSource ?? "");
    //   await _audioPlayer.play(source);
    //   emit(AudioCompleteState());
    // });

    on<PlaySong>((event, emit) async {
      final Source source = UrlSource(event.currentSong.fileSource ?? "");
      await _audioPlayer.play(source)
          .whenComplete(
          (){
            print("11111111111111111111111111111111111111111111111111111111111111111111111111");
            // _audioPlayer.play(source);
            // var index = getCurrentSongIndex(event.currentAlbum);
            // final Source source = UrlSource(event.currentAlbum[index+1].fileSource ?? "");
            // _audioPlayer.play(source);
            // for(int i = 0 ; i < event.currentAlbum.length ; i++){
            //   if( event.currentAlbum[i].id == event.currentSong.id){
            //     final Source source = UrlSource(event.currentAlbum[i+1].fileSource ?? "");
            //     _audioPlayer.play(source);
            //   }
            //
            // }
          }
      );
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
  Future<void> close() async {
    if (_audioStream != null) {
      await _audioStream!.cancel(); // Use await to ensure it finishes
      _audioStream = null; // Optionally set to null for safety
    }
    await _audioPlayer.dispose(); // Use await for proper disposal
    return super.close();
  }

  getCurrentSongIndex(List<AlbumDataMusicModel> songs) {
    final currentSongIndex = songs.indexWhere((element) => element.id == _currentSelectedSong?.id);
    return currentSongIndex;
  }
}
