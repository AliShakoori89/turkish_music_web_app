import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/domain/repositories/internet_repository.dart';
import 'package:turkish_music_app/presentation/bloc/internet_conection_bloc/state.dart';
import 'event.dart';

class InternetConnectionBloc extends Bloc<InternetConnectionEvent, InternetConnectionState> {

  InternetConnectionRepository internetConnectionRepository = InternetConnectionRepository();

  InternetConnectionBloc(this.internetConnectionRepository) : super(
      InternetConnectionState.initial()){
    on<CheckInternetConnectionEvent>(_mapCheckInternetConnectionEventToState);
  }

  void _mapCheckInternetConnectionEventToState(
      CheckInternetConnectionEvent event, Emitter<InternetConnectionState> emit) async {
    try {
      emit(state.copyWith(status: InternetConnectionStatus.loading));
      bool onlineMode = await internetConnectionRepository.checkInternetConnection();

      emit(
        state.copyWith(
            status: InternetConnectionStatus.success,
            internetConnectionStatus: onlineMode
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: InternetConnectionStatus.error));
    }
  }
}