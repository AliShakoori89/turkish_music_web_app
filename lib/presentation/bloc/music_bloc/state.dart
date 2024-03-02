import 'package:equatable/equatable.dart';
import '../../../data/model/singer_model.dart';

enum MusicStatus { initial, success, error, loading }

extension MusicStatusX on MusicStatus {
  bool get isInitial => this == MusicStatus.initial;
  bool get isSuccess => this == MusicStatus.success;
  bool get isError => this == MusicStatus.error;
  bool get isLoading => this == MusicStatus.loading;
}

class MusicState extends Equatable{

  const MusicState({
    required this.status,
    required this.famousArtist
  });

  static MusicState initial() => const MusicState(
      status: MusicStatus.initial,
      famousArtist: <SingerDataModel>[],
  );

  final MusicStatus status;
  final List<SingerDataModel> famousArtist;

  @override
  // TODO: implement props
  List<Object?> get props => [status, famousArtist];

  MusicState copyWith({
    MusicStatus? status,
    List<SingerDataModel>? famousArtist
  }) {
    return MusicState(
        status: status ?? this.status,
        famousArtist: famousArtist ?? this.famousArtist
    );
  }
}