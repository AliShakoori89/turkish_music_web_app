import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_bloc/state.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'event.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {

  UserRepository userRepository = UserRepository();

  RegisterUserBloc(this.userRepository) : super(

      RegisterUserState.initial()){
    on<RegistrationUserEvent>(_mapRegisterUserEventToState);
    on<UserExistEvent>(_mapUserExistEventToState);
  }

  void _mapRegisterUserEventToState(
      RegistrationUserEvent event, Emitter<RegisterUserState> emit) async {
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

  void _mapUserExistEventToState(
      UserExistEvent event, Emitter<RegisterUserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final String? userExist = await userRepository.userExist(event.email);

      emit(
        state.copyWith(
            status: UserStatus.success,
            userExist: userExist
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}