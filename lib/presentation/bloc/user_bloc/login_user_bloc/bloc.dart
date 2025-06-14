import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_bloc/state.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'event.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {

  UserRepository userRepository = UserRepository();

  LoginUserBloc(this.userRepository) : super(

      LoginUserState.initial()){
    on<FirstLoginEvent>(_mapFirstLoginEventToState);
    on<SecondLoginEvent>(_mapSecondLoginEventToState);
  }

  void _mapFirstLoginEventToState(
      FirstLoginEvent event, Emitter<LoginUserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      print('22222222222222');

      final String? firstLoginStatus = await userRepository.firstStepLogin(event.email);

      emit(
        state.copyWith(
          status: UserStatus.success,
          firstRegisterStatus: firstLoginStatus == 'success' ? true : false
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }

  void _mapSecondLoginEventToState(
      SecondLoginEvent event, Emitter<LoginUserState> emit) async {
    try {
      emit(state.copyWith(status: UserStatus.loading));

      final String? secondLoginStatus = await userRepository.secondLogin(event.email, event.verificationToken);

      emit(
        state.copyWith(
            status: UserStatus.success,
            secondRegisterStatus: secondLoginStatus == 'success' ? true : false
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: UserStatus.error));
    }
  }
}