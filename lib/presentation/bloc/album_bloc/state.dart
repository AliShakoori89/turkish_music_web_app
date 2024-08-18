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
    required this.newAlbum,
    required this.singerAllAlbum,
    required this.albumLength,
    required this.albumAllSongs
  });

  static AlbumState initial() => AlbumState(
    status: AlbumStatus.initial,
    newAlbum: NewAlbumModel(
      message: "",
      data: [],
      lastPage: 0,
      success: false
    ),
    singerAllAlbum: <AlbumDataModel>[],
    albumAllSongs: <AlbumDataMusicModel>[],
    albumLength: 0
  );

  final AlbumStatus status;
  final NewAlbumModel newAlbum;
  final List<AlbumDataModel> singerAllAlbum;
  final List<AlbumDataMusicModel> albumAllSongs;
  final int albumLength;

  @override
  // TODO: implement props
  List<Object?> get props => [status, newAlbum, singerAllAlbum, albumLength, albumAllSongs];

  AlbumState copyWith({
    AlbumStatus? status,
    NewAlbumModel? newAlbum,
    List<AlbumDataModel>? singerAllAlbum,
    List<AlbumDataMusicModel>? albumAllSongs,
    int? albumLength
  }) {
    return AlbumState(
      status: status ?? this.status,
      newAlbum: newAlbum ?? this.newAlbum,
      singerAllAlbum: singerAllAlbum ?? this.singerAllAlbum,
      albumLength: albumLength ?? this.albumLength,
      albumAllSongs: albumAllSongs ?? this.albumAllSongs
    );
  }
}