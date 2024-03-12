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
  });

  static SingerState initial() => const SingerState(
      status: SingerStatus.initial,
      famousSinger: <SingerDataModel>[]
  );

  final SingerStatus status;
  final List<SingerDataModel> famousSinger;

  @override
  // TODO: implement props
  List<Object?> get props => [status, famousSinger];

  SingerState copyWith({
    SingerStatus? status,
    List<SingerDataModel>? famousSinger,
  }) {
    return SingerState(
        status: status ?? this.status,
        famousSinger: famousSinger ?? this.famousSinger
    );
  }
}