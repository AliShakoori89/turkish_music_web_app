import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

enum DownloadStatus { initial, success, error, loading }

extension DownloadStatusX on DownloadStatus {
  bool get isInitial => this == DownloadStatus.initial;
  bool get isSuccess => this == DownloadStatus.success;
  bool get isError => this == DownloadStatus.error;
  bool get isLoading => this == DownloadStatus.loading;
}

class DownloadState extends Equatable{

  const DownloadState({
    required this.status,
    required this.downloadComplete,
  });

  static DownloadState initial() => const DownloadState(
    status: DownloadStatus.initial,
    downloadComplete: false,
  );

  final DownloadStatus status;
  final bool downloadComplete;

  @override
  // TODO: implement props
  List<Object?> get props => [status, downloadComplete];

  DownloadState copyWith({
    DownloadStatus? status,
    bool? downloadComplete,

  }) {
    return DownloadState(
      status: status ?? this.status,
      downloadComplete: downloadComplete ?? this.downloadComplete,

    );
  }
}