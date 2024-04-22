import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';

enum NewSongStatus { initial, success, error, loading }

extension NewSongStatusX on NewSongStatus {
  bool get isInitial => this == NewSongStatus.initial;
  bool get isSuccess => this == NewSongStatus.success;
  bool get isError => this == NewSongStatus.error;
  bool get isLoading => this == NewSongStatus.loading;
}

class NewSongState extends Equatable{

  const NewSongState({
    required this.status,
    required this.newSong,
  });

  static NewSongState initial() => const NewSongState(
      status: NewSongStatus.initial,
      newSong: <NewSongDataModel>[],
  );

  final NewSongStatus status;
  final List<NewSongDataModel> newSong;

  @override
  // TODO: implement props
  List<Object?> get props => [status, newSong];

  NewSongState copyWith({
    NewSongStatus? status,
    List<NewSongDataModel>? newMusic,
  }) {
    return NewSongState(
        status: status ?? this.status,
        newSong: newMusic ?? this.newSong,
    );
  }
}