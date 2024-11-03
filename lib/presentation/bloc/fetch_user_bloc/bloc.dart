import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/user_model.dart';
import 'package:turkish_music_app/presentation/bloc/fetch_user_bloc/state.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/state.dart';
import '../../../domain/repositories/user_repository.dart';
import 'event.dart';

class FetchUserBloc extends Bloc<FetchUserEvent, FetchUserState> {

  UserRepository userRepository = UserRepository();

  FetchUserBloc(this.userRepository) : super(

      FetchUserState.initial()){
    on<GetCurrentUserEvent>(_mapGetCurrentUserEventToState);
    on<ExitAccountEvent>(_mapExitAccountEventToState);
  }

  void _mapGetCurrentUserEventToState(
      GetCurrentUserEvent event, Emitter<FetchUserState> emit) async {
    try {
      emit(state.copyWith(status: FetchUserStatus.loading));

      final UserModel currentUser = await userRepository.getCurrentUser();

      emit(
        state.copyWith(
          status: FetchUserStatus.success,
          user: currentUser
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: FetchUserStatus.error));
    }
  }

  void _mapExitAccountEventToState(
      ExitAccountEvent event, Emitter<FetchUserState> emit) async {
    try {
      emit(state.copyWith(status: FetchUserStatus.loading));

      final bool isExit = await userRepository.removeAccessTokenValue();

      emit(
        state.copyWith(
          status: FetchUserStatus.success,
          isExit: isExit
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: FetchUserStatus.error));
    }
  }
}