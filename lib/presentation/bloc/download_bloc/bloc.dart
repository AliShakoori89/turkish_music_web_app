import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/download_repository.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/event.dart';
import 'package:turkish_music_app/presentation/bloc/download_bloc/state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {

  DownloadRepository downloadRepository = DownloadRepository();

  DownloadBloc(this.downloadRepository) : super(
      DownloadState.initial()){
    on<DownloadFileEvent>(_mapDownloadFileEventToState);
  }

  void _mapDownloadFileEventToState(
      DownloadFileEvent event, Emitter<DownloadState> emit) async {
    try {
      emit(state.copyWith(status: DownloadStatus.loading));

      await downloadRepository.downloadFile(event.songFilePath, event.songName, event.platform);

      emit(
        state.copyWith(
          status: DownloadStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: DownloadStatus.error));
    }
  }
}