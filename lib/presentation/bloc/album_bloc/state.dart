import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import '../../../data/model/singer_model.dart';

enum AlbumStatus { initial, success, error, loading }

extension MusicStatusX on AlbumStatus {
  bool get isInitial => this == AlbumStatus.initial;
  bool get isSuccess => this == AlbumStatus.success;
  bool get isError => this == AlbumStatus.error;
  bool get isLoading => this == AlbumStatus.loading;
}

class AlbumState extends Equatable{

  const AlbumState({
    required this.status,
    required this.newAlbum
  });

  static AlbumState initial() => const AlbumState(
    status: AlbumStatus.initial,
    newAlbum: <NewAlbumDataModel>[],
  );

  final AlbumStatus status;
  final List<NewAlbumDataModel> newAlbum;

  @override
  // TODO: implement props
  List<Object?> get props => [status, newAlbum];

  AlbumState copyWith({
    AlbumStatus? status,
    List<NewAlbumDataModel>? newAlbum
  }) {
    return AlbumState(
        status: status ?? this.status,
        newAlbum: newAlbum ?? this.newAlbum
    );
  }
}