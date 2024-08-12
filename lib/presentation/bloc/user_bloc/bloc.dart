import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/data/model/user_model.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/state.dart';
import '../../../domain/repositories/user_repository.dart';
import 'event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  UserRepository userRepository = UserRepository();

  UserBloc(this.userRepository) : super(

      UserState.initial()){
    on<RegisterUserEvent>(_mapRegisterUserEventToState);
    on<FirstLoginEvent>(_mapFirstLoginEventToState);
    on<SecondLoginEvent>(_mapSecondLoginEventToState);
    on<GetCurrentUserEvent>(_mapGetCurrentUserEventToState);
    on<ExitAccountEvent>(_mapExitAccountEventToState);
  }

  void _mapRegisterUserEventToState(
      RegisterUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      await userRepository.requestPublic(event.email);

      emit(
        state.copyWith(
          status: UserStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapFirstLoginEventToState(
      FirstLoginEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final bool? firstLoginStatus = await userRepository.firstLogin(event.email);

      emit(
        state.copyWith(
          status: UserStatus.success,
          firstRegisterStatus: firstLoginStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapSecondLoginEventToState(
      SecondLoginEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final bool? secondLoginStatus = await userRepository.secondLogin(event.email, event.verificationToken);

      emit(
        state.copyWith(
            status: UserStatus.success,
            secondRegisterStatus: secondLoginStatus
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapGetCurrentUserEventToState(
      GetCurrentUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final UserModel currentUser = await userRepository.getCurrentUser();

      emit(
        state.copyWith(
            status: UserStatus.success,
          user: currentUser
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapExitAccountEventToState(
      ExitAccountEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final bool isExit = await userRepository.removeAccessTokenValue();

      emit(
        state.copyWith(
          status: UserStatus.success,
          isExit: isExit
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}