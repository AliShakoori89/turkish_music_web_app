import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/album_model.dart';
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
    required this.allAlbum,
    required this.newAlbum,
    required this.singerAllAlbum,
    required this.albumLength,
    required this.albumAllSongs
  });

  static AlbumState initial() => AlbumState(
    status: AlbumStatus.initial,
    allAlbum: <AlbumDataModel>[],
    newAlbum: <NewAlbumDataModel> [],
    singerAllAlbum: <AlbumDataModel>[],
    albumAllSongs: <AlbumDataMusicModel>[],
    albumLength: 0
  );

  final AlbumStatus status;
  final List<AlbumDataModel> allAlbum;
  final List<NewAlbumDataModel> newAlbum;
  final List<AlbumDataModel> singerAllAlbum;
  final List<AlbumDataMusicModel> albumAllSongs;
  final int albumLength;

  @override
  // TODO: implement props
  List<Object?> get props => [status, allAlbum, newAlbum, singerAllAlbum, albumLength, albumAllSongs];

  AlbumState copyWith({
    AlbumStatus? status,
    List<AlbumDataModel>? allAlbum,
    List<NewAlbumDataModel>? newAlbum,
    List<AlbumDataModel>? singerAllAlbum,
    List<AlbumDataMusicModel>? albumAllSongs,
    int? albumLength
  }) {
    return AlbumState(
      status: status ?? this.status,
      allAlbum: allAlbum ?? this.allAlbum,
      newAlbum: newAlbum ?? this.newAlbum,
      singerAllAlbum: singerAllAlbum ?? this.singerAllAlbum,
      albumLength: albumLength ?? this.albumLength,
      albumAllSongs: albumAllSongs ?? this.albumAllSongs
    );
  }
}