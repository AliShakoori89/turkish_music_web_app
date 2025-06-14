import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/login_user_exist_bloc/login_user_state.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_exist_bloc/reg_user_state.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'login_user_event.dart';

class LoginUserExistBloc extends Bloc<LoginUserExistEvent, LoginUserExistState> {

  UserRepository userRepository = UserRepository();

  LoginUserExistBloc(this.userRepository) : super(

      LoginUserExistState.initial()){
    on<CheckUserExistEvent>(_mapCheckUserExistEventToState);
  }

  void _mapCheckUserExistEventToState(
      CheckUserExistEvent event, Emitter<LoginUserExistState> emit) async {
    try {
      emit(state.copyWith(status: LoginUserExistStatus.loading));

      final Map<String, dynamic> userExist = await userRepository.userExist(event.email);

      emit(
        state.copyWith(
          status: LoginUserExistStatus.success,
          userExist: userExist["message"],
          userStatus: userExist["statusCode"]

        ),
      );
    } catch (error) {
      emit(state.copyWith(status: LoginUserExistStatus.error));
    }
  }
}