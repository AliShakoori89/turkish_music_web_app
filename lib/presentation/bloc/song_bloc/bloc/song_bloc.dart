import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/song_model.dart';
import 'package:turkish_music_app/domain/repositories/song_repository.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final SongRepository songRepo = SongRepository();
  final List<SongDataModel> songs = [];

  SongBloc() : super(SongInitial()) {
    on<FetchNewSongs>((event, emit) async {
      try {
        await getAllSongs();

        print("songssssssssssssssssssssssss                  "+songs.toString());
        emit(SongListLoaded(songList: songs));
      } catch (e) {
        emit(SongListErrorState(e.toString()));
      }
    });

    on<FetchAllSongs>((event, emit) {
      emit(SongLoading());
      emit(SongListLoaded(songList: songs));
    });
  }

  getAllSongs() async {
    final songsList = await songRepo.getAllNewMusic();
    print("songsList:                "+songsList.toString());
    songs.addAll(songsList);
  }
}
