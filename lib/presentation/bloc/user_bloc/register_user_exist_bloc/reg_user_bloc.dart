import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_music_app/presentation/bloc/user_bloc/register_user_exist_bloc/reg_user_state.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'reg_user_event.dart';

class RegUserExistBloc extends Bloc<RegUserExistEvent, RegUserExistState> {

  UserRepository userRepository = UserRepository();

  RegUserExistBloc(this.userRepository) : super(

      RegUserExistState.initial()){
    on<CheckUserExistEvent>(_mapCheckUserExistEventToState);
  }

  void _mapCheckUserExistEventToState(
      CheckUserExistEvent event, Emitter<RegUserExistState> emit) async {
    try {
      emit(state.copyWith(status: RegUserExistStatus.loading));

      final Map<String, dynamic> userExist = await userRepository.userExist(event.email);

      emit(
        state.copyWith(
          status: RegUserExistStatus.success,
          userExist: userExist["message"],
          userStatus: userExist["statusCode"]

        ),
      );
    } catch (error) {
      emit(state.copyWith(status: RegUserExistStatus.error));
    }
  }
}