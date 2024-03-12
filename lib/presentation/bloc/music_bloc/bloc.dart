import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import 'package:turkish_music_app/data/model/singer_model.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/music_bloc/state.dart';
import '../../../domain/repositories/music_repository.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {

  MusicRepository musicRepository = MusicRepository();

  MusicBloc(this.musicRepository) : super(
      MusicState.initial()){
  }

}