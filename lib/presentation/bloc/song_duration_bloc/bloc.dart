// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:turkish_music_app/presentation/bloc/song_duration_bloc/state.dart';
// import '../../../domain/repositories/song_duration_repository.dart';
// import 'event.dart';
//
// class SongDurationBloc extends Bloc<SongDurationEvent, SongDurationState> {
//
//   SongDurationRepository songDurationRepository = SongDurationRepository();
//
//   SongDurationBloc(this.songDurationRepository) : super(
//       SongDurationState.initial()){
//     on<GetSongDurationEvent>(_mapGetNewMusicEventToState);
//   }
//
//   void _mapGetNewMusicEventToState(
//       GetSongDurationEvent event, Emitter<SongDurationState> emit) async {
//     try {
//       emit(state.copyWith(status: SongTimeStatus.loading));
//       double songDuration = await songDurationRepository.getSongDuration(event.songFilePath, event.audioPlayer);
//
//       print("*****************************           "+songDuration.toString());
//       emit(
//         state.copyWith(
//             status: SongTimeStatus.success,
//             songDuration: songDuration
//             // songDuration: songDuration
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: SongTimeStatus.error));
//     }
//   }
// }