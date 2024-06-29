import 'package:equatable/equatable.dart';
import '../../../data/model/singer_model.dart';

enum SingerStatus { initial, success, error, loading }

extension SingerStatusX on SingerStatus {
  bool get isInitial => this == SingerStatus.initial;
  bool get isSuccess => this == SingerStatus.success;
  bool get isError => this == SingerStatus.error;
  bool get isLoading => this == SingerStatus.loading;
}

class SingerState extends Equatable{

  const SingerState({
    required this.status,
    required this.famousSinger,
    required this.allSinger,
    required this.allSingerName
  });

  static SingerState initial() => const SingerState(
      status: SingerStatus.initial,
      allSinger: <SingerDataModel>[],
      famousSinger: <SingerDataModel>[],
      allSingerName: <String>[],
  );

  final SingerStatus status;
  final List<SingerDataModel> famousSinger;
  final List<SingerDataModel> allSinger;
  final List<String> allSingerName;

  @override
  // TODO: implement props
  List<Object?> get props => [status, famousSinger, allSinger, allSingerName];

  SingerState copyWith({
    SingerStatus? status,
    List<SingerDataModel>? allSinger,
    List<SingerDataModel>? famousSinger,
    List<String>? allSingerName
  }) {
    return SingerState(
      status: status ?? this.status,
      allSinger: allSinger ?? this.allSinger,
      famousSinger: famousSinger ?? this.famousSinger,
      allSingerName: allSingerName ?? this.allSingerName
    );
  }
}