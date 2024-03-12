import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/new-song_model.dart';
import 'package:turkish_music_app/data/model/new_album_model.dart';
import '../../../data/model/singer_model.dart';

enum NewMusicStatus { initial, success, error, loading }

extension NewMusicStatusX on NewMusicStatus {
  bool get isInitial => this == NewMusicStatus.initial;
  bool get isSuccess => this == NewMusicStatus.success;
  bool get isError => this == NewMusicStatus.error;
  bool get isLoading => this == NewMusicStatus.loading;
}

class NewMusicState extends Equatable{

  const NewMusicState({
    required this.status,
    required this.newMusic,
  });

  static NewMusicState initial() => const NewMusicState(
      status: NewMusicStatus.initial,
      newMusic: <NewMusicDataModel>[],
  );

  final NewMusicStatus status;
  final List<NewMusicDataModel> newMusic;

  @override
  // TODO: implement props
  List<Object?> get props => [status, newMusic];

  NewMusicState copyWith({
    NewMusicStatus? status,
    List<NewMusicDataModel>? newMusic,
  }) {
    return NewMusicState(
        status: status ?? this.status,
        newMusic: newMusic ?? this.newMusic,
    );
  }
}