import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SongRepository songRepo = SongRepository();
  final List<SongDataModel> songs = [];
  final List<SongDataModel> allSongs = [];

  SongBloc() : super(SongInitial()) {
    on<FetchNewSongs>((event, emit) async {
      try {
        await getAllNewSongs();
        emit(SongListLoaded(songList: songs));
      } catch (e) {
        emit(SongListErrorState(e.toString()));
      }
    });

    on<FetchAllSongs>((event, emit) async{
      try {
        await getAllSongs();
        emit(SongListLoaded(songList: allSongs));
      } catch (e) {
        emit(SongListErrorState(e.toString()));
      }
    });
  }

  getAllNewSongs() async {
    final songsList = await songRepo.getAllNewMusic();
    songs.addAll(songsList);
  }

  getAllSongs() async {
    final songsList = await songRepo.getAllMusic();
    allSongs.addAll(songsList);
  }
}
