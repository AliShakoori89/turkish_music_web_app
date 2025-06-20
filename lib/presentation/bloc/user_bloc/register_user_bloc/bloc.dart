import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_bloc/state.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'event.dart';

class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {

  UserRepository userRepository = UserRepository();

  RegisterUserBloc(this.userRepository) : super(

      RegisterUserState.initial()){
    on<RegistrationUserEvent>(_mapRegisterUserEventToState);
  }

  void _mapRegisterUserEventToState(
      RegistrationUserEvent event, Emitter<RegisterUserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      var requestPublic = await userRepository.requestPublic(event.email);

      emit(
        state.copyWith(
          status: UserStatus.success,
          requestPublic: requestPublic == 'success' ? true : false
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}