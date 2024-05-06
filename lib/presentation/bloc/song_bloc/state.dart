// import 'package:equatable/equatable.dart';
// import 'package:turkish_music_app/data/model/song_model.dart';
// import 'package:turkish_music_app/data/model/new-song_model.dart';
// import 'package:turkish_music_app/data/model/new_album_model.dart';
// import '../../../data/model/singer_model.dart';
//
// enum SongStatus { initial, success, error, loading }
//
// extension SongStatusX on SongStatus {
//   bool get isInitial => this == SongStatus.initial;
//   bool get isSuccess => this == SongStatus.success;
//   bool get isError => this == SongStatus.error;
//   bool get isLoading => this == SongStatus.loading;
// }
//
// class SongState extends Equatable{
//
//   const SongState({
//     required this.status,
//     required this.song
//   });
//
//   static SongState initial() => const SongState(
//       status: SongStatus.initial,
//       song: null
//   );
//
//   final SongStatus status;
//   final List<SongDataModel>? song;
//   final List<SongModel>?
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [status, song];
//
//   SongState copyWith({
//     SongStatus? status,
//     List<SongDataModel>? songDetail
//   }) {
//     return SongState(
//       status: status ?? this.status,
//       song: songDetail ?? this.song
//     );
//   }
// }